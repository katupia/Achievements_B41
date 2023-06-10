-- These are the default options.
if not AchievementsOptions then  AchievementsOptions = {} end
if not AchievementsOptions.Verbose then AchievementsOptions.Verbose = false end
if not AchievementsOptions.DisplayAchievementButton then AchievementsOptions.DisplayAchievementButton = true end
if not AchievementsOptions.DisplayAchievementBeforeCompletion then AchievementsOptions.DisplayAchievementBeforeCompletion = false end

-- Connecting the options to the menu, so user can change them.
if ModOptions and ModOptions.getInstance then
  local settings = ModOptions:getInstance(AchievementsOptions, "Achievements_B41", "Achievements B41")
  
  
  local opt1 = settings:getData("DisplayAchievementButton")
  function opt1:OnApplyInGame(val)
    AchievementsButtonSwitchVisibility();
  end  
  local opt2 = settings:getData("DisplayAchievementBeforeCompletion")
  function opt2:OnApplyInGame(val)
    DisplayAchievementBeforeCompletionSwitchVisibility();
  end  
end

-- Check actual options at game loading.
-- Events.OnGameStart.Add(function() print("Always display achievement button = ", AchievementsOptions.DisplayAchievementButton) end)
