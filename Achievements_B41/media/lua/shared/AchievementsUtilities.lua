
function CanSeeNumber(player)
    local spottedList = player:getCell():getZombieList();
    local countseen = 0;
    if(spottedList ~= nil) then
        for i=0, spottedList:size()-1 do
            local character = spottedList:get(i);
            if(character ~= nil) and (player:CanSee(character)) then
                countseen = countseen + 1; 
            end
        end
    end
    return countseen;
end

function GetWeaponCategoryFromWeapon(HandWeapon)--if there is one category, return it. if there is more, return the first met that is not Improvised, if there is none, return Neither
    local categories = HandWeapon:getCategories()
    local i = 0
    local chosenCategory = "Neither";
    for i=0,categories:size()-1 do
        if AchievementsOptions.Verbose then print ("Achievements GetWeaponCategoryFromWeapon categorie["..i.."] = "..categories:get(i)); end
        if (categories:get(i) ~= "Improvised") then return categories:get(i) end
        chosenCategory = categories:get(i);
    end
    return chosenCategory;
end

function PlayerHasItem(player,itemname)
    local inv = player:getInventory()
    if(inv:contains(itemname)) then return true end
    local backpack = player:getClothingItem_Back()
    if(backpack ~= nil) and (backpack.getItemContainer ~= nil) and (backpack:getItemContainer():contains(itemname)) then return true end
    local second = player:getSecondaryHandItem()
    if(second ~= nil) and (second.getItemContainer ~= nil) and (second:getItemContainer():contains(itemname)) then return true end
    local prim = player:getPrimaryHandItem()
    if(prim ~= nil) and (prim.getItemContainer ~= nil) and (prim:getItemContainer():contains(itemname)) then return true end
    return false
end
