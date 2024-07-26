local db, Data, _, env = ConsolePort:DB(), ConsolePort:DB('Data'), ...; _, env.db = CPAPI.Define, db;
------------------------------------------------------------------------------------------------------------
ConsolePort:AddVariables({
------------------------------------------------------------------------------------------------------------
	_(MAINMENU_BUTTON, 2);
	gameMenuScale = _{Data.Range(0.85, 0.05, 0.5, 2);
		name = '縮放大小';
		desc = '縮放遊戲選單和環形選單的大小。';
	};
	gameMenuFontSize = _{Data.Range(15, 1, 8, 20);
		name = '文字大小';
		desc = '環形選單按鈕的文字大小。';
	};
	gameMenuCustomSet = _{Data.Bool(false);
		name = '使用自訂按鈕設定';
		desc = '遊戲選單使用自訂的按鈕設定，否則將動態決定按鈕設定。';
	};
	gameMenuAccept = _{Data.Button('PAD1');
		name = '主要按鈕';
		desc = '執行動作並關閉選單。';
		deps = { gameMenuCustomSet = true };
	};
	gameMenuPlural = _{Data.Button('PAD2');
		name = '多個按鈕';
		desc = '執行動作單但不關閉選單。';
		deps = { gameMenuCustomSet = true };
	};
	gameMenuReturn = _{Data.Button('PADLSHOULDER');
		name = '返回按鈕';
		desc = '返回上一個選單。';
		deps = { gameMenuCustomSet = true };
	};
	gameMenuSwitch = _{Data.Button('PADRSHOULDER');
		name = '切換按鈕';
		desc = '切換主選單和環形選單。';
		deps = { gameMenuCustomSet = true };
	};
})