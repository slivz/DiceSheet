----------------
--- DATABASE ---
----------------
local Me = DiceSheet

-- options table
local defaults = {
    profile = {
        strength = 0,
        dexterity = 0,
        constitution = 0
    }
}

function Me:InitDB()
    self.db = LibStub("AceDB-3.0"):New("DiceSheet_Data", defaults)
end