--------------------------
--- CONFIGURATION MENU ---
--------------------------
local Me = DiceSheet

-- includes
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")
local AceDBOptions = LibStub("AceDBOptions-3.0")

-- options table
local optionsHeader = {
    type = 'group',
    args = {
        header = {
            order = 0,
            name = "This is the DiceSheet configuration page.",
            type = "description"
        }
    }
}

function Me:InitConfig()
    -- register the tables
    AceConfig:RegisterOptionsTable("DiceSheet", optionsHeader)
	AceConfig:RegisterOptionsTable("DS Profiles", AceDBOptions:GetOptionsTable(self.db))
    
    -- add to blizzard UI
    self.Config = {}
    self.Config.header = AceConfigDialog:AddToBlizOptions("DiceSheet", "DiceSheet")
    self.Config.profiles = AceConfigDialog:AddToBlizOptions("DS Profiles", "Profiles", "DiceSheet")
end