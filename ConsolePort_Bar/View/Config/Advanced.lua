local _, env, db = ...; db = env.db;
---------------------------------------------------------------
local Editor = CreateFromMixins(ScrollingEditBoxMixin);
---------------------------------------------------------------

local function Format(text) return (text or ''):gsub('\t', '  ') end;
local function Prune(text, cmp)  return text ~= cmp and text or nil end;

function Editor:SetData(current, default)
	self:SetDefaultTextEnabled(not current)
	self:SetDefaultText(Format(default))
	self:SetText(Format(current))
end

function Editor:GetData()
	return Prune(self:GetInputText(), ''), self:GetEditBox().defaultText;
end

---------------------------------------------------------------
local Advanced = Mixin({
---------------------------------------------------------------
	EditorControls = {
		{
			tooltipTitle = RESET;
			icon         = [[Interface\RAIDFRAME\ReadyCheck-NotReady]];
			iconSize     = 16;
			onClickHandler = function(self)
				local _, default = self.data.get()
				self.data.set(default)
				self.data.editor:SetData(self.data.get())
			end;
		};
		{
			tooltipTitle = SAVE;
			icon         = [[Interface\RAIDFRAME\ReadyCheck-Ready]];
			iconSize     = 16;
			onClickHandler = function(self)
				local text = self.data.editor:GetData()
				if text then
					self.data.set(text)
				end
			end;
		};
	};
	Headers = {
		Condition = {
			name   = '頁面條件';
			height = 50;
			get    = function() return db('actionPageCondition'), db.Pager:GetDefaultPageCondition() end;
			set    = function(value) db('Settings/actionPageCondition', Prune(value, db.Pager:GetDefaultPageCondition())) end;
			text   = env.MakeMacroDriverDesc(
				'快捷列列頁面的全域條件。接受巨集條件和頁數的配對，或單一頁數。',
				'將結果頁面發送到回應處理程序以進行後置處理。',
				'actionbar', 'page', true, env.Const.PageDescription, {
					n = '要發送給回應處理程序的頁數。';
					any = '要發送給回應處理程序的簡單值（數字、字符、布林值），其中會計算實際的快捷列頁數。';
				}, WHITE_FONT_COLOR);
		};
		Response = {
			name   = '頁面回應';
			height = 150;
			get    = function() return db('actionPageResponse'), db.Pager:GetDefaultPageResponse() end;
			set    = function(value) db('Settings/actionPageResponse', Prune(value, db.Pager:GetDefaultPageResponse())) end;
			text   = env.MakeMacroDriverDesc(
				'快捷列頁面條件的 Lua 全域後置處理，會在所有快捷列和系統之間共享，僅供受限的環境 API。',
				'將結果頁面設置到動作檔頭，進而更新動作按鈕。',
				nil, nil, nil, {
					newstate = '條件處理程序返回的結果值。';
				}, {
					newstate = '要在動作檔頭上設定的結果頁數。';
				}, WHITE_FONT_COLOR);
		};
		Visibility = {
			name   = '顯示條件';
			height = 30;
			get    = function() return env('Layout/visibility'), env.Const.ManagerVisibility end;
			set    = function(value) env('Layout/visibility', value) end;
			text   = env.MakeMacroDriverDesc(
				'會顯示快捷列的全域條件，在所有快捷列之間共享。',
				'根據條件的結果設定所有快捷列元件是否會顯示。',
				'actionbar', 'visibility', true, {
					['vehicleui']   = '已啟用載具介面。';
					['overridebar'] = '已啟用覆蓋列，在沒有載具介面的特定場景時使用。';
					['petbattle']   = '玩家在寵物對戰中。';
				}, {
					['show'] = '顯示快捷列。';
					['hide'] = '隱藏快捷列。';
				}, WHITE_FONT_COLOR);
		};
	};
}, env.SharedConfig.HeaderOwner);

function Advanced:OnLoad(inputHandler, headerPool)
	local sharedConfig = env.SharedConfig;
	sharedConfig.HeaderOwner.OnLoad(self, sharedConfig.Header)

	self.owner = inputHandler;
	self.headerPool = headerPool;
	self.cmdButtonPool = sharedConfig.CreateSquareButtonPool(self, sharedConfig.CmdButton)

	CPAPI.Start(self)
end

function Advanced:OnShow()
	local layoutIndex = CreateCounter()
	self.headerPool:ReleaseAll()
	self.cmdButtonPool:ReleaseAll()
	self:MarkDirty()

	local function DrawEditor(info)
		local header = self:CreateHeader(info.name)
		header.layoutIndex = layoutIndex()
		header:SetTooltipInfo(info.name, info.text)

		local editor = info.editor or Mixin(env.SharedConfig.CreateEditBox(self), Editor);
		editor:SetSize(header:GetWidth() - 8, info.height)
		editor.layoutIndex = layoutIndex()
		editor.leftPadding, editor.topPadding = 8, 8;
		editor:SetData(info.get())
		info.editor = editor;

		local left, right = math.huge, 0;
		for i, control in ipairs(self.EditorControls) do
			local button = self.cmdButtonPool:Acquire()
			button:SetPoint('RIGHT', header, 'RIGHT', -(32 * (i - 1)), 0)
			button:Setup(control, info)
			button:SetFrameLevel(header:GetFrameLevel() + 1)
			button:Show()
			left, right = math.min(left, button:GetLeft()), math.max(right, button:GetRight())
		end
		header:SetIndentation(-(right - left))
	end

	DrawEditor(self.Headers.Visibility)
	DrawEditor(self.Headers.Condition)
	DrawEditor(self.Headers.Response)
end

env.SharedConfig.Advanced = Advanced;