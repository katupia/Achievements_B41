--***********************************************************

require "TimedActions/ISCraftAction"
require "TimedActions/ISActivateGenerator"
require "TimedActions/ISApplyBandage"
require "TimedActions/ISBarricadeAction"
require "TimedActions/ISBurnCorpseAction"
require "TimedActions/ISBuryCorpse"
require "TimedActions/ISEatFoodAction"
require "TimedActions/ISInventoryTransferAction"
require "TimedActions/ISReadABook"
require "TimedActions/ISSmashWindow"


local original_ISCraftAction_perform = ISCraftAction.perform
function ISCraftAction:perform()--working OK
    original_ISCraftAction_perform(self);

    local craftKey = self.recipe:getResult():getType();
    if(self.character:getModData().ThingsICrafted[craftKey] == nil) then  self.character:getModData().ThingsICrafted[craftKey] = 1;
    else
        self.character:getModData().ThingsICrafted[craftKey] = self.character:getModData().ThingsICrafted[craftKey] + 1;
    end
    --print("Achievements: I crafted ".. self.character:getModData().ThingsICrafted[craftKey] .. " "..self.recipe:getResult():getFullType() .. " " ..self.recipe:getResult():getType() );
end


local original_ISActivateGenerator_perform = ISActivateGenerator.perform
function ISActivateGenerator:perform()--working OK
    local isActivation = self.activate;
    original_ISActivateGenerator_perform(self);
    
    if isActivation then
        if(self.character:getModData().ThingsIDid["ActivateGenerator"] == nil) then
            self.character:getModData().ThingsIDid["ActivateGenerator"] = 1
        else
            self.character:getModData().ThingsIDid["ActivateGenerator"] = self.character:getModData().ThingsIDid["ActivateGenerator"] + 1
        end
        -- print("Achievements: I activated ".. self.character:getModData().ThingsIDid["ActivateGenerator"] .. " generators" );
    --else
    --    print ("Achievements: I deactivated a generator");
    end
end


local original_ISApplyBandage_perform = ISApplyBandage.perform
function ISApplyBandage:perform()--working OK
    original_ISApplyBandage_perform(self);

    if (self.doIt) then
        if(self.character:getModData().ThingsIDid["bandage"] == nil) then self.character:getModData().ThingsIDid["bandage"] = 1
        else self.character:getModData().ThingsIDid["bandage"] = self.character:getModData().ThingsIDid["bandage"] + 1 end
        --print("Achievements: I applied ".. self.character:getModData().ThingsIDid["bandage"] .. " bandages " .. (self.doIt and "true" or "false") );
    end
end


local original_ISBarricadeAction_perform = ISBarricadeAction.perform
function ISBarricadeAction:perform()--working OK
    original_ISBarricadeAction_perform(self);

    if(self.character:getModData().ThingsIDid["Barricade"] == nil) then self.character:getModData().ThingsIDid["Barricade"] = 1
    else self.character:getModData().ThingsIDid["Barricade"] = self.character:getModData().ThingsIDid["Barricade"] + 1 end
    --print("Achievements: I applied ".. self.character:getModData().ThingsIDid["Barricade"] .. " Barricades " );
end


local original_ISBurnCorpseAction_perform = ISBurnCorpseAction.perform
function ISBurnCorpseAction:perform()--working OK
    original_ISBurnCorpseAction_perform(self);
    
    if(self.character:getModData().ThingsIDid["BurnCorpse"] == nil) then self.character:getModData().ThingsIDid["BurnCorpse"] = 1
    else self.character:getModData().ThingsIDid["BurnCorpse"] = self.character:getModData().ThingsIDid["BurnCorpse"] + 1 end
    --print("Achievements: I burnt ".. self.character:getModData().ThingsIDid["BurnCorpse"] .. " corpses " );
end


local original_ISBuryCorpse_perform = ISBuryCorpse.perform
function ISBuryCorpse:perform()--working OK
    original_ISBuryCorpse_perform(self);
    
    if(self.character:getModData().ThingsIDid["BuryCorpse"] == nil) then self.character:getModData().ThingsIDid["BuryCorpse"] = 1
    else self.character:getModData().ThingsIDid["BuryCorpse"] = self.character:getModData().ThingsIDid["BuryCorpse"] + 1 end
    --print("Achievements: I burried ".. self.character:getModData().ThingsIDid["BuryCorpse"] .. " corpses " );
end


local original_ISEatFoodAction_perform = ISEatFoodAction.perform
function ISEatFoodAction:perform()--working OK
    original_ISEatFoodAction_perform(self);
    
    local thingKey = self.item:getType();
    if(self.character:getModData().ThingsIAte[thingKey] == nil) then self.character:getModData().ThingsIAte[thingKey] = 1
    else self.character:getModData().ThingsIAte[thingKey] = self.character:getModData().ThingsIAte[thingKey] + 1 end
    --print("Achievements: I ate ".. self.character:getModData().ThingsIAte[thingKey] .. " " .. thingKey );
end


local original_ISInventoryTransferAction_perform = ISInventoryTransferAction.transferItem
function ISInventoryTransferAction:transferItem(item)--working OK
    --redo condition check done in genuine PZ file. This part may have maintenance cost at each PZ update.
    local isToBeLogged = false;
    if not self:isAlreadyTransferred(item) then
        if self.destContainer:getType()=="floor" then
            isToBeLogged = self:getNotFullFloorSquare(item);
            --I do not check the self:removeItemOnCharacter() condition because it is also an action I do not wanna repeat.
            -- it may lead to a bug or not. it depends on the actions of "the masking system". I am too lazy to analyse.
            -- if not isToBeLogged then
            --     print("Achievements: unlog transfer: dest floor if full." );
            -- end
        -- else
        --     print("Achievements: unlog transfer: dest not floor." );
        end
    -- else
    --     print("Achievements: unlog transfer: already transferred." );
    end
    
    original_ISInventoryTransferAction_perform(self,item);

    if isToBeLogged then
        local itemType = item:getType();
        if(self.character:getModData().ThingsIDropped[itemType] == nil) then self.character:getModData().ThingsIDropped[itemType] = 1
        else self.character:getModData().ThingsIDropped[itemType] = self.character:getModData().ThingsIDropped[itemType] + 1 end
    --    print("Achievements: I transfered ".. self.character:getModData().ThingsIDropped[itemType] .. " " .. itemType .." on ground" );
    -- else
    --     print("Achievements: unlog transfer 2." );
    end
end


local original_ISReadABook_update = ISReadABook.update
function ISReadABook:update()--working OK
    --redo condition check done in genuine PZ file. This part may have maintenance cost at each PZ update.
    local isReadingASkillBookFirstTime = false;
    if not SkillBook[self.item:getSkillTrained()] then
        isReadingASkillBookFirstTime = false;
        -- print("Achievements: I read not a skill trained." );
    elseif self.item:getAlreadyReadPages() < self.item:getNumberOfPages() then
        isReadingASkillBookFirstTime = true;
        -- print("Achievements: I am reading a skillbook." );
    else
        -- print("Achievements: I read unskilled book => is not to be logged." );
    end

    original_ISReadABook_update(self);
    
    if isReadingASkillBookFirstTime and self.item:getAlreadyReadPages() >= self.item:getNumberOfPages() then
        if(self.character:getModData().ThingsIDid["ReadASkillBook"] == nil) then self.character:getModData().ThingsIDid["ReadASkillBook"] = 1
        else self.character:getModData().ThingsIDid["ReadASkillBook"] = self.character:getModData().ThingsIDid["ReadASkillBook"] + 1 end
        --print("Achievements: I read ".. self.character:getModData().ThingsIDid["ReadASkillBook"] .. " skill books" );
    end
end


local original_ISSmashWindow_perform = ISSmashWindow.perform
function ISSmashWindow:perform()--working OK
    original_ISSmashWindow_perform(self);
    
    if(self.character:getModData().ThingsIDid["SmashWindow"] == nil) then self.character:getModData().ThingsIDid["SmashWindow"] = 1
    else self.character:getModData().ThingsIDid["SmashWindow"] = self.character:getModData().ThingsIDid["SmashWindow"] + 1 end
    --print("Achievements: I smashed ".. self.character:getModData().ThingsIDid["SmashWindow"] .. " windows" );
end
