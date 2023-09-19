class T2FZombieParts extends SqRootScript {

    // Remove "M-ZombieParts" on the current object if it exists
    function RemoveZP() {
        if (Object.HasMetaProperty(self, Object.Named("M-ZombieParts"))) {
            Object.RemoveMetaProperty(self, Object.Named("M-ZombieParts"))
        }
    }

    // Add the appropriate metaproperty when the zombie is actually slain
    function OnSlain() {
        if (Property.Possessed(self, "MAX_HP")) {
            if (Property.Get(self, "MAX_HP") <= 0) {
                // Add the "M-FreshZombieParts" metaproperty to this object
                // if it exists and this object inherits from the "FreshZombie" archetype
                if (Object.InheritsFrom(self, Object.Named("FreshZombie"))
                    && Object.Exists(Object.Named("M-FreshZombieParts"))) {
                    RemoveZP();
                    Object.AddMetaProperty(self, Object.Named("M-FreshZombieParts"));
                // Add the "M-FemZombieParts" metaproperty to this object
                // if it exists and this object inherits from the "FemZombie" archetype
                } else if (Object.InheritsFrom(self, Object.Named("FemZombie"))
                    && Object.Exists(Object.Named("M-FemZombieParts"))) {
                    RemoveZP();
                    Object.AddMetaProperty(self, Object.Named("M-FemZombieParts"));
                }
            }
        }
    }

}

class T2FRopeToVine extends SqRootScript {

    // Convert contained rope arrows to vine arrows on Sim start
    function OnSim() {
        if (message().starting) {
            foreach (l in Link.GetAll(LinkTools.LinkKindNamed("Contains"), self)) {
                if (Object.InheritsFrom(LinkDest(l), Object.Named("RopeArrow"))) {
                    local rope = LinkDest(l);
                    // Create the vine arrow
                    local vine = Object.Create(Object.Named("VineArrow"));
                    // Copy the stack count from the rope arrow if it exists
                    if (Property.Possessed(rope, "StackCount")) {
                        Property.CopyFrom(vine, "StackCount", rope);
                    }
                    // Destroy the rope arrow object and
                    // add the new vine arrow object to this object
                    Object.Destroy(rope);
                    Container.Add(vine, self);
                }
            }
        }
    }

}
