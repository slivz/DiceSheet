----------------------
--- USER INTERFACE ---
----------------------
local Me = DiceSheet

local AceGUI = LibStub("AceGUI-3.0")

local function loadCharacterSheet()
    local headerPanel = DS_ContentSheet_Header
    local attributePanel = DS_ContentSheet_Attributes
    local skillPanel = DS_ContentSheet_Skills
    
    --Setup Header
    
    
    --Setup Attributes
    attributePanel.title.captionText:SetText("Attributes")
    
    --Setup Skills
    skillPanel.title.captionText:SetText("Skills")
end

function Me:ShowMainFrame()
    self.GUI.MainFrame:Show()
    self.GUI.MainFrame:Raise()
end

function Me:HideMainFrame()
    self.GUI.MainFrame:Hide()
end

function Me:ToggleMainFrame()
    if self.GUI.MainFrame:IsShown() then
        self:HideMainFrame()
        return
    end
    self:ShowMainFrame()
end

function Me:InitGUI()
    -- create GUI storage table
    self.GUI = {}
    self.GUI.MainFrame = DS_MainFrame
    
    loadCharacterSheet()
    
    tinsert(UISpecialFrames, DS_MainFrame:GetName())
end
Me:RegisterChatCommand("dicesheet", "ToggleMainFrame")