local _, env = ...;
---------------------------------------------------------------
-- Constants
---------------------------------------------------------------
env.Const.ProxyKeyOptions = function()
	local keys = {};
	for buttonID in pairs(env.db.Gamepad.Index.Button.Binding) do
		if CPAPI.IsButtonValidForBinding(buttonID) then
			keys[buttonID] = buttonID;
		end
	end
	return keys;
end

env.Const.DefaultPresetName = ('%s (%s)'):format(GetUnitName('player'), GetRealmName());
env.Const.ManagerVisibility = '[petbattle] hide; show';
env.Const.DefaultVisibility = '[vehicleui][overridebar] hide; show';

env.Const.ValidFontFlags = CPAPI.Enum('OUTLINE', 'THICKOUTLINE', 'MONOCHROME');
env.Const.ValidJustifyH  = CPAPI.Enum('LEFT', 'CENTER', 'RIGHT');
env.Const.ValidStratas   = CPAPI.Enum('BACKGROUND', 'LOW', 'MEDIUM', 'HIGH', 'DIALOG');
env.Const.ValidPoints    = CPAPI.Enum(
	'CENTER', 'TOP',      'BOTTOM',
	'LEFT',   'TOPLEFT',  'BOTTOMLEFT',
	'RIGHT',  'TOPRIGHT', 'BOTTOMRIGHT'
);
env.Const.PageDescription =  {
	['vehicleui']   = '已啟用載具介面。';
	['possessbar']  = '已顯示控制條，例如精神控制或野獸之眼。';
	['overridebar'] = '已啟用覆蓋快捷列，可用於載具介面或沒有外觀的覆蓋快捷列。';
	['shapeshift']  = '暫時變形，但不包括那些自己有快捷列的形態或姿態。';
	['bar:1']       = '選擇頁面 1 (預設)';
	['bar:2']       = '選擇頁面 2';
	['bar:3']       = '選擇頁面 3';
	['bar:4']       = '選擇頁面 4';
	['bar:5']       = '選擇頁面 5';
	['bar:6']       = '選擇頁面 6';
	['bonusbar:1']  = '姿勢/形態 1';
	['bonusbar:2']  = '姿勢/形態 2';
	['bonusbar:3']  = '姿勢/形態 3';
	['bonusbar:4']  = '姿勢/形態 4';
	['bonusbar:5']  = '天空騎術';
};

---------------------------------------------------------------
do -- Variables
---------------------------------------------------------------
local classColor = CreateColor(CPAPI.NormalizeColor(CPAPI.GetClassColor()));
local Data, _ = env.db.Data, CPAPI.Define;

env:Register('Variables', CPAPI.Callable({
	---------------------------------------------------------------
	_'快捷列';
	---------------------------------------------------------------
	showMainIcons = _{Data.Bool(true);
		name = '顯示主要按鈕';
		desc = '顯示主要按鈕的圖示。';
	};
	showCooldownText = _{Data.Bool(GetCVarBool('countdownForCooldowns'));
		name = '顯示冷卻時間';
		desc = '顯示按鈕上的冷卻時間數字。';
	};
	disableDND = _{Data.Bool(false);
		name = '停用拖曳';
		desc = '停用拖放快捷列技能。';
	};
	---------------------------------------------------------------
	_'快捷列按鈕';
	---------------------------------------------------------------
	LABclickOnDown = _{Data.Bool(true);
		name = '按下時執行';
		desc = '按下按鈕就執行動作，而不是開放。';
	};
	LABhideElementsMacro = _{Data.Bool(false);
		name = '隱藏巨集文字';
		desc = '隱藏按鈕上的巨集文字。';
	};
	LABcolorsRange = _{Data.Color(CreateColor( 0.8, 0.1, 0.1 ));
		name = '超出範圍顏色';
		desc = '按鈕上範圍指示器的顏色。';
	};
	LABcolorsMana = _{Data.Color(CreateColor(0.5, 0.5, 1.0 ));
		name = '法力不足顏色';
		desc = '按鈕上法力指示器的顏色。';
	};
	LABtooltip = _{Data.Select('Enabled', 'Enabled', 'Disabled', 'NoCombat');
		name = '浮動提示資訊';
		desc = '滑鼠指向按鈕時顯示浮動提示資訊。';
	};
	---------------------------------------------------------------
	_'快捷列按鈕 | 快速鍵';
	---------------------------------------------------------------
	LABhotkeyColor = _{Data.Color(CreateColor( 0.75, 0.75, 0.75 ));
		name = '顏色';
		desc = '按鈕上快速鍵文字的顏色。';
	};
	LABhotkeyFontSize = _{Data.Number(12, 1);
		name = '大小';
		desc = '按鈕上快速鍵文字的大小。';
	};
	LABhotkeyPositionOffsetX = _{Data.Number(4, 1, true);
		name = '水平位置';
		desc = '調整按鈕上快速鍵文字的水平位置。';
	};
	LABhotkeyPositionOffsetY = _{Data.Number(0, 1, true);
		name = '垂直位置';
		desc = '調整按鈕上快速鍵文字的垂直位置。';
	};
	LABhotkeyJustifyH = _{Data.Select('RIGHT', env.Const.ValidJustifyH());
		name = '對齊';
		desc = '按鈕上快速鍵文字的對齊方式。';
	};
	LABhotkeyFontFlags = _{Data.Select('OUTLINE', env.Const.ValidFontFlags());
		name = '外框';
		desc = '按鈕上快速鍵文字的外框。';
	};
	LABhotkeyPositionAnchor = _{Data.Select('TOPRIGHT', env.Const.ValidPoints());
		name = '對齊點';
		desc = '按鈕上快速鍵文字的對齊點。';
	};
	LABhotkeyPositionRelAnchor = _{Data.Select('TOPRIGHT', env.Const.ValidPoints());
		name = '相對對齊點';
		desc = '按鈕上快速鍵文字的相對對齊點。';
	};
	---------------------------------------------------------------
	_'快捷列按鈕 | 巨集文字';
	---------------------------------------------------------------
	LABmacroColor = _{Data.Color(WHITE_FONT_COLOR);
		name = '顏色';
		desc = '按鈕上巨集文字的顏色。';
		deps = { LABhideElementsMacro = false };
	};
	LABmacroFontSize = _{Data.Number(10, 1);
		name = '大小';
		desc = '按鈕上巨集文字的大小。';
		deps = { LABhideElementsMacro = false };
	};
	LABmacroPositionOffsetX = _{Data.Number(0, 1, true);
		name = '水平位置';
		desc = '調整按鈕上巨集文字的水平位置。';
		deps = { LABhideElementsMacro = false };
	};
	LABmacroPositionOffsetY = _{Data.Number(2, 1, true);
		name = '垂直位置';
		desc = '調整按鈕上巨集文字的垂直位置。';
		deps = { LABhideElementsMacro = false };
	};
	LABmacroJustifyH = _{Data.Select('CENTER', env.Const.ValidJustifyH());
		name = '對齊';
		desc = '按鈕上巨集文字的對齊方式。';
		deps = { LABhideElementsMacro = false };
	};
	LABmacroFontFlags = _{Data.Select('OUTLINE', env.Const.ValidFontFlags());
		name = '外框';
		desc = '按鈕上巨集文字的外框。';
		deps = { LABhideElementsMacro = false };
	};
	LABmacroPositionAnchor = _{Data.Select('BOTTOM', env.Const.ValidPoints());
		name = '對齊點';
		desc = '按鈕上巨集文字的對齊點。';
		deps = { LABhideElementsMacro = false };
	};
	LABmacroPositionRelAnchor = _{Data.Select('BOTTOM', env.Const.ValidPoints());
		name = '相對對齊點';
		desc = '按鈕上巨集文字的相對對齊點。';
		deps = { LABhideElementsMacro = false };
	};
	---------------------------------------------------------------
	_'快捷列按鈕 | 充能';
	---------------------------------------------------------------
	LABcountColor = _{Data.Color(WHITE_FONT_COLOR);
		name = '顏色';
		desc = '按鈕上次數文字的顏色。';
	};
	LABcountFontSize = _{Data.Number(16, 1);
		name = '大小';
		desc = '按鈕上次數文字的大小。';
	};
	LABcountPositionOffsetX = _{Data.Number(-2, 1, true);
		name = '水平位置';
		desc = '調整按鈕上次數文字的水平位置。';
	};
	LABcountPositionOffsetY = _{Data.Number(4, 1, true);
		name = '垂直位置';
		desc = '調整按鈕上次數文字的垂直位置。';
	};
	LABcountJustifyH = _{Data.Select('RIGHT', env.Const.ValidJustifyH());
		name = '對齊';
		desc = '按鈕上次數文字的對齊方式。';
	};
	LABcountFontFlags = _{Data.Select('OUTLINE', env.Const.ValidFontFlags());
		name = '外框';
		desc = '按鈕上次數文字的外框。';
	};
	LABcountPositionAnchor = _{Data.Select('BOTTOMRIGHT', env.Const.ValidPoints());
		name = '對齊點';
		desc = '按鈕上次數文字的對齊點。';
	};
	LABcountPositionRelAnchor = _{Data.Select('BOTTOMRIGHT', env.Const.ValidPoints());
		name = '相對對齊點';
		desc = '按鈕上次數文字的相對對齊點。';
	};
	---------------------------------------------------------------
	_'群組';
	---------------------------------------------------------------
	groupHotkeySize = _{Data.Number(20, 1);
		name = '快速鍵大小';
		desc = '群組按鈕上快速鍵圖示的大小。';
	};
	groupHotkeyOffsetX = _{Data.Number(0, 1, true);
		name = '快速鍵水平位置';
		desc = '調整群組按鈕上快速鍵圖示的水平位置。';
	};
	groupHotkeyOffsetY = _{Data.Number(-2, 1, true);
		name = '快速鍵垂直位置';
		desc = '調整群組按鈕上快速鍵圖示的垂直位置。';
	};
	groupHotkeyAnchor = _{Data.Select('CENTER', env.Const.ValidPoints());
		name = '快速鍵對齊點';
		desc = '群組按鈕上快速鍵圖示的對齊點。';
	};
	groupHotkeyRelAnchor = _{Data.Select('TOP', env.Const.ValidPoints());
		name = '快速鍵對齊點';
		desc = '群組按鈕上快速鍵圖示的相對對齊點。';
	};
	---------------------------------------------------------------
	_'群集';
	---------------------------------------------------------------
	clusterShowAll = _{Data.Bool(false);
		name = '總是顯示所有按鈕';
		desc = '總是顯示群集中所有啟用的按鈕組合。';
		note = '預設會在滑鼠指向和冷卻中顯示輔助按鈕。';
	};
	clusterShowFlyoutIcons = _{Data.Bool(true);
		name = '顯示輔助按鈕圖示';
		desc = '顯示輔助按鈕的圖示。';
	};
	clusterFullStateModifier = _{Data.Bool(false);
		name = '完整的輔助按鈕狀態';
		desc = '啟用群集的所有輔助按鈕狀態，包括未對應的輔助按鈕。';
	};
	swipeColor = _{Data.Color(classColor);
		name = '轉圈動畫顏色';
		desc = '按鈕上冷卻中的轉圈動畫效果顏色。';
	};
	borderColor = _{Data.Color(WHITE_FONT_COLOR);
		name = '邊框顏色';
		desc = '按鈕邊框的顏色。';
	};
	clusterBorderStyle = _{Data.Select('Normal', 'Normal', 'Large', 'Beveled');
		name = '主要按鈕邊框樣式';
		desc = '主要按鈕周圍邊框的樣式。';
	};
	---------------------------------------------------------------
	_'工具列';
	---------------------------------------------------------------
	enableXPBar = _{Data.Bool(true);
		name = '啟用監控列';
		desc = '在工具列底部顯示監控列。';
		note = '監控列包括經驗值、聲望、榮譽、神器點數和艾澤萊。';
	};
	fadeXPBar = _{Data.Bool(false);
		name = '淡出監控列';
		desc = '滑鼠沒有指向工具列時淡出監控列。';
		deps = { enableXPBar = true };
	};
	xpBarColor = _{Data.Color(classColor);
		name = '經驗條顏色';
		desc = '主要經驗條的顏色。';
		deps = { enableXPBar = true };
	};
	---------------------------------------------------------------
	_(GENERAL);
	---------------------------------------------------------------
	tintColor = _{Data.Color(classColor);
		name = '色調顏色';
		desc = '某些元素的色調效果顏色。';
	};
}, function(self, key) return (rawget(self, key) or {})[1] end))
---------------------------------------------------------------
end -- Variables

---------------------------------------------------------------
do -- Cluster information
---------------------------------------------------------------
local M1, M2, M3 = 'M1', 'M2', 'M3';
---------------------------------------------------------------
local NOMOD,  SHIFT,    CTRL,    ALT =
      '',    'SHIFT-', 'CTRL-', 'ALT-';
---------------------------------------------------------------
local SIZE_L,  SIZE_S,  SIZE_T  = 64, 46, 58;
local OFS_MOD, OFS_MID, OFS_FIX = 38, 21, 4;
-----------------------------------------------------------------------------------------------------------------------
local HK_ICONS_SIZE_L, HK_ICONS_SIZE_S = 32, 20;
local HK_ATLAS_SIZE_L, HK_ATLAS_SIZE_S = 18, 12;
-----------------------------------------------------------------------------------------------------------------------
env.Const.Cluster = {
	Directions = CPAPI.Enum('UP', 'DOWN', 'LEFT', 'RIGHT');
	Types      = CPAPI.Enum('Cluster', 'ClusterHandle', 'ClusterButton', 'ClusterShadow');
	ModNames   = CPAPI.Enum(NOMOD, SHIFT, CTRL, CTRL..SHIFT, ALT, ALT..SHIFT, ALT..CTRL, ALT..CTRL..SHIFT);
	SnapPixels = 4;
	PxSize     = SIZE_L;
	Layout = {
		[NOMOD]      = { ----------------------------------------------------------------------------------------------------------
			Prefix   = nil;
			Shadow   = { 82 / SIZE_L, 0.3, CPAPI.GetAsset([[Textures\Button\Shadow]]), {'CENTER', 0, -6} };
			Level    = 4;
			Hotkey   = {{ HK_ICONS_SIZE_L, HK_ATLAS_SIZE_L, {'TOP', 0, 12}, nil }};
			Coords   = {0, 1, 0, 1};
			-----------------------------------------------------------------------------------------------------------------------
		};
		[SHIFT]      = { ----------------------------------------------------------------------------------------------------------
			DOWN     = {'TOPRIGHT', 'BOTTOMLEFT',  OFS_MOD - OFS_FIX,  OFS_MOD + OFS_FIX, Coords = {0, 0,   1, 0,   0, 1,   1, 1}};
			UP       = {'BOTTOMRIGHT', 'TOPLEFT',  OFS_MOD - OFS_FIX, -OFS_MOD - OFS_FIX, Coords = {1, 0,   0, 0,   1, 1,   0, 1}};
			LEFT     = {'BOTTOMRIGHT', 'TOPLEFT',  OFS_MOD + OFS_FIX, -OFS_MOD + OFS_FIX, Coords = {1, 0,   1, 1,   0, 0,   0, 1}};
			RIGHT    = {'BOTTOMLEFT', 'TOPRIGHT', -OFS_MOD - OFS_FIX, -OFS_MOD + OFS_FIX, Coords = {0, 0,   0, 1,   1, 0,   1, 1}};
			-----------------------------------------------------------------------------------------------------------------------
			Prefix   = M1;
			Size     = SIZE_S / SIZE_L;
			TexSize  = SIZE_T / SIZE_S;
			Offset   = OFS_MOD / SIZE_L;
			Hotkey   = {{ HK_ICONS_SIZE_S, HK_ATLAS_SIZE_S, {'CENTER', 0, 0}, M1 }};
			-----------------------------------------------------------------------------------------------------------------------
		};
		[CTRL]       = { ----------------------------------------------------------------------------------------------------------
			DOWN     = {'TOPLEFT', 'BOTTOMRIGHT', -OFS_MOD + OFS_FIX,  OFS_MOD + OFS_FIX, Coords = {0, 1,   1, 1,   0, 0,   1, 0}};
			UP       = {'BOTTOMLEFT', 'TOPRIGHT', -OFS_MOD + OFS_FIX, -OFS_MOD - OFS_FIX, Coords = {1, 1,   0, 1,   1, 0,   0, 0}};
			LEFT     = {'TOPRIGHT', 'BOTTOMLEFT',  OFS_MOD + OFS_FIX,  OFS_MOD - OFS_FIX, Coords = {1, 1,   1, 0,   0, 1,   0, 0}};
			RIGHT    = {'TOPLEFT', 'BOTTOMRIGHT', -OFS_MOD - OFS_FIX,  OFS_MOD - OFS_FIX, Coords = {0, 1,   0, 0,   1, 1,   1, 0}};
			-----------------------------------------------------------------------------------------------------------------------
			Prefix   = M2;
			Size     = SIZE_S / SIZE_L;
			TexSize  = SIZE_T / SIZE_S;
			Offset   = OFS_MOD / SIZE_L;
			Hotkey   = {{ HK_ICONS_SIZE_S, HK_ATLAS_SIZE_S, {'CENTER', 0, 0}, M2 }};
			-----------------------------------------------------------------------------------------------------------------------
		};
		[CTRL..SHIFT] = { ----------------------------------------------------------------------------------------------------------
			DOWN     = {'TOP',          'BOTTOM',                  0,            OFS_MID, Coords = {0, 1,   1, 1,   0, 0,   1, 0}};
			UP       = {'BOTTOM',          'TOP',                  0,           -OFS_MID, Coords = {1, 1,   0, 1,   1, 0,   0, 0}};
			LEFT     = {'RIGHT',          'LEFT',            OFS_MID,                  0, Coords = {1, 0,   1, 1,   0, 0,   0, 1}};
			RIGHT    = {'LEFT',          'RIGHT',           -OFS_MID,                  0, Coords = {0, 0,   0, 1,   1, 0,   1, 1}};
			-----------------------------------------------------------------------------------------------------------------------
			Prefix   = M3;
			Size     = SIZE_S / SIZE_L;
			TexSize  = SIZE_T / SIZE_S * 0.9;
			Offset   = OFS_MID / SIZE_L;
			Hotkey   = {{ HK_ICONS_SIZE_S, HK_ATLAS_SIZE_S, {'CENTER', -4, 0}, M1 },
						{ HK_ICONS_SIZE_S, HK_ATLAS_SIZE_S, {'CENTER',  4, 0}, M2 }};
			-----------------------------------------------------------------------------------------------------------------------
		};
	};
	AdjustTextures = {
		[NOMOD] = {
			Border                =   env.GetAsset([[Textures\Button\Hilite]]);
			CheckedTexture        =   env.GetAsset([[Textures\Button\Hilite]]);
			Flash                 =   env.GetAsset([[Textures\Button\Hilite2x]]);
			NewActionTexture      =   env.GetAsset([[Textures\Button\Hilite]]);
			SpellHighlightTexture =   env.GetAsset([[Textures\Button\Hilite2x.png]]);
		};
		[SHIFT] = {
			Border                =   env.GetAsset([[Textures\Button\M1]]);
			NormalTexture         =   env.GetAsset([[Textures\Button\M1]]);
			PushedTexture         =   env.GetAsset([[Textures\Button\M1]]);
			HighlightTexture      =   env.GetAsset([[Textures\Button\M1Hilite]]);
			CheckedTexture        =   env.GetAsset([[Textures\Button\M1Hilite]]);
			NewActionTexture      =   env.GetAsset([[Textures\Button\M1Hilite]]);
			SpellHighlightTexture =   env.GetAsset([[Textures\Button\M1Hilite]]);
		};
		[CTRL] = {
			Border                =   env.GetAsset([[Textures\Button\M1]]);
			NormalTexture         =   env.GetAsset([[Textures\Button\M1]]);
			PushedTexture         =   env.GetAsset([[Textures\Button\M1]]);
			HighlightTexture      =   env.GetAsset([[Textures\Button\M1Hilite]]);
			CheckedTexture        =   env.GetAsset([[Textures\Button\M1Hilite]]);
			NewActionTexture      =   env.GetAsset([[Textures\Button\M1Hilite]]);
			SpellHighlightTexture =   env.GetAsset([[Textures\Button\M1Hilite]]);
		};
		[CTRL..SHIFT] = {
			Border                =   env.GetAsset([[Textures\Button\M3]]);
			NormalTexture         =   env.GetAsset([[Textures\Button\M3]]);
			PushedTexture         =   env.GetAsset([[Textures\Button\M3]]);
			HighlightTexture      =   env.GetAsset([[Textures\Button\M3Hilite]]);
			CheckedTexture        =   env.GetAsset([[Textures\Button\M3Hilite]]);
			NewActionTexture      =   env.GetAsset([[Textures\Button\M3Hilite]]);
			SpellHighlightTexture =   env.GetAsset([[Textures\Button\M3Hilite]]);
		};
	};
	Assets = {
		CooldownBling             =   env.GetAsset([[Textures\Cooldown\Bling]]);
		CooldownEdge              =   env.GetAsset([[Textures\Cooldown\Edge2x3.png]]);
		MainMask                  = CPAPI.GetAsset([[Textures\Button\Mask]]);
		MainSwipe                 =   env.GetAsset([[Textures\Cooldown\Swipe]]);
		EmptyIcon                 = CPAPI.GetAsset([[Textures\Button\EmptyIcon]]);
	};
	BorderStyle = {
		Normal = {
			NormalTexture         =   env.GetAsset([[Textures\Button\Normal]]);
			PushedTexture         =   env.GetAsset([[Textures\Button\Hilite]]);
			HighlightTexture      =   env.GetAsset([[Textures\Button\Hilite]]);
		};
		Large = {
			NormalTexture         =   env.GetAsset([[Textures\Button\Normal2x.png]]);
			PushedTexture         =   env.GetAsset([[Textures\Button\Normal2x.png]]);
			HighlightTexture      =   env.GetAsset([[Textures\Button\Hilite2x.png]]);
		};
		Beveled = {
			NormalTexture         = CPAPI.GetAsset([[Textures\Button\Normal]]);
			PushedTexture         = CPAPI.GetAsset([[Textures\Button\Hilite]]);
			HighlightTexture      =   env.GetAsset([[Textures\Button\Hilite]]);
		};
	};
	LABConfig = {
		clickOnDown     = true;
		flyoutDirection = 'RIGHT';
		showGrid        = true;
		tooltip         = 'enabled';
		colors = {
			mana =  { 0.5, 0.5, 1.0 };
			range = { 0.8, 0.1, 0.1 };
		};
		hideElements = {
			equipped = false;
			hotkey   = true;
			macro    = false;
		};
	};
};

env.Const.Cluster.Masks, env.Const.Cluster.Swipes = (function(layout, directions)
	-- Generated masks and swipes for each prefix, e.g.:
	-- env.Const.Cluster.Masks.M1.UP = 'MASKS\M1_UP'
	local masks, swipes = {}, {};
	for _, data in pairs(layout) do
		local prefix = data.Prefix;
		if prefix then
			masks[prefix], swipes[prefix] = {}, {};
			for direction in pairs(directions) do
				masks  [prefix][direction] = env.GetAsset([[Textures\Masks\%s_%s]], prefix, direction)
				swipes [prefix][direction] = env.GetAsset([[Textures\Swipes\%s_%s]], prefix, direction)
			end
		end
	end
	return masks, swipes;
end)( env.Const.Cluster.Layout, env.Const.Cluster.Directions )

env.Const.Cluster.ModDriver = (function(driver, ...)
	for _, modifier in ipairs({...}) do
		-- Insert in reverse order to prioritize most complex modifiers
		tinsert(driver, 1, ('[mod:%s] %s'):format(modifier, modifier))
	end
	driver[#driver] = '[nomod]'; -- NOMOD fix
	return table.concat(driver, '; ')..' ;';
end)( {}, env.Const.Cluster.ModNames() )

end -- Cluster information

---------------------------------------------------------------
do -- Artwork
---------------------------------------------------------------
env.Const.Art = {
	Collage = { -- classFile = fileID, texCoordOffset
		WARRIOR     = {1, 1};
		PALADIN     = {1, 2};
		DRUID       = {1, 3};
		DEATHKNIGHT = {1, 4};
		----------------------------
		MAGE        = {2, 1};
		EVOKER      = {2, 1};
		HUNTER      = {2, 2};
		ROGUE       = {2, 3};
		WARLOCK     = {2, 4};
		----------------------------
		SHAMAN      = {3, 1};
		PRIEST      = {3, 2};
		DEMONHUNTER = {3, 3};
		MONK        = {3, 4};
		----------------------------
		[258]       = {3, 2};
	};
	Artifact = { -- classFile = atlas, yOffset
		DEATHKNIGHT = {'DeathKnightFrost', -20};
		DEMONHUNTER = {'DemonHunter',      -20};
		DRUID       = {'Druid',            -50};
		EVOKER      = {'MageArcane',       -30};
		HUNTER      = {'Hunter',             0};
		MAGE        = {'MageArcane',       -30};
		MONK        = {'Monk',             -30};
		PALADIN     = {'Paladin',            0};
		PRIEST      = {'Priest',           -20};
		ROGUE       = {'Rogue',              0};
		SHAMAN      = {'Shaman',           -20};
		WARLOCK     = {'Warlock',          -10};
		WARRIOR     = {'Warrior',           10};
		----------------------------
		[258]       = {'PriestShadow',     -20};
	};
};

env.Const.Art.CollageAsset = env.GetAsset([[Covers\%s]]);
env.Const.Art.ArtifactLine = 'Artifacts-%s-Header';
env.Const.Art.ArtifactRune = 'Artifacts-%s-BG-rune';

env.Const.Art.Types     = CPAPI.Enum('Collage', 'Artifact');
env.Const.Art.Blend     = CPAPI.Enum('ADD', 'BLEND');
env.Const.Art.Selection = {};
env.Const.Art.Flavors   = {};

local localeClassNames = {};
for i = 1, 20 do
	local class, classFile = GetClassInfo(i);
	if classFile then
		localeClassNames[classFile] = class;
	end
end
local function GetLocaleName(classFile)
	if (tonumber(classFile)) then
		return select(2, CPAPI.GetSpecializationInfoByID(tonumber(classFile)))
	end
	return localeClassNames[classFile];
end
for class in env.db.table.spairs(env.Const.Art.Collage) do
	local flavorID = GetLocaleName(class);
	if flavorID then
		tinsert(env.Const.Art.Selection, flavorID);
		env.Const.Art.Flavors[flavorID] = class;
	end
end

end -- Artwork