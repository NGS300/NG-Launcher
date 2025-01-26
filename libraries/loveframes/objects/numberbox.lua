--[[------------------------------------------------
	-- Love Frames - A GUI library for LOVE --
	-- Copyright (c) 2012-2014 Kenny Shields --
--]]------------------------------------------------

return function(loveframes)
---------- module start ----------

-- numberbox object
local newobject = loveframes.NewObject("numberbox", "loveframes_object_numberbox", true)

--[[---------------------------------------------------------
	- func: initialize()
	- desc: initializes the object
--]]---------------------------------------------------------
function newobject:initialize()
	
	self.type = "numberbox"
	self.width = 80
	self.height = 20
	self.value = 0
	self.increaseamount = 1
	self.decreaseamount = 1
	self.min = -100
	self.max = 100
	self.delay = 0
	self.decimals = 0
	self.internal = false
	self.canmodify = false
	self.lastbuttonclicked = false
	self.pad = false
	self.internals = {}
	self.OnValueChanged = nil
	
	local input = loveframes.objects["textinput"]:new()
	input.parent = self
	input:SetSize(50, 20)
	input:SetUsable({"1", "2", "3", "4", "5", "6", "7", "8", "9", "0", ".", "-"})
	input:SetTabReplacement("")
	input:SetText(self.value)
	input.OnTextChanged = function(object)
		local value = self.value
		local newvalue = tonumber(object.lines[1])
		if not newvalue then
			self.value = value
			input:SetText(value)
			return
		end
		self.value = newvalue
		if self.value > self.max then
			self.value = self.max
			object:SetText(self.value)
		end
		if self.value < self.min then
			self.value = self.min
			object:SetText(self.value)
		end
		if value ~= self.value then
			if self.OnValueChanged then
				self.OnValueChanged(self, self.value)
			end
		end
	end
	input.OnFocusLost = function(object)
		self:updateinput()
	end
	input.Update = function(object)
		object:SetSize(object.parent.width - 20, object.parent.height)
	end
	
	local increasebutton = loveframes.objects["button"]:new()
	increasebutton.parent = self
	increasebutton:SetWidth(21)
	increasebutton:SetText("+")
	increasebutton.OnClick = function()
		local canmodify = self.canmodify
		if not canmodify then
			self:ModifyValue("add")
		else
			self.canmodify = false
		end
	end
	increasebutton.Update = function(object)
		local time = 0
		time = love.timer.getTime()
		local delay = self.delay
		local down = object.down
		local canmodify = self.canmodify
		local lastbuttonclicked = self.lastbuttonclicked
		object:SetPos(object.parent.width - 21, 0)
		object:SetHeight(object.parent.height/2 + 1)
		if down and not canmodify then
			self:ModifyValue("add")
			self.canmodify = true
			self.delay = time + 0.80
			self.lastbuttonclicked = object
		elseif down and canmodify and delay < time then
			self:ModifyValue("add")
			self.delay = time + 0.02
		elseif not down and canmodify and lastbuttonclicked == object then
			self.canmodify = false
			self.delay = time + 0.80
		end
	end
	
	local decreasesbutton = loveframes.objects["button"]:new()
	decreasesbutton.parent = self
	decreasesbutton:SetWidth(21)
	decreasesbutton:SetText("-")
	decreasesbutton.OnClick = function()
		local canmodify = self.canmodify
		if not canmodify then
			self:ModifyValue("subtract")
		else
			self.canmodify = false
		end
	end
	decreasesbutton.Update = function(object)
		local time = 0
		time = love.timer.getTime()
		local delay = self.delay
		local down = object.down
		local canmodify = self.canmodify
		local lastbuttonclicked = self.lastbuttonclicked
		object:SetPos(object.parent.width - 21, object.parent.height/2)
		object:SetHeight(object.parent.height/2)
		if down and not canmodify then
			self:ModifyValue("subtract")
			self.canmodify = true
			self.delay = time + 0.80
			self.lastbuttonclicked = object
		elseif down and canmodify and delay < time then
			self:ModifyValue("subtract")
			self.delay = time + 0.02
		elseif not down and canmodify and lastbuttonclicked == object then
			self.canmodify = false
			self.delay = time + 0.80
		end
	end
	
	table.insert(self.internals, input)
	table.insert(self.internals, increasebutton)
	table.insert(self.internals, decreasesbutton)
	
	self:SetDrawFunc()
end

function newobject:updateinput()

	local value = self.value
	if self.pad then
		local maxabs = math.max(math.abs(self.min), math.abs(self.max))
		-- A range from 0 to 0 would be unusual, but it would break the math.
		if maxabs == 0 then maxabs = 1 end
		local integralwidth = math.floor(math.log10(maxabs)) + 1
		local width = integralwidth
		if self.decimals > 0 then
			width = width + self.decimals + 1
		end
		if value < 0 then
			width = width + 1
		end
		local formatstring = string.format("%%0%d.%df", width, self.decimals)
		value = string.format(formatstring, value)
	end
	local input = self.internals[1]
	input:SetText(value)

end

--[[---------------------------------------------------------
	- func: update(deltatime)
	- desc: updates the element
--]]---------------------------------------------------------
function newobject:update(dt)
	
	local state = loveframes.state
	local selfstate = self.state
	
	if state ~= selfstate then
		return
	end
	
	local visible = self.visible
	local alwaysupdate = self.alwaysupdate
	
	if not visible then
		if not alwaysupdate then
			return
		end
	end
	
	local internals = self.internals
	local parent = self.parent
	local base = loveframes.base
	local update = self.Update
	
	-- move to parent if there is a parent
	if parent ~= base and parent.type ~= "list" then
		self.x = self.parent.x + self.staticx
		self.y = self.parent.y + self.staticy
	end
	
	self:CheckHover()
	
	for k, v in ipairs(internals) do
		v:update(dt)
	end
	
	if update then
		update(self, dt)
	end

end

--[[---------------------------------------------------------
	- func: mousepressed(x, y, button)
	- desc: called when the player presses a mouse button
--]]---------------------------------------------------------
function newobject:mousepressed(x, y, button)

	local state = loveframes.state
	local selfstate = self.state
	
	if state ~= selfstate then
		return
	end
	
	local visible = self.visible
	
	if not visible then
		return
	end
	
	local internals = self.internals
	local hover = self.hover
	
	if hover and button == 1 then
		local baseparent = self:GetBaseParent()
		if baseparent and baseparent.type == "frame" then
			baseparent:MakeTop()
		end
	end
	
	for k, v in ipairs(internals) do
		v:mousepressed(x, y, button)
	end
	
end

--[[---------------------------------------------------------
	- func: SetValue(value)
	- desc: sets the object's value
--]]---------------------------------------------------------
function newobject:SetValue(value)

	local min = self.min
	local curvalue = self.value
	local value = tonumber(value) or min
	local internals = self.internals
	local onvaluechanged = self.OnValueChanged
	
	self.value = value
	self:updateinput()
	
	if value ~= curvalue and onvaluechanged then
		onvaluechanged(self, value)
	end
	
	return self
	
end

--[[---------------------------------------------------------
	- func: GetValue()
	- desc: gets the object's value
--]]---------------------------------------------------------
function newobject:GetValue()

	return self.value
	
end

--[[---------------------------------------------------------
	- func: SetIncreaseAmount(amount)
	- desc: sets the object's increase amount
--]]---------------------------------------------------------
function newobject:SetIncreaseAmount(amount)

	self.increaseamount = amount
	return self
	
end

--[[---------------------------------------------------------
	- func: GetIncreaseAmount()
	- desc: gets the object's increase amount
--]]---------------------------------------------------------
function newobject:GetIncreaseAmount()

	return self.increaseamount
	
end

--[[---------------------------------------------------------
	- func: SetDecreaseAmount(amount)
	- desc: sets the object's decrease amount
--]]---------------------------------------------------------
function newobject:SetDecreaseAmount(amount)

	self.decreaseamount = amount
	return self
	
end

--[[---------------------------------------------------------
	- func: GetDecreaseAmount()
	- desc: gets the object's decrease amount
--]]---------------------------------------------------------
function newobject:GetDecreaseAmount()

	return self.decreaseamount
	
end

--[[---------------------------------------------------------
	- func: SetMax(max)
	- desc: sets the object's maximum value
--]]---------------------------------------------------------
function newobject:SetMax(max)

	local onvaluechanged = self.OnValueChanged
	
	self.max = max
	
	if self.value > max then
		self.value = max
		if onvaluechanged then
			onvaluechanged(self, max)
		end
	end
	self:updateinput()
	
	return self
	
end

--[[---------------------------------------------------------
	- func: GetMax()
	- desc: gets the object's maximum value
--]]---------------------------------------------------------
function newobject:GetMax()

	return self.max
	
end

--[[---------------------------------------------------------
	- func: SetMin(min)
	- desc: sets the object's minimum value
--]]---------------------------------------------------------
function newobject:SetMin(min)

	local onvaluechanged = self.OnValueChanged
	
	self.min = min
	
	if self.value < min then
		self.value = min
		if onvaluechanged then
			onvaluechanged(self, min)
		end
	end
	self:updateinput()
	
	return self
	
end

--[[---------------------------------------------------------
	- func: GetMin()
	- desc: gets the object's minimum value
--]]---------------------------------------------------------
function newobject:GetMin()

	return self.min
	
end

--[[---------------------------------------------------------
	- func: SetMinMax()
	- desc: sets the object's minimum and maximum values
--]]---------------------------------------------------------
function newobject:SetMinMax(min, max)

	local onvaluechanged = self.OnValueChanged
	
	self.min = min
	self.max = max
	
	if self.value > max then
		self.value = max
		self:updateinput()
		if onvaluechanged then
			onvaluechanged(self, max)
		end
	end
	
	if self.value < min then
		self.value = min
		self:updateinput()
		if onvaluechanged then
			onvaluechanged(self, min)
		end
	end
	
	return self
	
end

--[[---------------------------------------------------------
	- func: GetMinMax()
	- desc: gets the object's minimum and maximum values
--]]---------------------------------------------------------
function newobject:GetMinMax()

	return self.min, self.max
	
end

--[[---------------------------------------------------------
	- func: ModifyValue(type)
	- desc: modifies the object's value
--]]---------------------------------------------------------
function newobject:ModifyValue(type)

	local value = self.value
	local decimals = self.decimals
	local onvaluechanged = self.OnValueChanged
	
	if not value then
		return
	end
	
	if type == "add" then
		local increaseamount = self.increaseamount
		local max = self.max
		self.value = value + increaseamount
		if self.value > max then
			self.value = max
		end
		self.value = loveframes.Round(self.value, decimals)
		self:updateinput()
		if value ~= self.value then
			if onvaluechanged then
				onvaluechanged(self, self.value)
			end
		end
	elseif type == "subtract" then
		local decreaseamount = self.decreaseamount
		local min = self.min
		self.value = value - decreaseamount
		if self.value < min then
			self.value = min
		end
		self.value = loveframes.Round(self.value, decimals)
		self:updateinput()
		if value ~= self.value then
			if onvaluechanged then
				onvaluechanged(self, self.value)
			end
		end
	end
	
	return self
	
end

--[[---------------------------------------------------------
	- func: SetDecimals(decimals)
	- desc: sets how many decimals the object's value 
			can have
--]]---------------------------------------------------------
function newobject:SetDecimals(decimals)

	self.decimals = decimals
	self:updateinput()
	return self
	
end

--[[---------------------------------------------------------
	- func: GetDecimals()
	- desc: gets how many decimals the object's value 
			can have
--]]---------------------------------------------------------
function newobject:GetDecimals()

	return self.decimals
	
end

--[[---------------------------------------------------------
	- func: SetPad(decimals)
	- desc: sets whether to pad the object's value
			with zeroes
--]]---------------------------------------------------------
function newobject:SetPad(pad)

	self.pad = pad
	self:updateinput()
	return self

end

--[[---------------------------------------------------------
	- func: GetPad()
	- desc: gets whether to pad the object's value
			with zeroes
--]]---------------------------------------------------------
function newobject:GetPad()

	return self.pad

end

---------- module end ----------
end
