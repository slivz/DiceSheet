----------------------
--- INITIALIZATION ---
----------------------
DiceSheet = LibStub("AceAddon-3.0"):NewAddon(
    "DiceSheet", 
    "AceConsole-3.0"
)
local Me = DiceSheet

-- called when addon is first loaded, good for restoring settings (e.g. UI reload)
function Me:OnInitialize()
    
end

-- called when someone enables or disables the addon, may occur many times between UI reloads
function Me:OnEnable()
    self:InitDB() -- database initialization
    self:InitConfig() -- configuration initialization
    self:InitGUI() -- User Interface init
end

-- inverse of above
function Me:OnDisable()

end