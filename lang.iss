; Handle preprocessing of languages files.

#if Ver < 0x06000000
#define NewLine ""
#pragma parseroption -p-
#define SaveStringToFile(Output, Input, Append, Unused) \
  Local[0] = "cmd.exe", \
  Local[1] = "/c echo:" + Input, \
  Local[1] = StringChange(Local[1], "\xEF\xBB\xBF", ""), \
  Local[2] = """" + Output + """", \
  Append == 1 ? \
    Exec(Local[0], Local[1] + " >> " + Local[2], , , SW_HIDE) \
    : Len(Input) > 0 ? \
      Exec(Local[0], Local[1] + " > " + Local[2], , , SW_HIDE) \
      : DeleteFileNow(Output)
#pragma parseroption -p+
#endif

#define ProcessLanguageLine(Output, Input) \
  !FileEof(Input) ? \
    Local[0] = FileRead(Input), \
    Local[0] = StringChange(Local[0], "[fname]", FName), \
    Local[0] = StringChange(Local[0], "[flongname]", FLongName), \
    Local[0] = StringChange(Local[0], "[fver]", FVer), \
    Pos("; ISPP ", Local[0]) == 1 ? \
      Pos("; ISPP " + FName, Local[0]) == 1 ? (Local[1] = 1) : (Local[1] = 0), \
      Defined(Mods) ? Pos("; ISPP Mods", Local[0]) == 1 ? (Local[1] = 1) \
        : 0 : 0 \
      : (Local[1] = 1), \
    Local[1] == 1 ? SaveStringToFile(Output, Local[0] + NewLine, 1, 0) : 0, \
    Local[1] \
    : 0

#define ProcessLanguage_(Output, Input) \
  Local[0] = ProcessLanguageLine(Output, Input), \
  Local[0] == 1 ? Local[0] = ProcessLanguageLine(Output, Input) : 0, \
  Local[0] == 1 ? Local[0] = ProcessLanguageLine(Output, Input) : 0, \
  Local[0] == 1 ? Local[0] = ProcessLanguageLine(Output, Input) : 0, \
  Local[0] == 1 ? Local[0] = ProcessLanguageLine(Output, Input) : 0, \
  Local[0] == 1 ? Local[0] = ProcessLanguageLine(Output, Input) : 0, \
  Local[0] == 1 ? Local[0] = ProcessLanguageLine(Output, Input) : 0, \
  Local[0] == 1 ? Local[0] = ProcessLanguageLine(Output, Input) : 0, \
  Local[0] == 1 ? ProcessLanguage_(Output, Input) : 0

#define ProcessLanguage(File) \
  Local[0] = "p_" + LowerCase(FName) + "_" + File, \
  Local[0] = StringChange(Local[0], " ", "_"), \
  Local[1] = SourcePath + "\" + Local[0], \
  SaveStringToFile(Local[1], "", 0, 0), \
  Local[2] = FileOpen(SourcePath + "\" + File), \
  ProcessLanguage_(Local[1], Local[2]), \
  FileClose(Local[2]), \
  Local[1]

