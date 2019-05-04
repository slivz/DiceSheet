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
    
    local attributeList = {
        "strength",
        "dexterity",
        "constitution",
        "charisma",
        "intelligence",
        "wisdom"
    }
    
    -- attach dictionary to table
    -- we will create a frame for each attribute if it doesnt exist
    -- we will reuse it an update the values if it does
    local e = 0
    if not attributePanel.attibutes then attributePanel.attibutes = {} end
    for k, v in ipairs(attributeList) do
        if not attributePanel.attibutes[v] then      
            -- create
            if (k-1) % 3 == 0 then e = e + 1 end
            local frame = CreateFrame("Frame", nil, attributePanel, "DS_Misc_TitledTextDisplay")
            frame:SetPoint("TOPLEFT", 10 + (attributeW/3 * ((k-1) % 3)), 0 - (20 + (e-1) * 40))
            frame.captionTitle:SetText(v)
            
            attributePanel.attibutes[v] = frame
        else
            -- reuse
        end
    end
    
    --Setup Skills
    local skillW, skillH = skillPanel:GetSize()
    skillPanel.title.captionText:SetText("Skills")
    
    local skillList = {
        'acrobatics',
        'appraise',
        'bluff',
        'climb',
        'craft',
        'diplomacy',
        'disable device',
        'disguise',
        'escape artist',
        'fly',
        'handle animal',
        'heal',
        'intimidate',
        'knowledge',
        'linguistics',
        'perception',
        'perform',
        'profession',
        'ride',
        'sense motive',
        'sleight of hand',
        'spellcraft',
        'stealth',
        'survival',
        'swim',
        'use magic device'
    }
    
    local e = 0
    if not skillPanel.skills then skillPanel.skills = {} end
    for k, v in ipairs(skillList) do
        if not skillPanel.skills[v] then
            -- create
            if (k-1) % 3 == 0 then e = e + 1 end
            local frame = CreateFrame("Frame", nil, skillPanel, "DS_Misc_TextDisplay")
            frame:SetPoint("TOPLEFT", 10 + ((skillW/3) * ((k-1) % 3)), 0 - (20 + (e-1) * 20))
            frame.captionText:SetText(v)
            
            skillPanel.skills[v] = frame
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