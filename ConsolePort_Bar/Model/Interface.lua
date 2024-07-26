local c, _, env, Data = CreateCounter(), ...; Data = env.db.Data;
_ = function(i) i.sort = c() return i end;
---------------------------------------------------------------
-- 輔助函式
---------------------------------------------------------------

env.Toplevel = {
	Art     = false;
	Cluster = false;
	Divider = false;
	Group   = false;
	Page    = false;
	Petring = true;
	Toolbar = true;
}; -- k: 介面, v: 唯一

---------------------------------------------------------------
local Type = {}; env.Types = Type;
---------------------------------------------------------------
Type.SimplePoint = Data.Interface {
	name = '位置';
	desc = '元素的位置。';
	Data.Point {
		point = _{
			name = '定位點';
			desc = '要附加的定位點。';
			Data.Select('CENTER', env.Const.ValidPoints());
		};
		relPoint = _{
			name = '相對定位點';
			desc = '要配對的父元素的定位點。';
			Data.Select('CENTER', env.Const.ValidPoints());
		};
		x = _{
			name = '水平位置';
			desc = '距離定位點的水平偏移量。';
			Data.Number(0, 1, true);
		};
		y = _{
			name = '垂直位置';
			desc = '距離定位點的垂直偏移量。';
			vert = true;
			Data.Number(0, 1, true);
		};
	};
};

Type.Visibility = Data.Interface {
	name = '可見性';
	desc = env.MakeMacroDriverDesc(
		'元素的可見性條件。接受巨集條件和可見性狀態的配對，或單個可見性狀態。',
		'根據條件顯示或隱藏元素。',
		'condition', 'state', true, nil, {
			['show'] = '顯示元素。',
			['hide'] = '隱藏元素。'
		}
	);
	Data.String(env.Const.DefaultVisibility);
};

Type.Opacity = Data.Interface {
	name = '不透明度';
	desc = env.MakeMacroDriverDesc(
		'元素的不透明度條件。接受巨集條件和百分比不透明度的配對，或單個不透明度值。',
		'根據條件更改元素的不透明度。',
		'condition', 'opacity', true, nil, {
			['100'] = '完全不透明。',
			['50']  = '半透明。',
			['0']   = '完全透明。'
		}
	);
	note = '不透明度以百分比表示，其中 100 為完全可見，0 為完全透明。超出 0-100 範圍的值將被限制。';
	Data.String('100');
};

Type.Scale = Data.Interface {
	name = '縮放';
	desc = env.MakeMacroDriverDesc(
		'元素的縮放條件。接受巨集條件和百分比縮放的配對，或單個縮放值。',
		'將元素縮放到適用的比例。',
		'condition', 'scale', true, nil, {
			['100'] = '正常比例。',
			['200'] = '雙倍比例。',
			['50']  = '一半比例。'
		}
	);
	Data.String('100');
};

Type.Override = Data.Interface {
	name = '覆蓋';
	desc = env.MakeMacroDriverDesc(
		'元素的綁定覆蓋條件。接受巨集條件和覆蓋狀態的配對，或單個覆蓋狀態。',
		'設置或取消設置元素的適用綁定。',
		'condition', 'override', true, nil, {
			['true']   = '綁定設置為元素。',
			['false']  = '從元素中移除綁定。',
			['shown']  = '元素顯示時設置綁定。',
			['hidden'] = '元素隱藏時設置綁定。'
		}
	);
	Data.String('shown');
};

Type.Modifier = Data.Interface {
	name = '輔助鍵';
	desc = env.MakeMacroDriverDesc(
		'元素的輔助鍵條件。接受巨集條件和輔助鍵的配對。',
		'切換按鈕以顯示適用的輔助鍵。',
		'condition', 'modifier', false, {
			['M0']   = '無輔助鍵的簡寫。',
			['M1']   = 'Shift 輔助鍵的簡寫。',
			['M2']   = 'Ctrl 輔助鍵的簡寫。',
			['M3']   = 'Alt 輔助鍵的簡寫。',
			['[mod:...]'] = '匹配按住的輔助鍵的前綴。',
			['[]']   = '空條件，始終為真。'
		}, {
			['Mn']   = '要切換到的按鈕集，其中 n 是輔助鍵編號。可以組合多個輔助鍵。'
		}
	);
	note = '輔助鍵可以組合。例如，M1M2 是同時按住 Shift 和 Ctrl 輔助鍵。';
	Data.String(' ');
};

Type.Page = Data.Interface {
	name = '頁面';
	desc = env.MakeMacroDriverDesc(
		'元素的頁面條件。接受巨集條件和頁面標識符的配對，或單個頁碼。',
		'使用以下公式將按鈕切換到適用的頁面：\nslotID = (page - 1) * slots + offset + i',
		'condition', 'page', true, env.Const.PageDescription, {
			['dynamic']  = '動態頁碼，與全局頁碼匹配。',
			['override'] = '解析為當前的覆蓋或載具頁面。',
			['n']        = '要切換到的靜態頁碼。'
		}
	);
	Data.String('dynamic');
};

---------------------------------------------------------------
local Interface = {}; env.Interface = Interface;
---------------------------------------------------------------
Interface.ClusterHandle = Data.Interface {
	name = '快捷鍵群組控制代碼';
	desc = '單個按鈕的所有輔助鍵的按鈕快捷鍵群組。';
	Data.Table {
		type = {hide = true; Data.String('ClusterHandle')};
		pos = _(Type.SimplePoint : Implement {
			desc = '按鈕快捷鍵群組的位置。';
		});
		size = _{
			name = '大小';
			desc = '按鈕快捷鍵群組的大小。';
			Data.Number(64, 2);
		};
		showFlyouts = _{
			name = '顯示下拉選單';
			desc = '顯示按鈕快捷鍵群組的小按鈕下拉選單。';
			Data.Bool(true);
		};
		dir = _{
			name = '方向';
			desc = '按鈕快捷鍵群組的方向。';
			Data.Select('DOWN', env.Const.Cluster.Directions());
		};
	};
};

Interface.Cluster = Data.Interface {
	name = '快捷列群組';
	desc = '快捷列群組。';
	Data.Table {
		type = {hide = true; Data.String('Cluster')};
		children = _{
			name = '按鈕';
			desc = '快捷列群組中的按鈕。';
			Data.Mutable(Interface.ClusterHandle):SetKeyOptions(env.Const.ProxyKeyOptions);
		};
		pos = _(Type.SimplePoint : Implement {
			desc = '快捷列群組的位置。';
			{
				point    = 'BOTTOM';
				relPoint = 'BOTTOM';
				y        = 16;
			};
		});
		width = _{
			name = '寬度';
			desc = '快捷列群組的寬度。';
			Data.Number(1200, 25);
		};
		height = _{
			name = '高度';
			desc = '快捷列群組的高度。';
			Data.Number(140, 25);
		};
		rescale    = _(Type.Scale : Implement {});
		visibility = _(Type.Visibility : Implement {});
		opacity    = _(Type.Opacity : Implement {});
		override   = _(Type.Override : Implement {});
	};
};

Interface.GroupButton = Data.Interface {
	name = '動作按鈕';
	desc = '群組中的動作按鈕。';
	Data.Table {
		type = {hide = true; Data.String('GroupButton')};
		pos = Type.SimplePoint : Implement {
			desc = '按鈕的位置。';
		};
	};
};

Interface.Group = Data.Interface {
	name = '動作按鈕群組';
	desc = '一組動作按鈕。';
	Data.Table {
		type = {hide = true; Data.String('Group')};
		children = _{
			name = '按鈕';
			desc = '群組中的按鈕。';
			Data.Mutable(Interface.GroupButton):SetKeyOptions(env.Const.ProxyKeyOptions);
		};
		pos = _(Type.SimplePoint : Implement {
			desc = '群組的位置。';
			{
				point    = 'BOTTOM';
				relPoint = 'BOTTOM';
				y        = 16;
			};
		});
		width = _{
			name = '寬度';
			desc = '群組的寬度。';
			Data.Number(400, 10);
		};
		height = _{
			name = '高度';
			desc = '群組的高度。';
			Data.Number(120, 10);
		};
		modifier   = _(Type.Modifier : Implement {});
		rescale    = _(Type.Scale : Implement {});
		visibility = _(Type.Visibility : Implement {});
		opacity    = _(Type.Opacity : Implement {});
		override   = _(Type.Override : Implement {});
	};
};

Interface.Page = Data.Interface {
	name = '快捷列頁面';
	desc = '快捷列的一個頁面。';
	Data.Table {
		type = {hide = true; Data.String('Page')};
		pos = _(Type.SimplePoint : Implement {
			desc = '頁面的位置。';
			{
				point    = 'BOTTOM';
				relPoint = 'BOTTOM';
				y        = 20;
			};
		});
		hotkeys = _{
			name = '顯示快捷鍵';
			desc = '在按鈕上顯示快捷鍵。';
			Data.Bool(true);
		};
		reverse = _{
			name = '反轉順序';
			desc = '反轉按鈕的順序。';
			Data.Bool(false);
		};
		paddingX = _{
			name = '水平間距';
			desc = '按鈕之間的水平間距。';
			Data.Number(4, 1);
		};
		paddingY = _{
			name = '垂直間距';
			desc = '按鈕之間的垂直間距。';
			vert = true;
			Data.Number(4, 1);
		};
		orientation = _{
			name = '方向';
			desc = '頁面的方向。';
			Data.Select('HORIZONTAL', '水平', '垂直');
		};
		stride = _{
			name = '換行';
			desc = '每行或每列的按鈕數量。';
			Data.Range(NUM_ACTIONBAR_BUTTONS, 1, 1, NUM_ACTIONBAR_BUTTONS);
		};
		slots = _{
			name = '格子';
			desc = '頁面中的按鈕數量。';
			Data.Range(NUM_ACTIONBAR_BUTTONS, 1, 1, NUM_ACTIONBAR_BUTTONS);
		};
		offset = _{
			name = '位置';
			desc = '頁面的起點。';
			Data.Range(1, 1, 1, NUM_ACTIONBAR_BUTTONS);
		};
		page       = _(Type.Page : Implement {});
		rescale    = _(Type.Scale : Implement {});
		visibility = _(Type.Visibility : Implement {});
		opacity    = _(Type.Opacity : Implement {});
		override   = _(Type.Override : Implement {});
	};
};

Interface.Petring = Data.Interface {
	name = '寵物指令環';
	desc = '寵物指令的按鈕環。';
	Data.Table {
		type = {hide = true; Data.String('Petring')};
		pos = _(Type.SimplePoint : Implement {
			desc = '寵物指令環的位置。';
			{
				point    = 'BOTTOM';
				relPoint = 'BOTTOM';
				y        = 90;
			};
		});
		fade = _{
			name = '淡出按鈕';
			desc = '當滑鼠未指向時淡出寵物指令環。';
			Data.Bool(true);
		};
		status = _{
			name = '狀態列';
			desc = '顯示寵物能量和生命值狀態。';
			Data.Bool(true);
		};
		vehicle = _{
			name = '啟用載具';
			desc = '在載具中時顯示寵物指令環。';
			Data.Bool(true);
		};
		scale = _{
			name = '縮放';
			desc = '寵物指令環的縮放。';
			Data.Range(0.75, 0.05, 0.5, 2);
		};
	};
};

Interface.Toolbar = Data.Interface {
	name = '工具列';
	desc = '帶有經驗值指示器、快捷方式、職業特定列和其他資訊的工具列。';
	Data.Table {
		type = {hide = true; Data.String('Toolbar')};
		pos = _(Type.SimplePoint : Implement {
			desc = '工具列的位置。';
			{
				point    = 'BOTTOM';
				relPoint = 'BOTTOM';
			};
		});
		menu = _{
			name = '選單';
			desc = '要在工具列上顯示的選單按鈕。';
			Data.Table {
				eye = _{
					name = '快捷鍵群組輔助鍵開關';
					desc = '切換快捷列群組的所有輔助鍵下拉選單的可見性。';
					Data.Bool(true);
				};
				micromenu = _{
					name = '微型選單';
					desc = '取得微型選單按鈕的所有權，並將其移動到工具列。';
					note = '停用後需要 /reload 才能完全取消掛鉤。';
					Data.Bool(true);
				};
			};
		};
		castbar = _{
			name = '施法條';
			desc = '設定施法條。';
			note = '此功能僅在經典版中可用。';
			hide = CPAPI.IsRetailVersion;
			Data.Table {
				enabled = _{
					name = '啟用';
					desc = '啟用施法條所有權。';
					note = '停用後需要 /reload 才能完全取消掛鉤。';
					Data.Bool(true);
				};
			};
		};
		totem = _{
			name = '職業快捷列';
			desc = '設定與職業相關的快捷列。';
			note = CPAPI.IsRetailVersion and '此功能僅在經典版中可用。';
			hide = CPAPI.IsRetailVersion;
			Data.Table {
				enabled = _{
					name = '啟用';
					desc = '啟用職業快捷列所有權。';
					note = '停用後需要 /reload 才能完全取消掛鉤。';
					Data.Bool(true);
				};
				hidden = _{
					name = '隱藏';
					desc = '隱藏職業快捷列。';
					Data.Bool(false);
				};
				pos = _(Type.SimplePoint : Implement {
					desc = '職業快捷列的位置。';
					{
						point    = 'BOTTOM';
						relPoint = 'BOTTOM';
						y        = 190;
					};
				});
			};
		};
		width = _{
			name = '寬度';
			desc = '工具列的寬度。';
			Data.Range(900, 25, 300, 1200);
		};
	};
};

Interface.Divider = Data.Interface {
	name = '分隔線';
	desc = '分隔元素的分隔線。';
	Data.Table {
		type = {hide = true; Data.String('Divider')};
		pos = _(Type.SimplePoint : Implement {
			desc = '分隔線的位置。';
			{
				point    = 'BOTTOM';
				relPoint = 'BOTTOM';
				y        = 100;
			};
		});
		breadth = _{
			name = '寬度';
			desc = '分隔線的寬度。';
			Data.Number(400, 25);
		};
		depth = _{
			name = '深度';
			desc = '分隔線的深度。';
			vert = true;
			Data.Number(50, 10);
		};
		thickness = _{
			name = '厚度';
			desc = '分隔線的厚度。';
			Data.Range(1, 1, 1, 10)
		};
		intensity = _{
			name = '強度';
			desc = '漸變的強度。';
			Data.Range(25, 5, 0, 100);
		};
		rotation = _{
			name = '旋轉';
			desc = '分隔線的旋轉。';
			Data.Range(0, 5, 0, 360);
		};
		transition = _{
			name = '過渡';
			desc = '不透明度變化的過渡時間。';
			note = '不透明度從一種狀態變為另一種狀態的時間（以毫秒為單位）。';
			Data.Range(50, 25, 0, 500);
		};
		opacity = _(Type.Opacity : Implement {});
		rescale = _(Type.Scale : Implement {});
	};
};

Interface.Art = Data.Interface {
	name = '美術圖';
	desc = '介面的美術圖。';
	Data.Table {
		type = {hide = true; Data.String('Art')};
		pos = _(Type.SimplePoint : Implement {
			desc = '美術圖的位置。';
			{
				point    = 'BOTTOM';
				relPoint = 'BOTTOM';
				y        = 16;
			};
		});
		width = _{
			name = '寬度';
			desc = '美術圖的寬度。';
			Data.Number(768, 16);
		};
		height = _{
			name = '高度';
			desc = '美術圖的高度。';
			Data.Number(192, 16);
		};
		style = _{
			name = '風格';
			desc = '美術圖風格。';
			Data.Select('Collage', env.Const.Art.Types());
		};
		flavor = _{
			name = '主題';
			desc = '美術圖主題。';
			Data.Select('Class', '職業', unpack(env.Const.Art.Selection));
		};
		blend = _{
			name = '混合模式';
			desc = '美術圖的混合模式。';
			Data.Select('BLEND', env.Const.Art.Blend());
		};
		opacity = _(Type.Opacity : Implement {});
		rescale = _(Type.Scale : Implement {});
	};
};