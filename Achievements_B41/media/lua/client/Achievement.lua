
Achievement = {}
Achievement.__index = Achievement

function Achievement:new(inCodeName,inDisplayName,inDescription,inIcon)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	
	o.CodeName = inCodeName
	o.DisplayName = inDisplayName
	o.Description = inDescription
	o.icon = InIcon
	o.isAComplete = false
	o.BannerMSG = nil
    -- print ("Achievement "..inCodeName.." "..inDisplayName.." "..inDescription.." "..inIcon);
	return o
end

function Achievement:getDisplayName()
	
	return self.DisplayName
end
function Achievement:getCodeName()
	return self.CodeName
end


function Achievement:setComplete(status, silent)
	if(self.isAComplete == status) then return false end
	self.isAComplete = status;
	if(status) then 
		MyAchievementManager:update();
		if(silent == false) then
			--getPlayer():Say(self.DisplayName .. " Achievement Complete!")
		
			getSoundManager():PlaySound("unlock", false, 0.8);	
			-- print(self.DisplayName .. " achievement set as complete!");
			ButtonToggle = true;
			NAUButton:setVisible(true);
		end
	end
	return self.isAComplete
end

function Achievement:isComplete()
	return self.isAComplete
end
