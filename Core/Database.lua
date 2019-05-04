----------------
--- DATABASE ---
----------------
local Me = DiceSheet

-- defaults table
Me.db_defaults = {
    global = {
        playerStore = {
        
        }
    },
    profile = {
        player = {
            attributes = {
                strength = 0,
                dexterity = 0,
                constitution = 0,
                charisma = 0,
                intelligence = 0,
                wisdom = 0
            },
            skills = {
                
            }
        }
    }
}

function Me:GetPlayerData(playerName)
    local playerStore = self.db.global.playerStore
    local localPlayer = self.db.profile.player
    
    -- check if its the local player
    local localPlayerName = UnitName("player")
    if playerName == (localPlayerName .. '-' .. GetRealmName()) then
        return localPlayer
    end
    
    -- check if we have a record for this player
    if playerStore[playerName] then
        -- return it!
        return playerStore[playerName]
    end
    
    -- if were here, we dont have a record for this player
    playerStore[playerName] = tableDeepCopy(self.db_defaults.profile.player)
    return playerStore[playerName]
end

function Me:InitDB()
    self.db = LibStub("AceDB-3.0"):New("DiceSheet_Data", self.db_defaults)
end