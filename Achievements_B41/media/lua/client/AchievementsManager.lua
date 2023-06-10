AchievementManager = {}
AchievementManager.__index = AchievementManager

function AchievementManager:new()

    local o = {}
    setmetatable(o, self)
    self.__index = self
        
    o.Achievements = {}
    o.AchievementCount = 0
    o.DisplayedAchievementCount = 0
    o.LastOneComplete = 0
    o.BannerMSG = nil 
    o.LastOneSelected = ""
    o.ShownBannerMSGCount = 0
    
    return o

end


function AchievementManager:exists(CodeName)
    
    for i=0, self.AchievementCount+1 do
        if(self.Achievements[i]) and (self.Achievements[i]:getCodeName() == CodeName) then return true end
    end
    return false
end

function AchievementManager:getDisplayName(CodeName)
    
    for i=0, self.AchievementCount+1 do
        if(self.Achievements[i]) and (self.Achievements[i]:getCodeName() == CodeName) then return self.Achievements[i].DisplayName end
    end
    return false
end

function AchievementManager:getStatus(CodeName,isComp)
    
    local statusout = ""
    local player = getPlayer()
    
    if(CodeName == "ReadASkillBook") then
        if(player:getModData().ThingsIDid["ReadASkillBook"] == nil) then statusout = "0/15"
        else statusout = tostring(player:getModData().ThingsIDid["ReadASkillBook"]) .. "/15" end
    elseif(CodeName == "Chocolate") then
        if(player:getModData().ThingsIAte["Chocolate"] == nil) then statusout = "0/25"
        else statusout = tostring(player:getModData().ThingsIAte["Chocolate"]) .. "/25" end
    elseif(CodeName == "Medic") then
        if(player:getModData().ThingsIDid["bandage"] == nil) then statusout = "0/50"
        else statusout = tostring(player:getModData().ThingsIDid["bandage"]) .. "/50" end
    elseif(CodeName == "Safe") then
        if(player:getModData().ThingsIDid["Barricade"] == nil) then statusout = "0/100"
        else statusout = tostring(player:getModData().ThingsIDid["Barricade"]) .. "/100" end
    elseif(CodeName == "Vandal") then
        if(player:getModData().ThingsIDid["SmashWindow"] == nil) then statusout = "0/100"
        else statusout = tostring(player:getModData().ThingsIDid["SmashWindow"]) .. "/100" end
    elseif(CodeName == "KillZ1") then
         statusout = tostring(player:getZombieKills()) .. "/1" 
    elseif(CodeName == "KillZ2") then
         statusout = tostring(player:getZombieKills()) .. "/100" 
    elseif(CodeName == "KillZ3") then
         statusout = tostring(player:getZombieKills()) .. "/1000" 
    elseif(CodeName == "KillZ4") then
         statusout = tostring(player:getZombieKills()) .. "/10000" 
    elseif(CodeName == "Macho") then
         statusout = tostring(round(distanceCarried)) .. "/200" 
    elseif(CodeName == "Mushrooms") then
        if(player:getModData().CheckPointCounts["Mushrooms"] == nil) then statusout = "0/7"
        else statusout = tostring(player:getModData().CheckPointCounts["Mushrooms"]) .. "/7" end
    elseif(CodeName == "Cube") then
        if(player:getModData().CheckPointCounts["Cube"] == nil) then statusout = "0/5"
        else statusout = tostring(player:getModData().CheckPointCounts["Cube"]) .. "/5" end
    elseif(CodeName == "Survivalist") then
        if(player:getModData().CheckPointCounts["Survivalist"] == nil) then statusout = "0/4"
        else statusout = tostring(player:getModData().CheckPointCounts["Survivalist"]) .. "/4" end
    elseif(CodeName == "ChurchGoer") then
        if(player:getModData().CheckPointCounts["ChurchGoer"] == nil) then statusout = "0/8"
        else statusout = tostring(player:getModData().CheckPointCounts["ChurchGoer"]) .. "/8" end
    elseif(CodeName == "SpiffoRest") then
        if(player:getModData().CheckPointCounts["SpiffoRest"] == nil) then statusout = "0/5"
        else statusout = tostring(player:getModData().CheckPointCounts["SpiffoRest"]) .. "/5" end
    elseif(CodeName == "Axin") then
        if(player:getModData().KilledWithWeaponCategoryCounts["Axe"] == nil) then statusout = "0/500"
        else statusout = tostring(player:getModData().KilledWithWeaponCategoryCounts["Axe"]) .. "/500" end
    elseif(CodeName == "Inspeared") then
        if(player:getModData().KilledWithWeaponCategoryCounts["Spear"] == nil) then statusout = "0/500"
        else statusout = tostring(player:getModData().KilledWithWeaponCategoryCounts["Spear"]) .. "/500" end
    elseif(CodeName == "SmallBlade") then
        if(player:getModData().KilledWithWeaponCategoryCounts["SmallBlade"] == nil) then statusout = "0/500"
        else statusout = tostring(player:getModData().KilledWithWeaponCategoryCounts["SmallBlade"]) .. "/500" end
    elseif(CodeName == "SmallBlunt") then
        if(player:getModData().KilledWithWeaponCategoryCounts["SmallBlunt"] == nil) then statusout = "0/500"
        else statusout = tostring(player:getModData().KilledWithWeaponCategoryCounts["SmallBlunt"]) .. "/500" end
    elseif(CodeName == "Blade") then
        if(player:getModData().KilledWithWeaponCategoryCounts["LongBlade"] == nil) then statusout = "0/500"
        else statusout = tostring(player:getModData().KilledWithWeaponCategoryCounts["LongBlade"]) .. "/500" end
    elseif(CodeName == "Blunt") then
        if(player:getModData().KilledWithWeaponCategoryCounts["Blunt"] == nil) then statusout = "0/500"
        else statusout = tostring(player:getModData().KilledWithWeaponCategoryCounts["Blunt"]) .. "/500" end
    elseif(CodeName == "AllPenKill") then
        local nbPen = 0;
        if(player:getModData().KilledWithWeaponCounts["Pencil"] ~= nil) then nbPen = nbPen + 1; end
        if(player:getModData().KilledWithWeaponCounts["Pen"] ~= nil) then nbPen = nbPen + 1; end
        if(player:getModData().KilledWithWeaponCounts["BluePen"] ~= nil) then nbPen = nbPen + 1; end
        if(player:getModData().KilledWithWeaponCounts["RedPen"] ~= nil) then nbPen = nbPen + 1; end
        statusout = tostring(nbPen) .. "/4"
    elseif(CodeName == "Hunter") then
        if(player:getModData().KilledWithWeaponCounts["HuntingRifle"] == nil) then statusout = "0/100"
        else statusout = tostring(player:getModData().KilledWithWeaponCounts["HuntingRifle"]) .. "/100" end
    elseif(CodeName == "Survive1") then
        statusout = tostring(round(player:getHoursSurvived())) .. "/24 Hours" 
    elseif(CodeName == "Survive2") then
        statusout = tostring(round(player:getHoursSurvived())) .. "/"..round(24 * 29.53).." Hours" 
    elseif(CodeName == "Survive3") then
        statusout = tostring(round(player:getHoursSurvived())) .. "/"..round((24 * 29.53)*12).." Hours" 
    end
        
    if(isComp) then statusout = statusout .. " (Complete)"
    else statusout = statusout .. " (Incomplete)" end    

    return "\nStatus: " .. statusout ..  "\n\n"

end

function AchievementManager:setDescWindow(CodeName)
    for i=0, self.AchievementCount+1 do
        if(self.Achievements[i]) and (self.Achievements[i].CodeName == CodeName) then 
            self.LastOneSelected = CodeName
            local newtext = self.Achievements[i].DisplayName .. self:getStatus(CodeName,self.Achievements[i]:isComplete()) .. self.Achievements[i].Description;
            myAchievementDescWindow:setText(newtext, CodeName);
            myAchievementDescWindow:setTitle(self.Achievements[i].DisplayName);
            if(myAchievementsWindow:getIsVisible()) then myAchievementDescWindow:setVisible(true) end
            myAchievementDescWindow.CN = CodeName
        end
    end
end
function AchievementManager:SetBannerMSG(message)
    
    if(self.BannerMSG ~= nil) then 
        self.BannerMSG:removeFromUIManager()
        self.BannerMSG = false
    end
    
    self.BannerMSG = AchievementMessage:new(60, 60, 500, 50, true, message);
    self.BannerMSG:initialise();
    self.BannerMSG:addToUIManager();
    self.BannerMSG:setAlwaysOnTop(true);
    self.ShownBannerMSGCount = 0
end

function AchievementManager:setComplete(CodeName, status)

    self.LastOneComplete = CodeName
    self.LastOneSelected = CodeName
    local player = getPlayer()
    player:getModData().Achievements[CodeName] = status
    
    for i=0, self.AchievementCount+1 do
        if(self.Achievements[i]) and (self.Achievements[i].CodeName == CodeName) then 
            self.Achievements[i]:setComplete(status,false) 
            self:SetBannerMSG(self.Achievements[i].DisplayName .. " Achievement Complete!")
            myAchievementsWindow:setSelected(CodeName)
        end
    end
    self:setDescWindow(CodeName)
    myAchievementsWindow:Update()
end

function isAchievementBuggy(CodeName)
    return (CodeName == "AllPenKill" or CodeName == "Unarmed" or CodeName == "GetBit" or CodeName == "Bleach");--add here the achievements we wanna keep secret. make a table if there are a lot. put there all death ones for completionists. put there some secret ones from time to time.
end

function isAchievementVisible(CodeName)
    return ((AchievementsOptions == nil or AchievementsOptions.DisplayAchievementBeforeCompletion) and not isAchievementBuggy(CodeName));
end

function AchievementManager:addAchievement(CodeName,DisplayName,Description)
    local player = getPlayer()
    local status = player:getModData().Achievements[CodeName]
    
    -- print("AchievementManager:addAchievement "..CodeName.." "..DisplayName.." "..Description);
    if(not self:exists(CodeName)) then
        self.Achievements[self.AchievementCount] = Achievement:new(CodeName,DisplayName,Description,"TrophyOn");
        if(status ~= nil) then
            self.Achievements[self.AchievementCount]:setComplete(status, status)
        end
        self.AchievementCount = self.AchievementCount + 1;
    end
    
    if(self:isComplete(CodeName)) then
        myAchievementsWindow:AddItem(DisplayName.. " (Complete)",CodeName);
    elseif isAchievementVisible(CodeName) then
        myAchievementsWindow:AddItem(DisplayName, CodeName);
    end
    
    return self.Achievements[self.AchievementCount-1];
end

function AchievementManager:isComplete(CodeName)
    
    for i=0, self.AchievementCount+1 do
        if(self.Achievements[i]) and (self.Achievements[i]:getCodeName() == CodeName) then return self.Achievements[i]:isComplete() end
    end

end

function AchievementManager:CountAchievements(complete)
    
    local outCount = 0
    self.DisplayedAchievementCount = 0
    for i=0, self.AchievementCount+1 do
        local achievement = self.Achievements[i]
        if(achievement) then
            if (achievement:isComplete() == complete) then
                outCount = outCount + 1
                self.DisplayedAchievementCount = self.DisplayedAchievementCount + 1;
                if AchievementsOptions.Verbose then print ("Achievement Complete "..achievement:getCodeName()); end
            elseif not isAchievementBuggy(achievement:getCodeName()) then
                self.DisplayedAchievementCount = self.DisplayedAchievementCount + 1;
                if AchievementsOptions.Verbose then print ("Achievement Visible "..achievement:getCodeName()); end
            else
                if AchievementsOptions.Verbose then print ("Achievement bugged "..achievement:getCodeName()); end
            end
        end
    end
    return outCount
end


function AchievementManager:update()

    local numComplete = self:CountAchievements(true)
    local total = self.DisplayedAchievementCount
    local ratio = 0
    if total > 0 then
        ratio = numComplete/total;
    end
    myAchievementsWindow:setHeaderText(tostring(numComplete) .. "/" .. tostring(total) .. " --- " .. (round(ratio*100)) .. "% Complete.     Double click an item to see its Description.")
    
    self.ShownBannerMSGCount = self.ShownBannerMSGCount + 1
    if(self.ShownBannerMSGCount >= 65) and (self.BannerMSG ~= nil) then
        self.BannerMSG:removeFromUIManager()
        self.BannerMSG = nil
    end
    
    if(myAchievementDescWindow:getIsVisible()) then self:setDescWindow(self.LastOneSelected) end

end

function DisplayAchievementBeforeCompletionSwitchVisibility()
    if AchievementsOptions.Verbose then print (DisplayAchievementBeforeCompletionSwitchVisibility) end 
    if (myAchievementsWindow and MyAchievementManager) then
        myAchievementsWindow:RemoveAll()
        MyAchievementManager = AchievementManager:new();
        
        myAchievementsWindow:Update()
    end
end

function AchievementManager:onMouseDown(x,y)
    if(MyAchievementManager ~= nil and MyAchievementManager.BannerMSG ~= nil) then
        MyAchievementManager.BannerMSG:removeFromUIManager()
        MyAchievementManager.BannerMSG = nil
        if AchievementsOptions.Verbose then print ("OnMouseDown remove banner"); end
    end
end

Events.OnMouseDown.Add(AchievementManager.onMouseDown);
