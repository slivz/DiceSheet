----------------------
--- USER INTERFACE ---
----------------------
local Me = DiceSheet

local AceGUI = LibStub("AceGUI-3.0")

function Me:reloadCharacterSheet()
    local headerPanel = DS_ContentSheet_Header
    local attributePanel = DS_ContentSheet_Attributes
    local skillPanel = DS_ContentSheet_Skills
    local statData = nil
    local rpData = nil
    
    if not Me.GUI.targetPlayer then
        local fullCharName = nil
        local charName, charRealm = UnitName("player")
        if not charRealm then
            charRealm = GetRealmName():gsub("[%s*%-*]", "")
        end
        fullCharName = charName .. '-' .. charRealm
        Me.GUI.targetPlayer = fullCharName
    end
    
    statData = Me:GetPlayerData(Me.GUI.targetPlayer)
    if TRP3_API then
        rpData = TRP3_API.utils.getCharacterInfoTab(Me.GUI.targetPlayer)
    end
    
    --Setup Header
    local headerW, headerH = headerPanel:GetSize()
    local charText = nil
    if not headerPanel.charText then
        charText = CreateFrame("Frame", nil, headerPanel, "DS_Misc_TitledTextDisplay")
        charText:SetPoint("TOPLEFT", 10, -5)
        charText.captionTitle:SetText("Character Name")
        headerPanel.charText = charText
    else
        charText = headerPanel.charText
    end
    
    --check to see if we use TRP3
    if TRP3_API then
        local playerName = Me.GUI.targetPlayer
        local splitName = string.split(playerName, '-')
        if splitName[2] == GetRealmName():gsub("[%s*%-*]", "") then
            playerName = splitName[1]
        end
        charText.captionText:SetText(TRP3_API.r.name(playerName))
    else
        -- if we dont, default charName
        charText.captionText:SetText(Me.GUI.targetPlayer)
    end
    
    local raceText = nil
    if not headerPanel.raceText then
        raceText = CreateFrame("Frame", nil, headerPanel, "DS_Misc_TitledTextDisplay")
        raceText:SetPoint("TOPLEFT", (headerW/3) + 10, -5)
        raceText.captionTitle:SetText("Race")
        headerPanel.raceText = raceText
    else
        raceText = headerPanel.raceText
    end
    
    raceText.captionText:SetText("")
    if rpData then
        raceText.captionText:SetText(rpData.characteristics.RA)
    end
    
    local classText = nil
    if not headerPanel.classText then
        classText = CreateFrame("Frame", nil, headerPanel, "DS_Misc_TitledTextDisplay")
        classText:SetPoint("TOPLEFT", (headerW*2/3) + 10, -5)
        classText.captionTitle:SetText("Class")
        headerPanel.classText = classText
    else
        classText = headerPanel.classText
    end
    
    classText.captionText:SetText("")
    if rpData then
        classText.captionText:SetText(rpData.characteristics.CL)
    end
    
    local pointsText = CreateFrame("Frame", nil, headerPanel, "DS_Misc_TitledTextDisplay")
    pointsText:SetPoint("TOPLEFT", (headerW*2/3) + 10, -45)
    pointsText.captionTitle:SetText("Unspent Points")
    pointsText.captionText:SetText('0')
    
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
            f:SetText(string.format('+%s', statData.attributes[string.lower(v.name)]))
            f.disabled = true
            f.data = v
            
            attributePanel.attibutes[v.short] = f
            i = i + 1
        else
            -- reuse
            local f = attributePanel.attibutes[v.short]
            f:SetText(string.format('+%s', statData.attributes[string.lower(v.name)]))
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
            local f = skillPanel.skills[v.name]
            --f:SetText(string.format('+%s', statData.skills[string.lower(v.name)]))
        end
    end
end

function Me:ShowMainFrame()
    self.GUI.MainFrame:Show()
    self.GUI.MainFrame:Raise()
    
    self:reloadCharacterSheet()
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
    
    tinsert(UISpecialFrames, DS_MainFrame:GetName())
end
Me:RegisterChatCommand("dicesheet", "ToggleMainFrame")