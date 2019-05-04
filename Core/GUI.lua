----------------------
--- USER INTERFACE ---
----------------------
local Me = DiceSheet

local AceGUI = LibStub("AceGUI-3.0")

local function loadCharacterSheet(unitName)
    local headerPanel = DS_ContentSheet_Header
    local attributePanel = DS_ContentSheet_Attributes
    local skillPanel = DS_ContentSheet_Skills
    
    --Setup Header
    local headerW, headerH = headerPanel:GetSize()
    local charText = CreateFrame("Frame", nil, headerPanel, "DS_Misc_TitledTextDisplay")
    charText:SetPoint("TOPLEFT", 10, -5)
    charText.captionTitle:SetText("Character Name")
    charText.captionText:SetText("Test 123")
    
    local raceText = CreateFrame("Frame", nil, headerPanel, "DS_Misc_TitledTextDisplay")
    raceText:SetPoint("TOPLEFT", (headerW/3) + 10, -5)
    raceText.captionTitle:SetText("Race")
    raceText.captionText:SetText("Test 123")
    
    local classText = CreateFrame("Frame", nil, headerPanel, "DS_Misc_TitledTextDisplay")
    classText:SetPoint("TOPLEFT", (headerW*2/3) + 10, -5)
    classText.captionTitle:SetText("Class")
    classText.captionText:SetText("Test 123")
    
    local pointsText = CreateFrame("Frame", nil, headerPanel, "DS_Misc_TitledTextDisplay")
    pointsText:SetPoint("TOPLEFT", (headerW*2/3) + 10, -45)
    pointsText.captionTitle:SetText("Unspent Points")
    pointsText.captionText:SetText("Test 123")
    
    --Setup Attributes
    local attributeW, attributeH = attributePanel:GetSize()
    attributePanel.title.captionText:SetText("Attributes")
    
    -- attach dictionary to table
    -- we will create a frame for each attribute if it doesnt exist
    -- we will reuse it an update the values if it does
    local i = 1
    local e = 0
    if not attributePanel.attibutes then attributePanel.attibutes = {} end
    for k, v in ipairs(Me.StatDefines.attributes) do
        if not attributePanel.attibutes[v.short] then      
            -- create
            if i % 4 == 0 then i = 1 end
            if i == 1 then e = e + 1 end
            
            local f = CreateFrame("EditBox", nil, attributePanel, "DS_AttributeBox")
            f:SetPoint("TOPLEFT", (attributeW/4 * i) - f:GetWidth()/2, 0 - (19 + (e-1) * 38))
            f.title:SetText(v.short)
            f:SetText('+0')
            f.disabled = true
            f.data = v
            
            attributePanel.attibutes[v.short] = f
            i = i + 1
        else
            -- reuse
        end
    end
    
    --Setup Skills
    local skillW, skillH = skillPanel:GetSize()
    skillPanel.title.captionText:SetText("Skills")
    
    local i = 1
    local e = 0
    if not skillPanel.skills then skillPanel.skills = {} end
    for k, v in ipairs(Me.StatDefines.skills) do
        if not skillPanel.skills[v.name] then
            -- create
            if i % 4 == 0 then i = 1 end
            if i == 1 then e = e + 1 end
            local frame = CreateFrame("Frame", nil, skillPanel, "DS_Misc_TextDisplay")
            frame:SetPoint("TOPLEFT", 10 + ((skillW/3) * ((i-1) % 3)), 0 - (20 + (e-1) * 20))
            frame.captionText:SetText(v.name)
            frame.data = v
            
            skillPanel.skills[v.name] = frame
            i = i + 1
        else
            -- reuse
        end
    end
    
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