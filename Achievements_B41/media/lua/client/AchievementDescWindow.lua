AchievementDescWindow = ISCollapsableWindow:derive("AchievementDescWindow");

function AchievementDescWindow:initialise()
	ISCollapsableWindow.initialise(self);
end

function AchievementDescWindow:new(x, y, width, height)
	local o = {};
	o = ISCollapsableWindow:new(x, y, width, height);
	setmetatable(o, self);
	self.__index = self;
	o.title = "Achievement Description";
	o.pin = false;
	o:noBackground();
	return o;
end

function AchievementDescWindow:setText(newText,CodeName)
	self.HomeWindow.text = newText;
	self.HomeWindow:paginate();
	local tempTexture = getTexture("media/textures/".. tostring(CodeName) ..".png")
	if (tempTexture) then self.Image:setImage(tempTexture) 
	else self.Image:setImage(getTexture("media/textures/Default.png")) end
end
function AchievementDescWindow:setTitle(newText)
	self.HomeWindow.title = newText;
	self.HomeWindow:paginate();
end


function AchievementDescWindow:createChildren()
	ISCollapsableWindow.createChildren(self);
	self.HomeWindow = ISRichTextPanel:new(0, 16, 375, 455);
	self.HomeWindow:initialise();
	self.HomeWindow.autosetheight = false
	self.HomeWindow:ignoreHeightChange()
	self:addChild(self.HomeWindow)
	
	
	self.Image = ISButton:new(38, 115, 300, 300, " ", nil, nil);
    self.Image:setImage(getTexture("media/textures/Default.png"))
    self.Image:setVisible(true);
	self.Image:setEnable(true);
	--self.Image:addToUIManager();
	self:addChild(self.Image)
end

function AchievementDescWindowCreate()
	myAchievementDescWindow = AchievementDescWindow:new(500, 285, 375, 455)
	myAchievementDescWindow:addToUIManager();
	myAchievementDescWindow:setVisible(false);
	myAchievementDescWindow.pin = true;
	myAchievementDescWindow.resizable = true
	
	--AchievementButton.textureColor.r =
end

Events.OnGameStart.Add(AchievementDescWindowCreate);