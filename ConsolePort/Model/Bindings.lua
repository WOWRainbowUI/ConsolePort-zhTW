local Bindings, _, db = CPAPI.CreateDataHandler(), ...; db:Register('Bindings', Bindings)
local function client(id) return [[Interface\Icons\]]..id end;
---------------------------------------------------------------
-- Binding handler
---------------------------------------------------------------
do local function click(id, btn) return ('CLICK %s%s:%s'):format(_, id, btn or 'LeftButton') end;

	Bindings.Custom = {
		EasyMotion        = click 'EasyMotionButton';
		Page2             = click('Pager', 2);
		Page3             = click('Pager', 3);
		Page4             = click('Pager', 4);
		Page5             = click('Pager', 5);
		Page6             = click('Pager', 6);
		PetRing           = click 'PetRing';
		RaidCursorFocus   = click 'RaidCursorFocus';
		RaidCursorTarget  = click 'RaidCursorTarget';
		RaidCursorToggle  = click 'RaidCursorToggle';
		UICursorToggle    = click 'Cursor';
		UtilityRing       = click 'UtilityToggle';
		MenuRing          = click 'MenuTrigger';
		--FocusButton     = click 'FocusButton';
	};
end

---------------------------------------------------------------
-- Special bindings provider
---------------------------------------------------------------
do local function hold(binding) return ('%s (按住)'):format(binding) end;

	Bindings.Special = {
		---------------------------------------------------------------
		-- Targeting
		---------------------------------------------------------------
		{	binding = Bindings.Custom.EasyMotion;
			name    = hold'目標單位框架';
			desc    = [[
				為畫面上的單位框架產生單位快速鍵，讓你能夠在友方目標之間快速做切換。

				用法為，先按住綁定的按鈕不放，然後按下你要選擇的目標的提示按鈕，再放開綁定的按鈕來切換目標。

				非常推薦治療者在 5 人隊伍中使用這個按鈕綁定，這是一種在小型隊伍中非常快速的選擇目標方式。

				在團隊中，則會變成需要很複雜的操作才能選到你要的目標。團隊游標會是另一種較適合的選擇。
			]];
			image = {
				file  = CPAPI.GetAsset([[Tutorial\UnitHotkey]]);
				width = 256;
				height = 256;
			};
		};
		{	binding = Bindings.Custom.RaidCursorToggle;
			name    = '切換團隊游標';
			desc    = [[
				切換顯示指向畫面上單位框架的游標，讓你在治療友方玩家的同時，還能保有另一個選取目標。

				團隊游標也可以設為直接選取目標，移動游標時便會切換你的當前目標。

				使用時，團隊游標會佔用一組方向鍵組合來控制游標的位置。

				在不切換目標對該目標施法的模式中，游標不會對該目標施放巨集或友方/敵方皆可使用的技能，例如牧師的懺悟。

				另一種選擇是目標單位框架。
			]];
			image = {
				file  = CPAPI.GetAsset([[Tutorial\RaidCursor]]);
				width = 256;
				height = 256;
			};
		};
		{	binding = Bindings.Custom.RaidCursorFocus;
			name    = '團隊游標設為專注目標';
		};
		{	binding = Bindings.Custom.RaidCursorTarget;
			name    = '團隊游標選為當前目標';
		};
		--[[{	name    = hold(FOCUS_CAST_KEY_TEXT);
			binding = Bindings.Custom.FocusButton;
		};]]
		---------------------------------------------------------------
		-- Utility
		---------------------------------------------------------------
		{	binding = Bindings.Custom.UICursorToggle;
			name    = '切換介面游標';
		};
		{	binding = Bindings.Custom.UtilityRing;
			name    = '工具環';
			desc    = [[
				工具環可以讓你放置不想浪費快捷列格子來放的物品、法術、巨集和坐騎。

				用法為，先按住綁定的按鈕不放，旋轉搖桿向你要選擇的項目傾斜，再放開按鈕。

				要將東西加入到工具環中，請依照介面游標的提示說明來做。另一個方法是，用滑鼠游標選取某樣東西後，再按下綁定的按鈕將它放入到工具環。

				要從工具環中移除項目，選定該項目後，依照滑鼠提示說明來操作。

				工具環會自動加入尚未放到快捷列上的任務道具和暫時性技能。
			]];
		};
		{	binding = Bindings.Custom.PetRing;
			name    = '寵物環';
			unit    = 'pet';
			desc    = [[
				用來控制當前寵物的環形選單。
			]];
			texture = [[Interface\ICONS\INV_Box_PetCarrier_01]];
		};
		{	binding = Bindings.Custom.MenuRing;
			name    = '選單環';
			desc    = [[
				將常用面板和頻繁操作集中在一個地方，方便快速使用的環形選單。

				這個環形選單也可以從遊戲選單中使用，無需單獨綁定，只需切換頁面即可。
			]];
		};
		---------------------------------------------------------------
		-- Pager
		---------------------------------------------------------------
		{	binding = Bindings.Custom.Page2;
			name    = hold(BINDING_NAME_ACTIONPAGE2);
		};
		{	binding = Bindings.Custom.Page3;
			name    = hold(BINDING_NAME_ACTIONPAGE3);
		};
		{	binding = Bindings.Custom.Page4;
			name    = hold(BINDING_NAME_ACTIONPAGE4);
		};
		{	binding = Bindings.Custom.Page5;
			name    = hold(BINDING_NAME_ACTIONPAGE5);
		};
		{	binding = Bindings.Custom.Page6;
			name    = hold(BINDING_NAME_ACTIONPAGE6);
		};
	};
end

---------------------------------------------------------------
-- Primary bindings provider
---------------------------------------------------------------
Bindings.Proxied = {
	ExtraActionButton = 'EXTRAACTIONBUTTON1';
	InteractTarget    = 'INTERACTTARGET';
	Jump              = 'JUMP';
	LeftMouseButton   = 'CAMERAORSELECTORMOVE';
	RightMouseButton  = 'TURNORACTION';
	TargetNearest     = 'TARGETNEARESTENEMY';
	TargetPrevious    = 'TARGETPREVIOUSENEMY';
	TargetScan		  = 'TARGETSCANENEMY';
	ToggleAllBags     = 'OPENALLBAGS';
	ToggleAutoRun     = 'TOGGLEAUTORUN';
	ToggleGameMenu    = 'TOGGLEGAMEMENU';
	ToggleWorldMap    = 'TOGGLEWORLDMAP';
};

Bindings.Primary = {
	---------------------------------------------------------------
	-- Mouse
	---------------------------------------------------------------
	{	binding = Bindings.Proxied.LeftMouseButton;
		name    = KEY_BUTTON1;
		desc    = [[
			用來切換自由移動的游標，讓你可以使用控制鏡頭的搖桿來移動滑鼠指標。

			當其中一個按鈕設為模擬左鍵點擊時，無法更改這個按鈕綁定。
		]];
		readonly = function() return GetCVar('GamePadCursorLeftClick') ~= 'none' end;
	};
	{	binding = Bindings.Proxied.RightMouseButton;
		name    = KEY_BUTTON2;
		desc    = [[
			用來切換中心點游標，讓你用固定在中心點位置的滑鼠，和遊戲中的物件和角色互動。

			當其中一個按鈕設為模擬右鍵點擊時，無法更改這個按鈕綁定。
		]];
		readonly = function() return GetCVar('GamePadCursorRightClick') ~= 'none' end;
	};
	---------------------------------------------------------------
	-- Targeting
	---------------------------------------------------------------
	{	binding = Bindings.Proxied.InteractTarget;
		desc    = [[
			讓你能夠與遊戲世界中的 NPC 和物件互動。

			和中心點游標有相同的功能，但是不需要將游標或十字線直接對準目標。

			在可互動的範圍內時會顯著標示。
		]];
	};
	{	binding = Bindings.Proxied.TargetScan;
		desc    = [[
			掃描前方狹窄錐形區域中的敵人。
			切換目標前，可以先按住不放來顯著標示目標。

			戰鬥中需要快速且準確的切換目標時非常有用。

			會依據瞄準方向來決定優先選取的目標，也就是說最接近錐形中心的目標會最先被選取。
			如果較遠的目標較接近錐形中心，那麼就會優先選取較遠的目標。

			建議作為大多數玩家主要的選取目標按鈕綁定。
		]];
		image = {
			file  = CPAPI.GetAsset([[Tutorial\TargetScan]]);
			width = 512 * 0.65;
			height = 256 * 0.65;
		};
	};
	{	binding = Bindings.Proxied.TargetNearest;
		desc    = [[
			在你前方最近的敵方目標之間切換。
			如果沒有當前目標，會選取最靠中心的敵人。
			否則會在最近的目標之間循環。

			切換目標前，可以先按住不放來顯著標示目標。

			建議作為次要的選取目標按鈕綁定，或是休閒玩法的主要選取目標按鈕綁定，
			或是目標掃描的準確度過高而覺得不舒服時。

			不建議在地城或其他需要高準確度的場景使用。
		]];
		image = {
			file  = CPAPI.GetAsset([[Tutorial\TargetNearest]]);
			width = 512 * 0.65;
			height = 256 * 0.65;
		};
	};
	---------------------------------------------------------------
	-- Movement keys
	---------------------------------------------------------------
	{	binding = Bindings.Proxied.Jump;
		desc    = [[
			也可以用來在水下往上游、飛行坐騎往上升和騎龍時升空或向上衝。

			跳躍可以彌補左手拇指操作的空隙。

			在一般的設定中，左搖桿控制移動。
			如果你需要在移動時按下十字鍵和按鈕的組合，跳躍可以讓你保持往前移動，拇指便能短暫的離開左搖桿。
		]];
	};
	{ 	binding = Bindings.Proxied.ToggleAutoRun;
		desc    = [[
			自動奔跑會讓角色持續朝面前的方向前進，而不需要你做任何輸入。

			在長時間的移動中，自動奔跑有助於減輕拇指的僵直，解放拇指去做其他事情。
		]];
	};
	---------------------------------------------------------------
	-- Interface
	---------------------------------------------------------------
	{	binding = Bindings.Proxied.ToggleGameMenu;
		desc    = [[
			選單按鈕綁定處理按下鍵盤 Esc 鍵時出現的所有功能，根據遊戲當前狀態來處理不同的動作。			

			如果有任何正在進行中，和法術或選取目標正有關的動作，都會被取消。
			有當前目標時，按下綁定的按鈕會清除目標。
			正在唱法時，按下綁定的按鈕會中斷施法。

			這個按鈕綁定還會根據目前畫面上顯示的內容來處理多種其他情況。
			例如：如果有打開任何面板，像是法術書，這個按鈕綁定執行必要的動作來關閉或隱藏它。

			沒有上述的任何情況時，按下綁定的按鈕會打開或關閉遊戲選單。
		]];
	};
	{	binding = Bindings.Proxied.ToggleAllBags;
		desc    = '打開或關閉所有背包。';
	};
	{	binding = Bindings.Proxied.ToggleWorldMap;
		desc = CPAPI.IsRetailVersion and '切換顯示世界地圖和任務記錄。' or '切換顯示世界地圖。';
	};
	---------------------------------------------------------------
	-- Camera
	---------------------------------------------------------------
	{	binding = 'CAMERAZOOMIN';
		desc    = '把鏡頭拉近，按住不放可持續拉近。';
	};
	{	binding = 'CAMERAZOOMOUT';
		desc    = '把鏡頭拉遠，按住不放可持續拉遠。';
	};
	---------------------------------------------------------------
	-- Misc
	---------------------------------------------------------------
	{	binding = Bindings.Proxied.ExtraActionButton;
		name    = BINDING_NAME_EXTRAACTIONBUTTON1:gsub('%d', ''):trim();
		desc    = [[
			額外技能按鈕會顯示在多種不同的任務、事件和首領戰時用到的暫時性技能。

			沒有設定這個按鈕綁定時，永遠都可以在工具環中使用額外技能。

			這個按鈕顯示在搖桿快捷列上時，看起來像是一般的技能，但是你無法更改它的內容。
		]];
	};
};

for i, set in ipairs(Bindings.Primary) do
	set.name = set.name or GetBindingName(set.binding)
end

Bindings.Dynamic = {
	{	binding = 'TARGETSELF';
		unit    = 'player';
	};
};
for i=1, (MAX_PARTY_MEMBERS or 4) do tinsert(Bindings.Dynamic,
	{	binding = 'TARGETPARTYMEMBER'..i;
		unit    = 'party'..i;
		texture = client('Achievement_PVP_A_0'..i);
	}
) end;

for i, set in ipairs(Bindings.Dynamic) do
	set.name = set.name or GetBindingName(set.binding)
end

---------------------------------------------------------------
-- Get description for custom bindings
---------------------------------------------------------------
do -- Handle custom rings
	local CUSTOM_RING_DESC = [[
		環形選單可以讓你放置不想浪費快捷列格子來放的物品、法術、巨集和坐騎。

		用法為，先按住綁定的按鈕不放，旋轉搖桿向你要選擇的項目傾斜，再放開按鈕。

		要從環形選單中移除項目，選定該項目後，依照滑鼠提示說明來操作。
	]]
	local CUSTOM_RING_ICON = [[Interface\AddOns\ConsolePort_Bar\Assets\Textures\Icons\Ring]]

	local function FindBindingInCollection(binding, collection)
		for i, set in ipairs(collection) do
			if (set.binding == binding) then
				return set;
			end
		end
	end

	function Bindings:GetCustomBindingInfo(binding)
		return FindBindingInCollection(binding, self.Special)
			or FindBindingInCollection(binding, self.Primary)
			or FindBindingInCollection(binding, self.Dynamic)
	end

	function Bindings:GetDescriptionForBinding(binding, useTooltipFormat, tooltipLineLength)
		local set = self:GetCustomBindingInfo(binding)

		if set then
			local desc, image, texture, unit = set.desc, set.image, set.texture, set.unit;
			if ( desc and useTooltipFormat ) then
				desc = CPAPI.FormatLongText(desc, tooltipLineLength)
			end
			if ( image and useTooltipFormat ) then
				image = CPAPI.CreateSimpleTextureMarkup(image.file, image.width, image.height)
			end
			if ( unit and type(texture) ~= 'function' ) then
				local default = texture;
				texture = function(self)
					if UnitExists(unit) then
						return SetPortraitTexture(self, unit)
					end
					self:SetTexture(default)
				end
				set.texture = texture;
			end
			return desc, image, set.name, texture;
		end

		local customRingName = db.Utility:ConvertBindingToDisplayName(binding)
		if customRingName then
			return CUSTOM_RING_DESC, nil, customRingName, self:GetIcon(binding) or CUSTOM_RING_ICON, customRingName;
		end
	end
end

---------------------------------------------------------------
-- Binding icon management
---------------------------------------------------------------
do local function custom(id) return ([[Interface\AddOns\ConsolePort_Bar\Assets\Textures\Icons\%s]]):format(id) end;

	local CustomIcons = {
		Bags      = custom 'Bags.png';
		Group     = custom 'Group.png';
		Jump      = custom 'Jump.png';
		Map       = custom 'Map.png';
		Menu      = custom 'Menu.png';
		Ring      = custom 'Ring.png';
		Run       = custom 'Run.png';
		Target    = custom 'Target';
		TNEnemy   = custom 'Target_Narrow_Enemy.png';
		TNFriend  = custom 'Target_Narrow_Friend.png';
		TWEnemy   = custom 'Target_Wide_Enemy.png';
		TWFriend  = custom 'Target_Wide_Friend.png';
		TWNeutral = custom 'Target_Wide_Neutral.png';
	}; Bindings.CustomIcons = CustomIcons;

	Bindings.DefaultIcons = {
		---------------------------------------------------------------
		JUMP                               = CustomIcons.Jump;
		TOGGLERUN                          = CustomIcons.Run;
		OPENALLBAGS                        = CustomIcons.Bags;
		TOGGLEGAMEMENU                     = CustomIcons.Menu;
		TOGGLEWORLDMAP                     = CustomIcons.Map;
		---------------------------------------------------------------
		INTERACTTARGET                     = CustomIcons.TWNeutral;
		---------------------------------------------------------------
		TARGETNEARESTENEMY                 = CustomIcons.TWEnemy;
		TARGETPREVIOUSENEMY                = CustomIcons.TWEnemy;
		TARGETSCANENEMY                    = CustomIcons.TNEnemy;
		TARGETNEARESTFRIEND                = CustomIcons.TWFriend;
		TARGETPREVIOUSFRIEND               = CustomIcons.TWFriend;
		TARGETNEARESTENEMYPLAYER           = CustomIcons.TNEnemy;
		TARGETPREVIOUSENEMYPLAYER          = CustomIcons.TNEnemy;
		TARGETNEARESTFRIENDPLAYER          = CustomIcons.TNFriend;
		TARGETPREVIOUSFRIENDPLAYER         = CustomIcons.TNFriend;
		---------------------------------------------------------------
		TARGETPARTYMEMBER1                 = CPAPI.IsRetailVersion and client 'Achievement_PVP_A_01';
		TARGETPARTYMEMBER2                 = CPAPI.IsRetailVersion and client 'Achievement_PVP_A_02';
		TARGETPARTYMEMBER3                 = CPAPI.IsRetailVersion and client 'Achievement_PVP_A_03';
		TARGETPARTYMEMBER4                 = CPAPI.IsRetailVersion and client 'Achievement_PVP_A_04';
		TARGETSELF                         = CPAPI.IsRetailVersion and client 'Achievement_PVP_A_05';
		TARGETPET                          = client 'Spell_Hunter_AspectOfTheHawk';
		---------------------------------------------------------------
		ATTACKTARGET                       = client 'Ability_SteelMelee';
		STARTATTACK                        = client 'Ability_SteelMelee';
		PETATTACK                          = client 'ABILITY_HUNTER_INVIGERATION';
		FOCUSTARGET                        = client 'Ability_Hunter_MasterMarksman';
		---------------------------------------------------------------
		[Bindings.Custom.EasyMotion]       = CustomIcons.Group;
		[Bindings.Custom.RaidCursorToggle] = CustomIcons.Group;
		[Bindings.Custom.RaidCursorFocus]  = CustomIcons.Group;
		[Bindings.Custom.RaidCursorTarget] = CustomIcons.Group;
		[Bindings.Custom.UtilityRing]      = CustomIcons.Ring;
		[Bindings.Custom.MenuRing]         = CustomIcons.Menu;
		--[Bindings.Custom.FocusButton]    = client 'VAS_RaceChange';
		---------------------------------------------------------------
	};
end

function Bindings:OnDataLoaded()
	self.Icons = CPAPI.Proxy(ConsolePortBindingIcons or {}, self.DefaultIcons)
	db:Save('Bindings/Icons', 'ConsolePortBindingIcons')
end

function Bindings:GetIcon(bindingID)
	return self.Icons[bindingID];
end

function Bindings:SetIcon(bindingID, icon)
	self.Icons[bindingID] = icon;
	db:TriggerEvent('OnBindingIconChanged', bindingID, self.Icons[bindingID])
end

function Bindings:GetIconProvider()
	if not self.IconProvider then
		self.IconProvider = self:RefreshIconDataProvider()
	end
	return self.IconProvider;
end

function Bindings:ReleaseIconProvider()
	if self.IconProvider then
		self.IconProvider = nil;
		collectgarbage()
	end
end

---------------------------------------------------------------
do -- Icon provider (see FrameXML\IconDataProvider.lua)
---------------------------------------------------------------
	local QuestionMarkIconFileDataID = 134400;

	local function FillOutExtraIconsMapWithSpells(extraIconsMap)
		for i = 1, GetNumSpellTabs() do
			local tab, tabTex, offset, numSpells = GetSpellTabInfo(i);
			offset = offset + 1;
			local tabEnd = offset + numSpells;
			for j = offset, tabEnd - 1 do
				local spellType, ID = GetSpellBookItemInfo(j, 'player');
				if spellType ~= 'FUTURESPELL' then
					local fileID = GetSpellBookItemTexture(j, 'player');
					if fileID ~= nil then
						extraIconsMap[fileID] = true;
					end
				end

				if spellType == 'FLYOUT' then
					local _, _, numSlots, isKnown = GetFlyoutInfo(ID);
					if isKnown and (numSlots > 0) then
						for k = 1, numSlots do
							local spellID, overrideSpellID, isSlotKnown = GetFlyoutSlotInfo(ID, k)
							if isSlotKnown then
								local fileID = GetSpellTexture(spellID);
								if fileID ~= nil then
									extraIconsMap[fileID] = true;
								end
							end
						end
					end
				end
			end
		end
	end

	local function FillOutExtraIconsMapWithTalents(extraIconsMap)
		local isInspect = false;
		for specIndex = 1, GetNumSpecGroups(isInspect) do
			for tier = 1, MAX_TALENT_TIERS do
				for column = 1, NUM_TALENT_COLUMNS do
					local icon = select(3, GetTalentInfo(tier, column, specIndex));
					if icon ~= nil then
						extraIconsMap[icon] = true;
					end
				end
			end
		end

		for pvpTalentSlot = 1, 3 do
			local slotInfo = C_SpecializationInfo.GetPvpTalentSlotInfo(pvpTalentSlot);
			if slotInfo ~= nil then
				for i, pvpTalentID in ipairs(slotInfo.availableTalentIDs) do
					local icon = select(3, GetPvpTalentInfoByID(pvpTalentID));
					if icon ~= nil then
						extraIconsMap[icon] = true;
					end
				end
			end
		end
	end

	local function FillOutExtraIconsMapWithEquipment(extraIconsMap)
		for i = INVSLOT_FIRST_EQUIPPED, INVSLOT_LAST_EQUIPPED do
			local itemTexture = GetInventoryItemTexture('player', i)
			if itemTexture ~= nil then
				extraIconsMap[itemTexture] = true;
			end
		end
	end

	local function FillOutExtraIconsWithCustomIcons(extraIcons)
		for _, customTexture in db.table.spairs(Bindings.CustomIcons) do
			tinsert(extraIcons, customTexture)
		end
	end

	function Bindings:RefreshIconDataProvider()
		local extraIconsMap = {};
		pcall(FillOutExtraIconsMapWithSpells, extraIconsMap)
		pcall(FillOutExtraIconsMapWithTalents, extraIconsMap)
		pcall(FillOutExtraIconsMapWithEquipment, extraIconsMap)

		local extraIcons = GetKeysArray(extraIconsMap)
		pcall(FillOutExtraIconsWithCustomIcons, extraIcons)

		local provider = {QuestionMarkIconFileDataID, unpack(extraIcons)};
		pcall(GetLooseMacroIcons, provider)
		pcall(GetLooseMacroItemIcons, provider)
		pcall(GetMacroIcons, provider)
		pcall(GetMacroItemIcons, provider)

		local customIconsRef = tInvert(Bindings.CustomIcons)
		for i, iconID in ipairs(provider) do
			if not tonumber(iconID) and not customIconsRef[iconID] then
				provider[i] = client(iconID)
			end
		end

		return provider;
	end
end