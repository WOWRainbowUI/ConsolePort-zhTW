local db, Data, _, env = ConsolePort:DB(), ConsolePort:DB('Data'), ...; _, env.db = CPAPI.Define, db;
local MODID_SELECT = {'SHIFT', 'CTRL', 'ALT'};
local DEPENDENCY = { UIenableCursor = true };

---------------------------------------------------------------
-- Add variables to config
---------------------------------------------------------------
ConsolePort:AddVariables({
	_('介面游標', 2);
	UIpointerAnimation = _{Data.Bool(true);
		name = '啟用動畫效果';
		desc = '指標箭頭會沿行進方向旋轉。';
		deps = DEPENDENCY;
		advd = true;
	};
	UIpointerSound = _{Data.Bool(true);
		name = '啟用音效';
		desc = '指標箭頭到達目的位置時播放音效。';
		deps = DEPENDENCY;
		advd = true;
	};
	UIpointerDefaultIcon = _{Data.Bool(true);
		name = '顯示預設按鈕';
		desc = '顯示預設的滑鼠動作按鈕。';
		deps = DEPENDENCY;
		advd = true;
	};
	UIaccessUnlimited = _{Data.Bool(false);
		name = '無使用限制';
		desc = '讓游標可以和整個介面互動，不只是面板。';
		note = '與依需求出現結合，可以實現完整的游標控制。';
		deps = DEPENDENCY;
		advd = true;
	};
	UIshowOnDemand = _{Data.Bool(false);
		name = '依需求出現';
		desc = '需要時便會顯示游標，而不是面板出現時才顯示。';
		note = '需要綁定 "切換介面游標" 按鈕來使用游標。';
		deps = DEPENDENCY;
		advd = true;
	};
	UIholdRepeatDisable = _{Data.Bool(false);
		name = '停用重覆移動';
		desc = '停用重覆的游標移動 - 每按一下只會移動游標一次。';
		deps = DEPENDENCY;
	};
	UIholdRepeatDelay = _{Data.Number(.125, 0.025);
		name = '重覆移動延遲';
		desc = '按住某個方向時，重覆移動之前的延遲時間 (以秒為單位)。';
		deps = { UIenableCursor = true, UIholdRepeatDisable = false };
		advd = true;
	};
	UIholdRepeatDelayFirst = _{Data.Number(.125, 0.025);
		name = '重覆移動首次延遲';
		desc = '按住某個方向時，第一次移動重覆之前的延遲時間 (以秒為單位)。';
		deps = { UIenableCursor = true, UIholdRepeatDisable = false };
		advd = true;
	};
	UIleaveCombatDelay = _{Data.Number(0.5, 0.1);
		name = '重新啟動延遲';
		desc = '脫離戰鬥後，重新啟動介面遊標之前的延遲時間 (以秒為單位)。';
		deps = DEPENDENCY;
		advd = true;
	};
	UIpointerSize = _{Data.Number(22, 2, true);
		name = '指標大小';
		desc = '指標箭頭的大小 (以像素為單位)。';
		deps = DEPENDENCY;
		advd = true;
	};
	UIpointerOffset = _{Data.Number(-2, 1);
		name = '指標位置';
		desc = '指標箭頭距離選取點中心的偏移位置 (以像素為單位)。';
		deps = DEPENDENCY;
		advd = true;
	};
	UItravelTime = _{Data.Range(4, 1, 1, 10);
		name = '移動時間';
		desc = '游標從一個點轉換到另一個點需要多長時間。';
		note = '數值愈高愈慢。';
		deps = DEPENDENCY;
		advd = true;
	};
	UICursorLeftClick = _{Data.Button('PAD1');
		name = KEY_BUTTON1;
		desc = '模擬左鍵點選的按鈕，這是主要的介面操作。';
		note = '按住並且移動方向搖桿可以模擬拖曳。';
		deps = DEPENDENCY;
	};
	UICursorRightClick = _{Data.Button('PAD2');
		name = KEY_BUTTON2;
		desc = '模擬右鍵點選的按鈕，這是次要的介面操作。';
		note = '直接在背包中使用或賣出物品時會需要這個按鈕。';
		deps = DEPENDENCY;
	};
	UICursorSpecial = _{Data.Button('PAD4');
		name = '特殊按鈕';
		desc = '處理相關動作的按鈕，例如將物品加入工具環。';
		deps = DEPENDENCY;
	};
	UICursorCancel = _{Data.Button('PAD3');
		name = '取消按鈕';
		desc = '處理取消動作的按鈕，例如關閉選單。';
		deps = DEPENDENCY;
	};
	UImodifierCommands = _{Data.Select('SHIFT', unpack(MODID_SELECT));
		name = '輔助鍵';
		desc = '使用哪個輔助鍵來執行輔助指令。';
		note = '輔助鍵和方向搖桿一起使用可以捲動內容。';
		opts = MODID_SELECT;
		deps = DEPENDENCY;
	};
})

---------------------------------------------------------------
-- Standalone frame stack
---------------------------------------------------------------
-- This list aims to contain all the frames, popups, panels
-- that are not caught by frame managers (e.g. UIPanelWindows),
-- and exist within the FrameXML code in some shape or form. 

env.StandaloneFrameStack = {
	'ContainerFrameCombinedBags';
	'CovenantPreviewFrame';
	'EngravingFrame';
	'LFGDungeonReadyPopup';
	'OpenMailFrame';
	'PetBattleFrame';
	'ReadyCheckFrame';
	'SplashFrame';
	'StackSplitFrame';
	'UIWidgetCenterDisplayFrame';
};
for i=1, (NUM_CONTAINER_FRAMES   or 13) do tinsert(env.StandaloneFrameStack, 'ContainerFrame'..i) end
for i=1, (NUM_GROUP_LOOT_FRAMES  or 4)  do tinsert(env.StandaloneFrameStack, 'GroupLootFrame'..i) end
for i=1, (STATICPOPUP_NUMDIALOGS or 4)  do tinsert(env.StandaloneFrameStack, 'StaticPopup'..i)    end

env.UnlimitedFrameStack = {
	UIParent;
	DropDownList1;
	DropDownList2;
};


---------------------------------------------------------------
-- Frame management resources
---------------------------------------------------------------

-- Managers are periodically scanned by the frame stack handler
-- to add new frames to the registry. The table is associative
-- if the value is true, and indexed if the value is false.
env.FrameManagers = { -- table, isAssociative
	[UIPanelWindows]  = true;
	[UISpecialFrames] = false;
	[UIMenus]         = false;
};

-- Pipelines are hooked by the frame stack handler to add new
-- frames to the registry as they pass through the pipeline.
-- Global references are hooked by name, and methods are hooked
-- by name and method name.
env.FramePipelines = { -- global ref, bool or method
	ShowUIPanel             = true;
	StaticPopupSpecial_Show = true;
	HelpTipTemplateMixin    = 'Init';
};

---------------------------------------------------------------
-- Node management resources
---------------------------------------------------------------
env.IsClickableType = {
	Button      = true;
	CheckButton = true;
	EditBox     = true;
};

env.DropdownReplacementMacro = {
	SET_FOCUS   = '/focus %s';
	CLEAR_FOCUS = '/clearfocus';
	PET_DISMISS = '/petdismiss';
};

env.Attributes = {
	IgnoreNode   = 'nodeignore';
	IgnoreScroll = 'nodeignorescroll';
	PassThrough  = 'nodepass';
	Priority     = 'nodepriority';
	Singleton    = 'nodesingleton';
	SpecialClick = 'nodespecialclick';
	CancelClick  = 'nodecancelclick';
	IgnoreMime   = 'nodeignoremime';
};

---------------------------------------------------------------
-- Unavoidable taint error messages
---------------------------------------------------------------
env.ForbiddenActions = CPAPI.Proxy({
	['FocusUnit()'] = ([[
		介面游標顯示時，無法可靠的從單位的下拉選單設定專注目標。

		請使用其他方式設定專注目標，例如 %s 按鈕綁定， 巨集 /focus 或團隊游標。
	]]):format(BLUE_FONT_COLOR:WrapTextInColorCode(BINDING_NAME_FOCUSTARGET));
	['ClearFocus()'] = ([[
		介面游標顯示時，無法可靠的從單位的下拉選單清除專注目標。

		請使用其他方式清除專注目標，例如 %s 按鈕綁定， 巨集 /focus 或團隊游標。
	]]):format(BLUE_FONT_COLOR:WrapTextInColorCode(BINDING_NAME_FOCUSTARGET));
	['CastSpellByID()'] = [[
		介面游標顯示時，有幾個操作無法可靠地執行。
		看起來你試圖施放一個法術，但來源已被介面游標污染。
				   

		請使用其他方式施放法術，例如使用巨集或快捷列。
	]];
}, function()
	return [[
		介面游標顯示時，有幾個操作無法可靠地執行。
		看起來你嘗試執行的動作因為游標的污染而被阻止。

		通常可以忽略此訊息，但如果使用者介面無法正常運作，可能需要重新載入。
	]];
end);