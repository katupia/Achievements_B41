require "ISUI/ISPanelJoypad"
require "ISUI/ISRichTextPanel"

AchievementMessage = ISPanelJoypad:derive("AchievementMessage");


--************************************************************************--
--** ISDemoPopup:initialise
--**
--************************************************************************--

function AchievementMessage:initialise()
    ISPanelJoypad.initialise(self);
end

--************************************************************************--
--** ISDemoPopup:instantiate
--**
--************************************************************************--
function AchievementMessage:createChildren()

    -- CREATE TUTORIAL PANEL
    local panel = ISRichTextPanel:new(15, 10, self.width-30, self.height-32-10);
    panel:initialise();

    self:addChild(panel);
    --panel:paginate();
    self.richtext = panel;
    self.richtext.text = self.message;
    self.richtext:paginate();
    self.richtext.backgroundColor.a = 0;

end


function AchievementMessage:setInfo(item)

end

function AchievementMessage:onMouseWheel(del)
    return false;
end

--************************************************************************--
--** ISDemoPopup:update
--**
--************************************************************************--
function AchievementMessage:update()
    if self.test ~= nil then
        if(self.test()) then
            AchievementMessage.instance = nil;
            self:removeFromUIManager();
            self.test = nil;
            self.target:onClose(self);
        end
    end
end
function AchievementMessage:render()
    self:setWidth(self.richtext:getWidth() + 40);
    self:setHeight(self.richtext:getHeight() + 35);

    self:drawTextureScaled(AchievementMessage.spiffo, self.width - 43, -60, 256/2, 364/2, 1, 1, 1, 1);
    
    if JoypadState[1] and self.clickToSkip and getJoypadFocus(0) ~= self and not Tutorial1.disableMsgFocus then
        setJoypadFocus(0, self)
    end

end

function AchievementMessage:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData);
end

function AchievementMessage:onJoypadDown(button)
    if AchievementMessage.instance and AchievementMessage.instance.clickToSkip and button == Joypad.AButton then
        local instance = AchievementMessage.instance;
        AchievementMessage.instance = nil;
        instance:removeFromUIManager();
        instance.target:onClose(instance);
        setJoypadFocus(0, nil)
    end
end

AchievementMessage.onKeyPressed = function(key)
    print ("AchievementMessage.onKeyPressed called");--never called as far as I know
    if AchievementMessage.instance and key == Keyboard.KEY_SPACE and AchievementMessage.instance.clickToSkip then
        local instance = AchievementMessage.instance;
        AchievementMessage.instance = nil;
        instance:removeFromUIManager();
        instance.target:onClose(instance);
    end
end

AchievementMessage.getInstance = function(x, y, w, h, message, clickToSkip, target, test)
    if AchievementMessage.instance ~= nil then
        return AchievementMessage.instance;
    end;
    x = x - (w / 2);
    y = y - (h/2);
    if AchievementMessage.instance ~= nil then
        AchievementMessage.instance:removeFromUIManager();
        AchievementMessage.instance:setX(x);
        AchievementMessage.instance:setY(y);
        AchievementMessage.instance:setWidth(w);
        AchievementMessage.instance:setHeight(h);
        AchievementMessage.instance.message = message;
        AchievementMessage.instance.clickToSkip = clickToSkip;
        AchievementMessage.instance:alwaysOnTop();
        AchievementMessage.instance:setAlwaysOnTop(true);
    else
        AchievementMessage.instance = AchievementMessage:new(x, y, w, h, clickToSkip, message);
        AchievementMessage.instance:initialise();
        AchievementMessage.instance:addToUIManager();
        AchievementMessage.instance:setAlwaysOnTop(true);
    end
    AchievementMessage.instance.target = target;
    AchievementMessage.instance.test = test;
    return AchievementMessage.instance;
end

--************************************************************************--
--** ISDemoPopup:new
--**
--************************************************************************--
function AchievementMessage:new (x, y, width, height, clickToSkip, message)
    local o = {}
    --o.data = {}
    o = ISPanelJoypad:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.x = x;
    if clickToSkip then
        if JoypadState.players[1] then
            message = message .. " <LINE> <LINE> <CENTER> <IMAGECENTRE:media/ui/xbox/XBOX_A.png>";
        else
            message = message .. " <LINE> <LINE> <SIZE:large> (Click to skip)";
        end
    end
    o.message = message;
    o.clickToSkip = clickToSkip;
        
    AchievementMessage.spiffo = getTexture("media/ui/survivorspiffo.png");
    o.y = y;
    o.borderColor = {r=1, g=1, b=1, a=0.7};
    o.backgroundColor = {r=0, g=0, b=0, a=0.1};
    o.width = width;
    o.height = height;
    o.anchorLeft = true;
    o.anchorRight = false;
    o.anchorTop = true;
    o.anchorBottom = false;
    o.timer = 0;
    o.clicktoSkip = false;
    return o
end
