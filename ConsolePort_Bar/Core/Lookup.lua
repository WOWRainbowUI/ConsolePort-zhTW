local name, env = ...;
--------------------------------------------------------
env.db   = ConsolePort:GetData()
env.bar  = ConsolePortBar;
env.libs = { acb = LibStub('CPActionButton') };
--------------------------------------------------------
local r, g, b = CPAPI.NormalizeColor(CPAPI.GetClassColor())
--------------------------------------------------------
local classArt = {
	WARRIOR 	= {1, 1},
	PALADIN 	= {1, 2},
	DRUID 		= {1, 3},
	DEATHKNIGHT = {1, 4},
	----------------------------
	MAGE 		= {2, 1},
	HUNTER 		= {2, 2},
	ROGUE 		= {2, 3},
	WARLOCK 	= {2, 4},
	----------------------------
	SHAMAN 		= {3, 1},
	PRIEST 		= {3, 2},
	DEMONHUNTER = {3, 3},
	MONK 		= {3, 4},
}
--------------------------------------------------------

function env:GetBindingIcon(binding)
	return env.db.Bindings.Icons[binding]
end

function env:GetCover(class)
	local art = class and classArt[class]
	if not class and not art then
		art = classArt[select(2, UnitClass('player'))]
	end
	if art then
		local index, px = unpack(art)
		return [[Interface\AddOns\]]..name..[[\Textures\Covers\]]..index, 
				{0, 1, (( px - 1 ) * 256 ) / 1024, ( px * 256 ) / 1024 }
	end
end

function env:GetBackdrop()
	return {
		edgeFile 	= 'Interface\\AddOns\\'..name..'\\Textures\\BarEdge',
		edgeSize 	= 32,
		insets 		= {left = 16, right = 16,	top = 16, bottom = 16}
	}
end

function env:GetDefaultButtonLayout(button)
	local layout = {
		---------
		PADDLEFT 	= {point = {'LEFT', 176, 56}, dir = 'left', size = 64},
		PADDRIGHT 	= {point = {'LEFT', 306, 56}, dir = 'right', size = 64},
		PADDUP 	    = {point = {'LEFT', 240, 100}, dir = 'up', size = 64},
		PADDDOWN 	= {point = {'LEFT', 240, 16}, dir = 'down', size = 64},
		---------
		PAD3 		= {point = {'RIGHT', -306, 56}, dir = 'left', size = 64},
		PAD2 		= {point = {'RIGHT', -176, 56}, dir = 'right', size = 64},
		PAD4 		= {point = {'RIGHT', -240, 100}, dir = 'up', size = 64},
		PAD1 		= {point = {'RIGHT', -240, 16}, dir = 'down', size = 64},
	}

	local handle = env.db.UIHandle;
	local T1, T2 = handle:GetUIControlBinding('T1'), handle:GetUIControlBinding('T2')
	local M1, M2 = handle:GetUIControlBinding('M1'), handle:GetUIControlBinding('M2')

	if M1 then layout[M1] = {point = {'LEFT', 456, 56}, dir = 'right', size = 64} end;
	if M2 then layout[M2] = {point = {'RIGHT', -456, 56}, dir = 'left', size = 64} end;
	if T1 then layout[T1] = {point = {'LEFT', 396, 16}, dir = 'down', size = 64} end;
	if T2 then layout[T2] = {point = {'RIGHT', -396, 16}, dir = 'down', size = 64} end;

	if button ~= nil then
		return layout[button]
	else
		return layout
	end
end

function env:GetOrthodoxButtonLayout()
	local layout = {
		---------
		PADDRIGHT = {dir = 'right', point = {'LEFT', 330, 9}, size = 64},
		PADDLEFT = {dir = 'left', point = {'LEFT', 80, 9}, size = 64},
		PADDDOWN = {dir = 'down', point = {'LEFT', 165, 9}, size = 64},
		PADDUP = {dir = 'up', point = {'LEFT', 250, 9}, size = 64},
		---------
		PAD2 = {dir = 'right', point = {'RIGHT', -80, 9}, size = 64},
		PAD3 = {dir = 'left', point = {'RIGHT', -330, 9}, size = 64},
		PAD1 = {dir = 'down', point = {'RIGHT', -250, 9}, size = 64},
		PAD4 = {dir = 'up', point = {'RIGHT', -165, 9}, size = 64},
	}

	local handle = env.db.UIHandle;
	local T1, T2 = handle:GetUIControlBinding('T1'), handle:GetUIControlBinding('T2')
	local M1, M2 = handle:GetUIControlBinding('M1'), handle:GetUIControlBinding('M2')

	if M1 then layout[M1] = {dir = 'up', point = {'LEFT', 405, 75}, size = 64} end;
	if M2 then layout[M2] = {dir = 'up', point = {'RIGHT', -405, 75}, size = 64} end;
	if T1 then layout[T1] = {dir = 'right', point = {'LEFT', 440, 9}, size = 64} end;
	if T2 then layout[T2] = {dir = 'left', point = {'RIGHT', -440, 9}, size = 64} end;

	return layout;
end

function env:GetPresets()
	return {
		Default = self:GetDefaultSettings(),
		Orthodox = {
			scale = 0.9,
			width = 1100,
			watchbars = true,
			showline = true,
			showbuttons = false,
			lock = true,
			layout = self:GetOrthodoxButtonLayout(),
		},
		Roleplay = {
			scale = 0.9,
			width = 1100,
			watchbars = true,
			showline = true,
			showart = true,
			showbuttons = false,
			lock = true,
			layout = self:GetDefaultButtonLayout(),
		},
	}
end

function env:GetUserPresets()
	local presets, copy = {}, env.db.table.copy;
	for character, data in env.db:For('Shared/Data') do
		if data.Bar and data.Bar.layout then
			presets[character] = copy(data.Bar)
		end
	end
	return presets;
end

function env:GetAllPresets()
	return env.db.table.merge(self:GetPresets(), self:GetUserPresets())
end

function env:GetRGBColorFor(element, default)
	local cfg = env.cfg or {}
	local defaultColors = {
		art 	= {1, 1, 1, 1},
		tint 	= {r, g, b, 1},
		border 	= {1, 1, 1, 1},
		swipe 	= {r, g, b, 1},
		exp 	= {r, g, b, 1},
	}
	if default then
		if defaultColors[element] then
			return unpack(defaultColors[element])
		end
	end
	local current = {
		art 	= cfg.artRGB or defaultColors.art,
		tint 	= cfg.tintRGB or defaultColors.tint,
		border 	= cfg.borderRGB or defaultColors.border,
		swipe 	= cfg.swipeRGB or defaultColors.swipe,
		exp 	= cfg.expRGB or defaultColors.exp,
	}
	if current[element] then
		return unpack(current[element])
	end
end

function env:GetDefaultSettings()
	return 	{
		scale = 0.9,
		width = 1100,
		watchbars = true,
		showline = true,
		lock = true,
		flashart = true,
		eye = true,
		showbuttons = false,
		layout = env:GetDefaultButtonLayout()
	}
end

function env:GetColorGradient(red, green, blue)
	local gBase = 0.15
	local gMulti = 1.2
	local startAlpha = 0.25
	local endAlpha = 0
	local gradient = {
		'VERTICAL',
		(red + gBase) * gMulti, (green + gBase) * gMulti, (blue + gBase) * gMulti, startAlpha,
		1 - (red + gBase) * gMulti, 1 - (green + gBase) * gMulti, 1 - (blue + gBase) * gMulti, endAlpha,
	}
	return unpack(gradient)
end

function env:GetBooleanSettings() return {
	{	name = '寬度/使用滑鼠滾輪縮放';
		cvar = 'mousewheel';
		desc = '在快捷列上面滾動滑鼠滾輪來調整縮放比例。';
		note = '按住 Shift 鍵來調整寬度，否則會整體縮放。';
	};
	---------------------------------------
	{	name = '顯示 & 鎖定' };
	{	name = '鎖定快捷列';
		cvar = 'lock';
		desc = '鎖定/解鎖快捷列，允許使用滑鼠拖曳來移動位置。';
	};
	{	name = '戰鬥中隱藏';
		cvar = 'combathide';
		desc = '戰鬥中隱藏快捷列。';
		note = '真的瘋了才會使用。';
	};
	{	name = '非戰鬥中淡出';
		cvar = 'hidebar';
		desc = '不在戰鬥中時淡出快捷列。';
		note = '滑鼠指向快捷列時就會顯示出來。';
	};
	{	name = '停用滑鼠拖曳';
		cvar = 'disablednd';
		desc = '停止使用滑鼠游標拖放的動作。';
	};
	{	name = '總是顯示所有按鈕';
		cvar = 'showbuttons';
		desc = '任何時候都會顯示整個按鈕群組，而不是只有技能冷卻中。';
	};
	---------------------------------------
	{	name = '寵物環' };
	{	name = '鎖定寵物環';
		cvar = 'lockpet';
		desc = '鎖定/解鎖寵物環，允許使用滑鼠拖曳來移動位置。';
	};
	{	name = '停用寵物環';
		cvar = 'hidepet';
		desc = '完全停用寵物環。';
	};
	{	name = '戰鬥中隱藏寵物環';
		cvar = 'combatpethide';
		desc = '戰鬥中隱藏寵物環。';
	};
	{	name = '總是顯示所有按鈕';
		cvar = 'disablepetfade';
		desc = '任何時候都會顯示整個寵物環群組，而不是只有技能冷卻中。';
	};
	---------------------------------------
	{	name = '顯示' };
	{	name = '眼睛圖示';
		cvar = 'eye';
		desc = '在快捷列正中間顯示 "眼睛"，方便快速切換顯示/隱藏所有按鈕。';
		note = '眼睛圖示可以用來訓練你的遊戲能力。';
	};
	{	name = '停用經驗條';
		cvar = 'hidewatchbars';
		desc = '停用快捷列底部的經驗條。';
		note = '經驗值、榮譽、聲望和神兵之力全部停止追蹤。';
	};
	{	name = '總是顯示經驗條';
		cvar = 'watchbars';
		desc = '啟用時，會保持顯示經驗條。停用時，只有滑鼠指向時會顯示。';
	};
	{	name = '隱藏主要按鈕文字';
		cvar = 'hideIcons';
		desc = '隱藏所有大型按鈕上面的按鍵提示。';
	};
	{	name = '隱藏輔助按鈕文字';
		cvar = 'hideModifiers';
		desc = '隱藏所有小型按鈕上面的按鍵提示。';
	};
	{	name = '使用立體邊框';
		cvar = 'classicBorders';
		desc = '使用經典按鈕的邊框材質。';
	};
	{ 	name = '不要調整微型選單';
		cvar = 'disablemicromenu';
		desc = '停止對微型選單做任何調整。';
		note = '如果你有使用其他插件來調整微型選單的話，請啟用此選項。';
	};
	---------------------------------------
	{	name = '施法條' };
	{	name = '顯示預設施法條';
		cvar = 'defaultCastBar';
		desc = '顯示預設的施法條，對齊到快捷列位置。';
	};
	{	name = '不要調整施法條';
		cvar = 'disableCastBarHook';
		desc = '停止對施法條做任何調整，包含位置。';
		note = '可以修正與其他施法條插件的相容性問題。';
	};
	---------------------------------------
	{	name = '美術' };
	{	name = '顯示職業美術底圖';
		cvar = 'showart';
		desc = '在按鈕群組下方顯示以職業為主的美術圖案，並且作為對齊位置的參考。';
	};
	{	name = '半透明職業美術底圖';
		cvar = 'blendart';
		desc = '將美術底圖與背景顏色融合在一起，變成較亮、較透明的材質。';
	};
	{	name = '技能特效觸發時閃爍美術底圖';
		cvar = 'flashart';
		desc = '只要觸發了技能特效便會閃爍美術底圖、開始發光。';
	};
	{	name = '小型美術底圖';
		cvar = 'smallart';
		desc = '縮小美術底圖的大小。';
	};
	{	name = '顯示光影效果';
		cvar = 'showline';
		desc = '在經驗條上方顯示淡淡的打光效果。';
	};
	{	name = '電競之神 RBG';
		cvar = 'rainbow';
		desc = '你這個搖桿控，竟敢挑戰我 PC 的威力，那個東西真的有足夠的按鈕跟我對決嗎?';
		note = ('|T%s:64:128:0|t'):format([[Interface\AddOns\ConsolePort_Config\Assets\master.blp]]);
	};
} end

function env:GetNumberSettings() return {
	---------------------------------------
	{	name = '大小' };
	{	name = '寬度';
		cvar = 'width';
		desc = '更改整個快捷列的寬度。';
		note = '會影響按鈕擺放的位置。';
		step = 10;
	};
	{	name = '縮放大小';
		cvar = 'scale';
		desc = '更改整個快捷列的縮放大小。';
		note = '會影響按鈕大小 - 個別大小乘以縮放大小。';
		step = 0.05;
	};
} end

function env:GetColorSettings() return {
	---------------------------------------
	{	name = '顏色' };
	{	name = '邊框';
		cvar = 'borderRGB';
		desc = '更改按鈕的邊框顏色。';
		note = '點一下右鍵重置為預設顏色。';
	};
	{	name = '冷卻';
		cvar = 'swipeRGB';
		desc = '更改冷卻圖案的顏色。';
		note = '點一下右鍵重置為職業顏色。';
	};
	{	name = '光影';
		cvar = 'tintRGB';
		desc = '更改經驗條上方光影效果的顏色。';
		note = '點一下右鍵重置為職業顏色。';
	};
	{	name = '經驗條';
		cvar = 'expRGB';
		desc = '更改經驗條的顏色。';
		note = '點一下右鍵重置為職業顏色。';
	};
	{	name = '美術';
		cvar = 'artRGB';
		desc = '更改以職業為主的背景美術圖案顏色。';
		note = '點一下右鍵重置為預設顏色。';
	};
} end

function env:SetRainbowScript(on)
	if on then
		local t, i, p, c, w, m = 0, 0, 0, 128, 127, 180
		local hz = (math.pi*2) / m;
		local r, g, b;
		return self.bar:SetScript('OnUpdate', function(_, e)
			t = t + e;
			if t > 0.1 then
				i = i + 1;
				r = (math.sin((hz * i) + 0 + p) * w + c) / 255;
				g = (math.sin((hz * i) + 2 + p) * w + c) / 255;
				b = (math.sin((hz * i) + 4 + p) * w + c) / 255;
				if i > m then
					i = i - m;
				end
				t = 0;
				self:SetTintColor(r, g, b, 1)
			end
		end)
	end
	self.bar:SetScript('OnUpdate', nil)
end

function env:SetTintColor(r, g, b, a) a = a or 1;
	local color = CreateColor(r, g, b, a)
	local bar, castBar = env.bar, CastingBarFrame;
	local buttons = env.libs.registry;
	if castBar then
		castBar:SetStatusBarColor(r, g, b)
	end
	bar.WatchBarContainer:SetMainBarColor(r, g, b)
	CPAPI.SetGradient(bar.BG, self:GetColorGradient(r, g, b))
	bar.BottomLine:SetVertexColor(r, g, b, a)
	for _, button in pairs(buttons) do
		button:SetSwipeColor(r, g, b, a)
	end
	if C_GamePad.SetLedColor then
		C_GamePad.SetLedColor(color)
	end
end

function env:SetArtUnderlay(enabled, flashOnProc)
	local bar = env.bar
	local cfg = env.cfg
	if enabled then
		local art, coords = self:GetCover()
		if art and coords then
			local artScale = cfg.smallart and .75 or 1
			bar.CoverArt:SetTexture(art)
			bar.CoverArt:SetTexCoord(unpack(coords))
			bar.CoverArt:SetVertexColor(unpack(cfg.artRGB or {1,1,1}))
			bar.CoverArt:SetBlendMode(cfg.blendart and 'ADD' or 'BLEND')
			bar.CoverArt:SetSize(768 * artScale, 192 * artScale)
			if cfg.showart then
				bar.CoverArt:Show()
			else
				bar.CoverArt:Hide()
			end
		end
	else
		bar.CoverArt:SetTexture(nil)
		bar.CoverArt:Hide()
	end
	bar.CoverArt.flashOnProc = flashOnProc
end