require "ISUI/ISLayoutManager"
local TheAchievementButton = ISButton:derive("TheAchievementButton");

AchievementButton = false 
AchievementButtonAdded = false

function AchievementToggleWindow()
    
    if(ButtonToggle) then 
        ShowNewAchievement()
    else
        WindowVisible = not myAchievementsWindow:getIsVisible()
        
        myAchievementsWindow:setVisible(WindowVisible)
        if(WindowVisible == false) then myAchievementDescWindow:setVisible(WindowVisible) end
        
        ButtonToggle = false
        
        NAUButton:setVisible(false)
    end
    
end

function ShowNewAchievement()

    myAchievementDescWindow:setVisible(true)
    myAchievementsWindow:setVisible(true)
    
    ButtonToggle = false
    
    NAUButton:setVisible(false)
    
end

function AchievementsCreateAchievementButton()
    TrophyTextureOn = getTexture("media/textures/TrophyOn.png");
    TrophyTextureOff = getTexture("media/textures/TrophyOff.png");
    NAUTexture = getTexture("media/textures/nau.png");
    
    if(not TrophyTextureOff) then print("could not load media/textures/TrophyOff.png"); end
        
    AchievementButton = TheAchievementButton:new(getCore():getScreenWidth() - 150, getCore():getScreenHeight() - 50, 25, 25, "", nil, AchievementToggleWindow);
    AchievementButton:setImage(TrophyTextureOff);
    
    AchievementButton:setVisible(true);
    AchievementButton:setEnable(true);
    --AchievementButton.textureColor.r = 255;
    AchievementButton:addToUIManager();
    AchievementButtonAdded = true;
    
    NAUButton = TheAchievementButton:new(getCore():getScreenWidth() - 425, getCore():getScreenHeight() - 50, 250, 25, "", nil, ShowNewAchievement);
    NAUButton:setImage(NAUTexture);    
    NAUButton:setVisible(false);
    NAUButton:setEnable(true);
    --AchievementButton.textureColor.r = 255;
    NAUButton:addToUIManager();
    
end

function AchievementsButtonSwitchVisibility()
    if AchievementsOptions.DisplayAchievementButton and not AchievementButtonAdded then
        AchievementButton:addToUIManager();
        AchievementButtonAdded = true;
    end
    if not AchievementsOptions.DisplayAchievementButton and AchievementButtonAdded then
        AchievementButton:removeFromUIManager();
        AchievementButtonAdded = false;
    end
end

Events.OnGameStart.Add(AchievementsCreateAchievementButton);
Events.OnLoad.Add(AchievementsButtonSwitchVisibility);
