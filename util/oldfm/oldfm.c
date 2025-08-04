/*
 * OldFM
 * Load OldDark FMs with FMSel.
 */

#define _XOPEN_SOURCE 600
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#ifdef _WIN32
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <direct.h>
#include <windows.h>
#include "fmsel.h"
#define DIRSEP "\\"
#define MAX_PATH_BUF MAX_PATH
#define S(s) S_(s)
#define S_(s) L##s
#else
#include <fmsel.h>
#include <limits.h>
#include <sys/wait.h>
#include <unistd.h>
#define DIRSEP "/"
// On *nix, path names can actually be larger than this length, but it should
// still be a reasonable buffer size.
#define MAX_PATH_BUF PATH_MAX
#define SH_PATH "/bin/sh"
#define S(s) S_(s)
#define S_(s) #s
#endif

// constant strings
#define OFM_CFG "oldfm.ini"
#define DEF_LANG "english+german+french"
#define INST_CFG "oldinst.cfg" // Can be changed to "darkinst.cfg" or
							   // "install".cfg to use the unmodified
							   // executables.

// buffer widths
#define MAX_CFG_BUF 64 // NewDark also defines nMaxNameLen as 64.
#define MAX_LINE_BUF 128 // Should, naturally, be larger than MAX_CFG_BUF.

// error status
#define OFM_ERR_WARN 0
#define OFM_ERR_FATAL 1

// return codes
#define OFM_RET_ERR -1
#define OFM_RET_SUCCESS 0

#ifdef _WIN32
// inlined functions
inline int widen(const char *s, LPWSTR *sW)
{
	const int sizeW = MultiByteToWideChar(CP_UTF8, 0, (LPSTR) s, -1, NULL, 0);
	if (0 == sizeW || NULL == (*sW = (LPWSTR) malloc(sizeW * sizeof(WCHAR))))
		return OFM_RET_ERR;
	if (0 == MultiByteToWideChar(CP_UTF8, 0, (LPSTR) s, -1, *sW, sizeW))
	{
		free(*sW);
		return OFM_RET_ERR;
	}
	return OFM_RET_SUCCESS;
}
#endif

// prototypes
int ChangeToBinDir(void);
#ifdef _WIN32
void ShowError(LPCWSTR messageW, const int fatal);
#else
void ShowError(const char *message, const int fatal);
#endif
int LoadConfig(void);
int StartFMSel(int *status);
int SetFM(const char *fmname);
int StartGame(int *result);
int AppendPath(char *path, const char *append);
int GetLang(const char *path, char *lang);
int SetCFG(const char *path, const char *fmdir, const char *fmname,
	const char *lang);

// globals
char g_gameName[MAX_CFG_BUF] = "Thief 2 1.18";
#ifdef _WIN32
char g_gameBinary[MAX_CFG_BUF] = "thief2_ddfix.exe";
#else
char g_gameBinary[MAX_CFG_BUF] = "thief2_ddfix.sh";
#endif
char g_FMDir[MAX_CFG_BUF] = "OldFMs";
char g_FMName[MAX_CFG_BUF] = "";

/*
 * main:
 * Entry point.
 * Return value: The game's exit code on success and OFM_RET_ERR on failure.
 */
#ifdef _WIN32
int wmain(void)
#else
int main(void)
#endif
{
	if (OFM_RET_ERR == ChangeToBinDir())
	{
		ShowError(S("Failed to get the program directory."), OFM_ERR_FATAL);
		return OFM_RET_ERR;
	}
	if (OFM_RET_ERR == LoadConfig())
		ShowError(S("Failed to create path to configuration file."),
			OFM_ERR_WARN);
	int status;
	int success = OFM_RET_ERR;
	int exit = 0;
	if (OFM_RET_ERR != StartFMSel(&status))
	{
		switch (status)
		{
			// Set the FM and start the game on kSelFMRet_OK.
			// Start the game without an FM or use the FM specified in the
			// global configuration on kSelFMRet_Cancel.
			// NOTE: Fall through since the required sequence of actions is the
			// same as a result of g_FMName only being modified when the status
			// is kSelFMRet_OK.
			case kSelFMRet_OK:
			case kSelFMRet_Cancel:
				success = SetFM(g_FMName);
				if (OFM_RET_SUCCESS == success)
				{
					success = StartGame(&exit);
					if (success == OFM_RET_ERR)
						ShowError(S("FMSel closed normally and the active FM")
							S(" was modified, but the game could not be")
							S(" started or exited abnormally."), OFM_ERR_FATAL);
				}
				else
					ShowError(S("FMSel closed normally, but the active FM")
						S(" could not be modified."), OFM_ERR_FATAL);
				break;
			// Exit the program otherwise.
			case kSelFMRet_ExitGame:
			default:
				success = SetFM("");
				// Show as a warning even though this impacts the return code.
				if (OFM_RET_ERR == success)
					ShowError(S("FMSel closed normally, but the active FM"
						S(" could not be cleared when exiting.")),
						OFM_ERR_WARN);
				break;
		}
	}
	else
		ShowError(S("FMSel could not be started or exited abnormally."),
			OFM_ERR_FATAL);
#ifndef _WIN32
	puts("");
#endif
	return success == OFM_RET_SUCCESS ? exit : OFM_RET_ERR;
}

/*
 * ChangeToBinDir:
 * Changes the current working directory to the directory from which the binary
 * is running.
 * Return value: OFM_RET_SUCCESS on success and OFM_RET_ERR on failure.
 */
int ChangeToBinDir(void)
{
#ifdef _WIN32
	WCHAR path[MAX_PATH_BUF];
	if (0 == GetModuleFileNameW(NULL, path, MAX_PATH_BUF))
		return OFM_RET_ERR;
	LPWSTR sep = wcsrchr(path, '\\');
	// NOTE: There should always be a directory separator, though there does not
	// necessarily need to be one in this case.
	if (NULL != sep)
		*sep = '\0';
	int ret = _wchdir(path);
#else
	char path[MAX_PATH_BUF];
	ssize_t bytesWritten;
#if defined(__linux__) || defined(__LINUX__)
	if (-1 == (bytesWritten = readlink("/proc/self/exe", path,
		MAX_PATH_BUF - 1)))
		return OFM_RET_ERR;
#elif defined(__unix__) || defined(__UNIX__) \
	|| (defined(__APPLE__) && defined(__MACH__))
#include <sys/param.h>
#if defined(BSD)
	if (-1 == (bytesWritten = readlink("/proc/curproc/file", path,
		MAX_PATH_BUF - 1)))
		return OFM_RET_ERR;
#else
#error "Cannot get binary path on target. See ChangeToBinDir for details."
#endif
#else
#error "Cannot get binary path on target. See ChangeToBinDir for details."
#endif
	path[bytesWritten] = '\0';
	char *sep = strrchr(path, '/');
	// NOTE: See previous.
	if (NULL != sep)
		*sep = '\0';
	int ret = chdir(path);
#endif
	return (0 == ret) ? OFM_RET_SUCCESS : OFM_RET_ERR;
}

/*
 * ShowError:
 * Show a message either as a warning or as a fatal error.
 * Return value: None.
 * This takes the form of a message box on Windows and colored text over stdout
 * elsewhere. It takes a wide string on Windows since the narrow versions
 * of the relevant API calls do not support UTF-8.
 */
#ifdef _WIN32
void ShowError(LPCWSTR messageW, const int fatal)
{
	if (fatal)
		MessageBoxW(NULL, messageW, L"Fatal Error", MB_ICONERROR | MB_OK);
	else
		MessageBoxW(NULL, messageW, L"Warning", MB_ICONWARNING | MB_OK);
}
#else
void ShowError(const char *message, const int fatal)
{
	if (fatal)
		printf("\033[0;31mFatal Error:");
	else
		printf("\033[0;33mWarning:");
	printf("\033[0m %s\n", message);
}
#endif

/*
 * LoadConfig:
 * Loads relevant configuration variables from oldfm.ini.
 * Return value: OFM_RET_SUCCESS on success and OFM_RET_ERR on failure.
 * Some variables being absent is not sufficient for failure, as defaults are
 * used otherwise.
 */
int LoadConfig(void)
{
	char path[MAX_PATH_BUF];
	strcpy(path, "." DIRSEP);
	if (OFM_RET_ERR == AppendPath(path, OFM_CFG))
		return OFM_RET_ERR;
#ifdef _WIN32
	LPWSTR pathW;
	if (OFM_RET_ERR == widen(path, &pathW))
		return OFM_RET_ERR;
	FILE *f = _wfopen(pathW, L"rb");
	free(pathW);
#else
	FILE *f = fopen(path, "r");
#endif
	if (NULL != f)
	{
		char buf[MAX_LINE_BUF];
		char *vars[4] = {g_gameName, g_gameBinary, g_FMDir, g_FMName};
		const char *keys[4] = {"game_name ", "game_exe ", "fm_dir ", "fm "};
		while (NULL != fgets(buf, sizeof(buf), f))
		{
			for (size_t i = 0; i < 4; i++)
			{
				size_t keyLen = strlen(keys[i]);
				if (!strncmp(buf, keys[i], keyLen))
				{
					char *start;
					char *end = start = buf + keyLen;
					// Allow characters according to the following rules.
					// game_name: All non-control characters.
					// game_exe: All valid path characters that are not also
					// control characters, excluding "." and "..".
					// fm_dir and fm: All valid ASCII Windows path characters
					// that are not also control characters, excluding "." and
					// "..".
					if (vars[i] == g_gameName)
					{
						while (!iscntrl(*end))
							end++;
					}
					else if (vars[i] == g_gameBinary)
					{
#ifdef _WIN32
						while (!iscntrl(*end)
							&& NULL == strchr("<>:\"/\\|?*", *end))
							end++;
#else
						while (!iscntrl(*end) && NULL == strchr("/", *end))
							end++;
#endif
					}
					else if (vars[i] == g_FMDir || vars[i] == g_FMName)
					{
						while (!iscntrl(*end)
							&& NULL == strchr("<>:\"/\\|?*", *end)
							&& !(*end & 0x80))
							end++;
					}
					// Make sure the next character is a control character.
					if (!iscntrl(*end))
						break;
					*end = '\0';
					// Ensure the new string fits in the buffer, is not empty,
					// and is not "." or ".." in the case of the path fields.
					// If it meets these criteria, copy it to the global
					// configuration.
					size_t cfgLen = strlen(start);
#ifdef _WIN32
					if (vars[i] != g_gameName && (!strcmp(start, ".")
						|| !strcmp(start, "..") || start[cfgLen - 1] == '.'))
#else
					if (vars[i] != g_gameName && (!strcmp(start, ".")
						|| !strcmp(start, "..") || (vars[i] != g_gameBinary
						&& start[cfgLen - 1] == '.')))
#endif
						break;
					if (cfgLen < MAX_CFG_BUF && cfgLen > 0)
						strcpy(vars[i], start);
					break;
				}
			}
		}
		fclose(f);
	}
	return OFM_RET_SUCCESS;
}

/*
 * StartFMSel:
 * Prepares the FM data structure and starts the FM selector.
 * Return value: OFM_RET_SUCCESS on success and OFM_RET_ERR on failure.
 * The integer pointed to by status will be populated with the return code
 * provided by the FM selector API.
 * On Windows, the FM selector is assumed to be a DLL named fmsel.dll, whereas
 * on all other systems the FM selector is assumed to be linked either
 * statically or dynamically.
 */
int StartFMSel(int *status)
{
	sFMSelectorData data;
	int selected = g_FMName[0] != '\0';
	// Use a null character for sLanguage and sModExcludePaths since the
	// selector may try to dereference the pointers even when the length
	// parameter is zero.
	char nullCh = '\0';
	data.nStructSize = sizeof(sFMSelectorData);
	data.sGameVersion = g_gameName;
	// NOTE: It is permissible to use this as-is (without leading ./ or .\\)
	// since FMSel interprets this relative to the CWD, which was already set
	// appropriately.
	data.sRootPath = g_FMDir;
	// NOTE: NewDark defines this as 260, which is MAX_PATH on Windows.
	// However, since only up to MAX_CFG_BUF lines are parsed from the config
	// file, it makes more sense to use that instead.
	data.nMaxRootLen = MAX_CFG_BUF;
	data.sName = g_FMName;
	// NOTE: NewDark defines this as 64, which is MAX_CFG_BUF by default.
	data.nMaxNameLen = MAX_CFG_BUF;
	data.sModExcludePaths = &nullCh;
	data.nMaxModExcludeLen = 0;
	data.sLanguage = &nullCh;
	data.nLanguageLen = 0;
	data.bForceLanguage = 0;
#ifdef _WIN32
	if (selected)
		*status = kSelFMRet_OK;
	else
	{
		int (*SelectFM)(sFMSelectorData *data);
		HMODULE hDll;
		if (NULL == (hDll = LoadLibraryW(L"fmsel.dll"))
			|| NULL == (*(void **)(&SelectFM)
				= GetProcAddress(hDll, "SelectFM")))
			return OFM_RET_ERR;
		*status = SelectFM(&data);
	}
#else
	*status = selected ? kSelFMRet_OK : SelectFM(&data);
#endif
	return OFM_RET_SUCCESS;
}

/*
 * SetFM:
 * Sets the necessary configuration variables to allow the FM described by
 * fmname to run the next time the game is started.
 * Return value: OFM_RET_SUCCESS on success and OFM_RET_ERR on failure.
 * Setting fname to an empty, non-null string will reset the game configuration.
 */
int SetFM(const char *fmname)
{
	char path[MAX_PATH_BUF];
	char lang[MAX_CFG_BUF] = DEF_LANG;
	strcpy(path, "." DIRSEP);
	if (OFM_RET_ERR == AppendPath(path, INST_CFG))
		return OFM_RET_ERR;
	if (OFM_RET_ERR == GetLang(path, lang))
		ShowError(S("Could not retrieve set language. Using default."),
			OFM_ERR_WARN);
	return SetCFG(path, fmname[0] == '\0' ? "" : g_FMDir, fmname, lang);
}

/*
 * StartGame:
 * Starts the game.
 * Return value: OFM_RET_SUCCESS on success and OFM_RET_ERR on failure.
 * The integer pointed to by result will be populated with the exit code of the
 * executable to be run on success.
 */
int StartGame(int *result)
{
	char path[MAX_PATH_BUF];
	strcpy(path, "." DIRSEP);
#ifdef _WIN32
	if (NULL == strchr(g_gameBinary, '.')
		&& strlen(g_gameBinary) + 4 < MAX_CFG_BUF)
		strcat(g_gameBinary, ".exe");
	if (OFM_RET_ERR == AppendPath(path, g_gameBinary))
		return OFM_RET_ERR;
	STARTUPINFOW si;
	PROCESS_INFORMATION pi;
	ZeroMemory(&si, sizeof(si));
	si.cb = sizeof(si);
	ZeroMemory(&pi, sizeof(pi));
	LPWSTR pathW;
	if (OFM_RET_ERR == widen(path, &pathW))
		return OFM_RET_ERR;
	if (!CreateProcessW(NULL, pathW, NULL, NULL, FALSE, 0, NULL, NULL, &si,
			&pi))
	{
		free(pathW);
		return OFM_RET_ERR;
	}
	free(pathW);
	WaitForSingleObject(pi.hProcess, INFINITE);
	if (!GetExitCodeProcess(pi.hProcess, (LPDWORD) result))
		return OFM_RET_ERR;
	CloseHandle(pi.hProcess);
	CloseHandle(pi.hThread);
#else
	if (OFM_RET_ERR == AppendPath(path, g_gameBinary)
		|| -1 == access(path, R_OK | X_OK))
		return OFM_RET_ERR;
	// If the game binary name has the "sh" extension, run it with the default
	// shell.
	const int sh = strlen(g_gameBinary) > 3
		&& !strcmp(g_gameBinary + strlen(g_gameBinary) - 3, ".sh");
	const char *bin = sh ? SH_PATH : g_gameBinary;
	const pid_t pid = fork();
	if (pid < 0)
		return OFM_RET_ERR;
	if (0 == pid)
	{
		if ((sh && -1 == execl(bin, bin, path, NULL))
			|| (!sh && -1 == execl(bin, bin, NULL)))
			return OFM_RET_ERR;
	}
	int status;
	if (-1 == waitpid(pid, &status, 0) || !WIFEXITED(status))
		return OFM_RET_ERR;
	*result = WEXITSTATUS(status);
#endif
	return OFM_RET_SUCCESS;
}

/*
 * AppendPath:
 * Appends the provided directory or file name to the provided path.
 * Return value: OFM_RET_SUCCESS on success and OFM_RET_ERR on failure.
 * The resulting combined path is placed back in the provided path buffer,
 * which is assumed to be MAX_PATH_BUF bytes wide.
 */
int AppendPath(char *path, const char *append)
{
	const size_t pathLen = strlen(path);
	if (MAX_PATH_BUF - pathLen < strlen(append) + 2)
		return OFM_RET_ERR;
	path[pathLen] = DIRSEP[0];
	path[pathLen + 1] = '\0';
	strcat(path, append);
	return OFM_RET_SUCCESS;
}

/*
 * GetLang:
 * Gets the language from the file provided in path.
 * Return value: OFM_RET_SUCCESS on success and OFM_RET_ERR on failure.
 * On success, the found language string is copied to the lang buffer, which is
 * assumed to be MAX_CFG_BUF bytes wide.
 */
int GetLang(const char *path, char *lang)
{
	int ret = OFM_RET_ERR;
#ifdef _WIN32
	FILE *f = NULL;
	LPWSTR pathW;
	if (OFM_RET_ERR != widen(path, &pathW))
	{
		f = _wfopen(pathW, L"rb");
		free(pathW);
	}
#else
	FILE *f = fopen(path, "r");
#endif
	if (NULL != f)
	{
		const char *key = "language ";
		char buf[MAX_LINE_BUF];
		while (NULL != fgets(buf, sizeof(buf), f))
		{
			size_t keyLen = strlen(key);
			if (strncmp(buf, key, keyLen))
				continue;
			// Trim the left side of the string.
			while (isspace(*(buf + keyLen)))
				keyLen++;
			char *start;
			char *end = start = buf + keyLen;
			// Allow only alphabetic characters and '+'.
			while (isalpha(*end) || *end == '+')
				end++;
			// Make sure the next character is a control character or a space.
			if (!iscntrl(*end) && !isspace(*end))
				break;
			*end = '\0';
			const size_t cfgLen = strlen(start);
			if (cfgLen < MAX_CFG_BUF && cfgLen > 0)
			{
				strcpy(lang, start);
				ret = OFM_RET_SUCCESS;
				break;
			}
		}
		fclose(f);
	}
	return ret;
}

/*
 * SetCFG:
 * Rewrites the install configuration file provided in path to correctly account
 * for the FM directory described by fmdir, the FM described by fmname, and the
 * current language described by lang.
 * Return value: OFM_RET_SUCCESS on success and OFM_RET_ERR on failure.
 */
int SetCFG(const char *path, const char *fmdir, const char *fmname,
	const char *lang)
{
	int ret = OFM_RET_ERR;
#ifdef _WIN32
	FILE *f = NULL;
	LPWSTR pathW;
	if (OFM_RET_ERR != widen(path, &pathW))
	{
		f = _wfopen(pathW, L"wb");
		free(pathW);
	}
#else
	FILE *f = fopen(path, "w");
#endif
	if (NULL != f)
	{
		if (fmdir[0] != '\0' && fmname[0] != '\0')
		{
#ifdef _WIN32
			// NOTE: It is permissible to use the non-wide version since the FM
			// name, directory, and language are guaranteed to be ASCII-only.
			if (_fprintf_p(f,
#else
			if (fprintf(f,
#endif
				"install_path .\\%1$s\\%2$s+.\\\r\n"
				"language %3$s\r\n"
				"resname_base .\\%1$s\\%2$s+.\\+.\\RES\r\n"
				"load_path .\\%1$s\\%2$s+.\\\r\n"
				"script_module_path .\\%1$s\\%2$s+.\\\r\n"
				"movie_path .\\%1$s\\%2$s\\MOVIES+.\\MOVIES\r\n",
				fmdir, fmname, lang) > 0)
				ret = OFM_RET_SUCCESS;
		}
		else
		{
			// NOTE: See previous.
			if (fprintf(f,
				"install_path .\\\r\n"
				"language %s\r\n"
				"resname_base .\\+.\\RES\r\n"
				"load_path .\\\r\n"
				"script_module_path .\\\r\n"
				"movie_path .\\MOVIES\r\n",
				lang) > 0)
				ret = OFM_RET_SUCCESS;
		}
		fclose(f);
	}
	return ret;
}

