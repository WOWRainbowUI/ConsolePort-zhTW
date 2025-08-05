local db, _, env = ConsolePort:DB(), ...;
local UIHandle, Input, FadeIn = db.UIHandle, db.Input, db.Alpha.FadeIn;
local LootFrame = Mixin(CPAPI.EventHandler(ConsolePortLootFrame, {
	'LOOT_OPENED';
	'LOOT_CLOSED';
	'LOOT_READY';
	'LOOT_SLOT_CLEARED';
	'LOOT_SLOT_CHANGED';
	'OPEN_MASTER_LOOT_LIST';
	'UPDATE_MASTER_LOOT_LIST';
	'PLAYER_REGEN_DISABLED';
}), CPFocusPoolMixin, CPPropagationMixin)

---------------------------------------------------------------
-- Events
---------------------------------------------------------------
function LootFrame:LOOT_READY()
	if GetNumLootItems() < 1 then
		return CloseLoot()
	end
	self:UpdateItems(true)
end

function LootFrame:LOOT_SLOT_CLEARED()
	-- HACK: using CloseLoot here crashes the game (9.0.2.36839),
	-- therefore, just check active buttons and return if the
	-- container only has 1 item.
	if ( self:GetNumActive() == 1 ) then
		return
	end
	self:UpdateItems(false)
end

function LootFrame:LOOT_SLOT_CHANGED()
	if GetNumLootItems() < 1 then
		return CloseLoot()
	end
	self:UpdateItems(false)
end

function LootFrame:LOOT_OPENED(autoLoot, isFromItem)
	if autoLoot then
		self:LootAllItems()
	end
	if isFromItem then
		PlaySound(SOUNDKIT.UI_CONTAINER_ITEM_OPEN)
	end
	self:Show()
end

function LootFrame:LOOT_CLOSED()
	self:Hide()
end

function LootFrame:OPEN_MASTER_LOOT_LIST()
	ToggleDropDownMenu(1, nil, GroupLootDropDown, self:GetFocusWidget(), 0, 0)
end

function LootFrame:UPDATE_MASTER_LOOT_LIST()
	MasterLooterFrame_UpdatePlayers()
end

function LootFrame:PLAYER_REGEN_DISABLED()
	self:SetPropagation(false)
end

---------------------------------------------------------------
-- Script handlers
---------------------------------------------------------------
function LootFrame:OnShow()
	self.Header.HeaderOpenAnim:Stop()
	self.Header.HeaderOpenAnim:Play()

	if ConsolePort:IsCursorActive() then
		ConsolePort:AddInterfaceCursorFrame(self)
		ConsolePort:SetCursorNode(self:GetFocusWidget())
	else
		self:SetHints()
	end
end

function LootFrame:OnHide()
	self:ReleaseAll()
	self.Header.HeaderOpenAnim:Finish()
	self:ClearHints()
	ConsolePort:RemoveInterfaceCursorFrame(self)
end

function LootFrame:OnDataLoaded()
	CPFocusPoolMixin.OnLoad(self)
	self:CreateFramePool('Button', 'CPUISimpleLootButtonTemplate', env.LootButtonMixin)
	self:SetScript('OnHide', self.OnHide)
	self:SetScript('OnShow', self.OnShow)
	self:SetScript('OnGamePadButtonDown', self.OnGamePadButtonDown)
	self.focusIndex = 1;

	self.Header.Text:SetText(LOOT)
	self.Header:SetDurationMultiplier(.5)

	CPAPI.DisableFrame(_G.LootFrame)
	_G.LootFrame:UnregisterAllEvents()
	return CPAPI.BurnAfterReading;
end

function LootFrame:SetHints()
	UIHandle:SetHintFocus(self)
	UIHandle:AddHint('PAD1', LOOT)
	UIHandle:AddHint('PAD2', ALL)
	UIHandle:AddHint('PAD4', CLOSE)
end

function LootFrame:ClearHints()
	if UIHandle:IsHintFocus(self) then
		UIHandle:HideHintBar()
	end
	UIHandle:ClearHintsForFrame(self)
end

function LootFrame:OnCursorShow()
	if not self:IsShown() then return end;
	ConsolePort:AddInterfaceCursorFrame(self)
	self:ClearHints()
end

function LootFrame:OnCursorHide()
	if not self:IsShown() then return end;
	self:SetHints()
end

db:RegisterCallback('OnCursorShow', LootFrame.OnCursorShow, LootFrame)
db:RegisterCallback('OnCursorHide', LootFrame.OnCursorHide, LootFrame)

LootFrame.CloseOnButton = {
	PAD3 = true;
	PAD4 = true;
	PADBACK = true;
	PADSYSTEM = true;
	PADSOCIAL = true;
	PADFORWARD = true;
}

function LootFrame:OnGamePadButtonDown(button)
	if Input:IsOverrideActive(CPAPI.CreateKeyChord(button)) then
		return self:SetPropagation(true)
	end
	self:SetPropagation(false)

	if (button == 'PAD1') then
		local lootSlot = self:GetFocusWidget()
		if lootSlot then
			lootSlot:OnClick()
		end
	elseif (button == 'PAD2') then
		self:LootAllItems()
	elseif (button == 'PADDDOWN') then
		self:UpdateFocus(self.focusIndex + 1)
	elseif (button == 'PADDUP') then
		self:UpdateFocus(self.focusIndex - 1)
	elseif (self.CloseOnButton[button]) then
		CloseLoot()
	end
end

---------------------------------------------------------------
-- Content handling
---------------------------------------------------------------
function LootFrame:UpdateItems(fadeOnShow)
	self:ReleaseAll()

	local count, prev = 1;
	for i = 1, GetNumLootItems() do
		if LootSlotHasItem(i) then
			local button, newObj = self:TryAcquireRegistered(count)
			if newObj then
				button:OnLoad()
			end

			button:SetID(i)
			button:Show()
			button:Update()

			if fadeOnShow then
				FadeIn(button, 0.3, 0, 1)
			end

			if prev then
				button:SetPoint('TOPRIGHT', prev.NameFrame, 'BOTTOMLEFT', 36, -4)
			else
				button:SetPoint('TOPLEFT', 0, -8)
			end
			prev, count = button, count + 1;
		end
	end

	local numActive = self:GetNumActive()
	if ( numActive < 1 ) then
		CloseLoot()
		return self:Hide()
	end

	self:AdjustHeight(numActive * 52)
	self:UpdateFocus(self.focusIndex)
end

function LootFrame:UpdateFocus(index)
	self.focusIndex = Clamp(index, 1, self:GetNumActive())

	local newObj, oldObj = self:SetFocusByIndex(self.focusIndex)
	if oldObj then oldObj:OnLeave() end
	if newObj then newObj:OnEnter() end
end

function LootFrame:AdjustHeight(newHeight)
	self:SetScript('OnUpdate', function(self)
		local height = self:GetHeight() or 0;
		local diff = newHeight - height;
		if abs(newHeight - height) < 0.5 then
			self:SetHeight(newHeight)
			self:SetScript('OnUpdate', nil)
		else
			self:SetHeight(height + ( diff / 5 ) )
		end
	end)
end

function LootFrame:LootAllItems()
	for i = GetNumLootItems(), 1, -1 do
		LootSlot(i)
	end
end