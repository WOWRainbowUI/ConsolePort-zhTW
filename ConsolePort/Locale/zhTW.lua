local L = select(2, ...).Locale:GetLocale('zhTW'); if not L then return end;
---------------------------------------------------------------
-- zhTW 繁體中文
---------------------------------------------------------------
-- Short
---------------------------------------------------------------
L.DESC_CAMERAZOOMIN           = '把鏡頭拉近，按住不放可持續拉近。';
L.DESC_CAMERAZOOMOUT          = '把鏡頭拉遠，按住不放可持續拉遠。';
L.DESC_OPENALLBAGS            = '打開或關閉所有背包。';
L.DESC_TOGGLEWORLDMAP_CLASSIC = '切換顯示世界地圖。';
L.DESC_TOGGLEWORLDMAP_RETAIL  = '切換顯示世界地圖和任務記錄。';
L.NAME_EASY_MOTION            = '目標單位框架 (按住)';
L.NAME_RAID_CURSOR_FOCUS      = '團隊游標設為專注目標';
L.NAME_RAID_CURSOR_TARGET     = '團隊游標選為當前目標';
L.NAME_RAID_CURSOR_TOGGLE     = '切換團隊游標';
L.NAME_RING_MENU              = '選單環';
L.NAME_RING_PET               = '寵物環';
L.NAME_RING_UTILITY           = '工具環';
L.NAME_UI_CURSOR_TOGGLE       = '切換介面游標';
---------------------------------------------------------------
-- Formats
---------------------------------------------------------------
L.FORMAT_HOLD_BINDING         = '%s (按住)';
L.FORMAT_RING_NUMERICAL       = '環 |cFF00FFFF%s|r';
---------------------------------------------------------------
-- Long
---------------------------------------------------------------
L.DESC_KEY_BUTTON1 = [[
	用來切換自由移動的游標，讓你可以使用控制鏡頭的搖桿來移動滑鼠指標。

	當其中一個按鈕設為模擬左鍵點擊時，無法更改這個按鈕綁定。
]];
L.DESC_KEY_BUTTON2 = [[
	用來切換中心點游標，讓你用固定在中心點位置的滑鼠，和遊戲中的物件和角色互動。

	當其中一個按鈕設為模擬右鍵點擊時，無法更改這個按鈕綁定。
]];
L.DESC_INTERACTTARGET = [[
	讓你能夠與遊戲世界中的 NPC 和物件互動。

	和中心點游標有相同的功能，但是不需要將游標或十字線直接對準目標。

	在可互動的範圍內時會顯著標示。
]];
L.DESC_TARGETSCANENEMY = [[
	掃描前方狹窄錐形區域中的敵人。
	切換目標前，可以先按住不放來顯著標示目標。

	戰鬥中需要快速且準確的切換目標時非常有用。

	會依據瞄準方向來決定優先選取的目標，也就是說最接近錐形中心的目標會最先被選取。
	如果較遠的目標較接近錐形中心，那麼就會優先選取較遠的目標。

	建議作為大多數玩家主要的選取目標按鈕綁定。
]];
L.DESC_TARGETNEARESTENEMY = [[
	在你前方最近的敵方目標之間切換。
	如果沒有當前目標，會選取最靠中心的敵人。
	否則會在最近的目標之間循環。

	切換目標前，可以先按住不放來顯著標示目標。

	建議作為次要的選取目標按鈕綁定，或是休閒玩法的主要選取目標按鈕綁定，
	或是目標掃描的準確度過高而覺得不舒服時。

	不建議在地城或其他需要高準確度的場景使用。
]];
L.DESC_JUMP = [[
	也可以用來在水下往上游、飛行坐騎往上升和騎龍時升空或向上衝。

	跳躍可以彌補左手拇指操作的空隙。

	在一般的設定中，左搖桿控制移動。
	如果你需要在移動時按下十字鍵和按鈕的組合，跳躍可以讓你保持往前移動，拇指便能短暫的離開左搖桿。
]];
L.DESC_TOGGLEAUTORUN = [[
	動奔跑會讓角色持續朝面前的方向前進，而不需要你做任何操作。

	在長時間的移動中，自動奔跑有助於減輕拇指的僵直，解放拇指去做其他事情。
]];
L.DESC_TOGGLEGAMEMENU = [[
	選單按鈕綁定處理按下鍵盤 Esc 鍵時出現的所有功能，根據遊戲當前狀態來處理不同的動作。			

	如果有任何正在進行中，和法術或選取目標正有關的動作，都會被取消。
	有當前目標時，按下綁定的按鈕會清除目標。
	正在唱法時，按下綁定的按鈕會中斷施法。

	這個按鈕綁定還會根據目前畫面上顯示的內容來處理多種其他情況。
	例如：如果有打開任何面板，像是法術書，這個按鈕綁定執行必要的動作來關閉或隱藏它。

	沒有上述的任何情況時，按下綁定的按鈕會打開或關閉遊戲選單。
]];
L.DESC_EXTRAACTIONBUTTON1 = [[
	額外技能按鈕會顯示在多種不同的任務、事件和首領戰時用到的暫時性技能。

	沒有設定這個按鈕綁定時，永遠都可以在工具環中使用額外技能。

	這個按鈕顯示在搖桿快捷列上時，看起來像是一般的技能，但是你無法更改它的內容。
]];
L.DESC_EASY_MOTION = [[
	為畫面上的單位框架產生單位快速鍵，讓你能夠在友方目標之間快速做切換。

	用法為，先按住綁定的按鈕不放，然後按下你要選擇的目標的提示按鈕，再放開綁定的按鈕來切換目標。

	非常推薦治療者在 5 人隊伍中使用這個按鈕綁定，這是一種在小型隊伍中非常快速的選擇目標方式。

	在團隊中，則會變成需要很複雜的操作才能選到你要的目標。團隊游標會是另一種較適合的選擇。
]];
L.DESC_RAID_CURSOR = [[
	切換顯示指向畫面上單位框架的游標，讓你在治療友方玩家的同時，還能保有另一個選取目標。

	團隊游標也可以設為直接選取目標，移動游標時便會切換你的當前目標。

	使用時，團隊游標會佔用一組方向鍵組合來控制游標的位置。

	在不切換目標對該目標施法的模式中，游標不會對該目標施放巨集或友方/敵方皆可使用的技能，例如牧師的懺悟。

	另一種選擇是目標單位框架。
]];
L.DESC_RING_CUSTOM = [[
	環形選單可以讓你放置不想浪費快捷列格子來放的物品、法術、巨集和坐騎。

	用法為，先按住綁定的按鈕不放，旋轉搖桿向你要選擇的項目傾斜，再放開按鈕。

	要從環形選單中移除項目，選定該項目後，依照浮動提示說明來操作。
]];
L.DESC_RING_UTILITY = [[
	工具環可以讓你放置不想浪費快捷列格子來放的物品、法術、巨集和坐騎。

	用法為，先按住綁定的按鈕不放，旋轉搖桿向你要選擇的項目傾斜，再放開按鈕。

	要將東西加入到工具環中，請依照介面游標的提示說明來做。另一個方法是，用滑鼠游標選取某樣東西後，再按下綁定的按鈕將它放入到工具環。

	要從工具環中移除項目，選定該項目後，依照浮動提示說明來操作。

	工具環會自動加入尚未放到快捷列上的任務道具和暫時性技能。
]];
L.DESC_RING_PET = [[
	用來控制當前寵物的環形選單。
]];
L.DESC_RING_MENU = [[
	將常用面板和頻繁操作集中在一個地方，方便快速使用的環形選單。

	這個環形選單也可以從遊戲選單中使用，無需單獨綁定，只需切換頁面即可。
]];
L.IMPORT_DATA_TEXT = [[

|cFFFFFF00匯入|r

請在下方貼上匯出的文字字串，然後載入並選擇要匯入的資料。如果可以套用的話，匯入的資料會覆蓋掉目前的資料。

在來源按下 %s 複製文字字串，然後在下方按 %s 貼上。
]];
L.EXPORT_DATA_TEXT = [[

|cFFFFFF00匯出|r

請選擇要匯出的資料。會在下方產生文字字串，可供複製貼上到其他電腦，或是分享給其他玩家。

按下 %s 來複製文字字串。
]];
L.IMPORT_FAILED_TEXT = [[

|cFFFFFF00匯入|r

匯入失敗：
]];
L.SELECTED_RING_TEXT = [[這是目前選擇的環形選單。
按住綁定的按鈕不放時，所有選擇的能力都會出現在畫面上並形成一個環。

轉動搖桿方向，朝要使用的能力傾斜，然後放開綁定的按鈕來用它。]];
L.ADD_NEW_RING_TEXT = [[|cFFFFFF00建立新環|r
請選擇新環形選單的名稱:]];
L.SET_RING_BINDING_TEXT = [[ 
|cFFFFFF00設定按鈕綁定|r

按下要使用這個環形選單的按鈕組合。

]];
L.RING_MENU_DESC = [[建立你自己的環形選單，放置你不想浪費快捷列格子來放的物品、法術、巨集和坐騎。

用法為，先按住綁定的按鈕不放，旋轉搖桿向你要選擇的項目傾斜，再放開按鈕。

預設的環，也稱為 |CFF00FF00工具環|r，具有讓做任務更輕鬆，以及更容易與世界互動的特性，它並非固定不變的。會在需要的時候自動新增和移除選單項目。

如果你想要建立能搭配輸出迴圈使用的環，而不只是工具物品，那麼強烈建議你使用自訂環來做。]];
L.RING_EMPTY_DESC = [[這個環還沒有加入任何技能。]];
L.CLEAR_RING_TEXT = [[|cFFFFFF00清空工具環|r
是否確定要清空目前的工具環?]];
L.REMOVE_RING_TEXT = L[[|cFFFFFF00移除環|r
是否確定要移除目前的環形選單?]];