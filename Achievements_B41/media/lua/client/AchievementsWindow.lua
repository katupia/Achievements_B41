AchievementsWindow = ISCollapsableWindow:derive("AchievementsWindow");

function AchievementsWindow:initialise()
    ISCollapsableWindow.initialise(self);
end

local function AItemClickHandle()
    
    MyAchievementManager:setDescWindow(myAchievementsWindow:getSelected())

end

function AchievementsWindow:new(x, y, width, height)
    local o = {};
    o = ISCollapsableWindow:new(x, y, width, height);
    setmetatable(o, self);
    self.__index = self;
    o.title = "Achievements";
    o.pin = false;
    --o:noBackground();
    
    return o;
end

function AchievementsWindow:setText(newText)
    self.HomeWindow.text = newText;
    self.HomeWindow:paginate();
end

function AchievementsWindow:getSelected()
    --return self.HomeWindow.selected;
    local index = self.HomeWindow.mouseoverselected
    local item = self.HomeWindow.items[index]
    if(item) then return item.item
    else return nil end
end

function AchievementsWindow:setSelected(CodeName)
    
    for i,v in ipairs(self.HomeWindow.items) do
        --print(tostring(v.item).. "==".. tostring(CodeName))
        if v.item == CodeName then
            self.HomeWindow.mouseoverselected = i
            self.HomeWindow.selected = i
            self.HomeWindow:ensureVisible(i)
            --print("selected set to "..tostring(i))
            return true
        end
    end
    return false
end

function AchievementsWindow:AddItem(DisplayName,CodeName)
    self.HomeWindow:addItem(DisplayName,CodeName)
end
function AchievementsWindow:RemoveAll()
    self.HomeWindow:clear()
end

function AchievementsWindow:Update()
    local selected = self.HomeWindow.selected
    self.HomeWindow:clear()
    for k, v in pairs(AchievementList) do
        MyAchievementManager:addAchievement(k,v[1],v[2])
    end
    self.HomeWindow:sort()
    self.HomeWindow.selected = selected
    self.HomeWindow.mouseoverselected = selected
    self.HomeWindow:ensureVisible(selected)
    MyAchievementManager:update();
end

function AchievementsWindow:setHeaderText(newtext)
    self.Header.text = newtext
    self.Header:paginate()
end

function AchievementsWindow:createChildren()

    ISCollapsableWindow.createChildren(self);
    self.Header = ISRichTextPanel:new(0, 13, 470, 50);
    self.Header:initialise();
    self.Header.autosetheight = false
    self.Header:ignoreHeightChange()    
    self:addChild(self.Header)
    
    self.HomeWindow = ISScrollingListBox:new(0, 40, 470, 420);
    self.HomeWindow.onmousedblclick = AItemClickHandle;
    self.HomeWindow.itemheight = 30
    self.HomeWindow:initialise();
    self:addChild(self.HomeWindow)
end

function AchievementsWindowCreate()
    myAchievementsWindow = AchievementsWindow:new(15, 285, 475, 470)
    myAchievementsWindow:addToUIManager();
    myAchievementsWindow:setVisible(false);
    myAchievementsWindow.pin = true;
    myAchievementsWindow.resizable = false;--needs to resize the ISScrollingListBox too if we set this to true
end

