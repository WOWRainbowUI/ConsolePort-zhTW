-- Consts
local MOTION_SICKNESS_CHARACTER_CENTERED = MOTION_SICKNESS_CHARACTER_CENTERED or '讓角色保持置中';
local MOTION_SICKNESS_REDUCE_CAMERA_MOTION = MOTION_SICKNESS_REDUCE_CAMERA_MOTION or '減少鏡頭動作';
local SOFT_TARGET_DEVICE_OPTS = {[0] = OFF, [1] = 'Gamepad', [2] = 'KBM', [3] = ALWAYS};
local SOFT_TARGET_ARC_ALLOWANCE = {[0] = 'Front', [1] = 'Cone', [2] = 'Around'};
local unpack, _, db = unpack, ...; local Console = {}; db('Data')();
------------------------------------------------------------------------------------------------------------
-- Blizzard console variables
------------------------------------------------------------------------------------------------------------
db:Register('Console', setmetatable({
	--------------------------------------------------------------------------------------------------------
	Emulation = {
	--------------------------------------------------------------------------------------------------------
		{	cvar = 'GamePadEmulateShift';
			type = Button;
			name = '模擬 Shift';
			desc = '要用來模擬 Shift 鍵的按鈕，按住這個按鈕會切換快捷列。';
			note = '建議作為主要的輔助鍵。';
		};
		{	cvar = 'GamePadEmulateCtrl';
			type = Button;
			name = '模擬 Ctrl';
			desc = '要用來模擬 Ctrl 鍵的按鈕，按住這個按鈕會切換快捷列。';
			note = '建議作為次要的輔助鍵。';
		};
		{ 	cvar = 'GamePadEmulateAlt';
			type = Button;
			name = '模擬 Alt';
			desc = '要模擬 Alt 鍵的按鈕。';
			note = '只建議超級玩家使用。';
		};
		{	cvar = 'GamePadCursorLeftClick';
			type = Button;
			name = KEY_BUTTON1;
			desc = '控制滑鼠游標時，要用來模擬左鍵點擊的按鈕。';
			note = '當游標固定在中心點或隱藏時，按下此按鈕則會變成自由移動滑鼠游標。';
		};
		{	cvar = 'GamePadCursorRightClick';
			type = Button;
			name = KEY_BUTTON2;
			desc = '控制滑鼠游標時，要用來模擬右鍵點擊的按鈕。';
			note = '固定在中心點的位置，用來與遊戲世界互動，';
		};
		{	cvar = 'GamePadEmulateTapWindowMs';
			type = Number(350, 25);
			name = '模擬的輔助鍵點選視窗';
			desc = '在時間內按下和放開模擬輔助鍵的按鈕會立刻觸發綁定的功能。';
			note = '以毫秒為單位。任何輔助鍵和按鈕一起按的話會取消這個效果。';
		};
	};
	--------------------------------------------------------------------------------------------------------
	Cursor = {
	--------------------------------------------------------------------------------------------------------
		{	cvar = 'interactOnLeftClick';
			type = Bool(false);
			name = INTERACT_ON_LEFT_CLICK_TEXT;
			desc = OPTION_TOOLTIP_INTERACT_ON_LEFT_CLICK;
			note = '會同時影響滑鼠和搖桿。';
		};
		{	cvar = 'GamePadCursorAutoDisableJump';
			type = Bool(true);
			name = '跳躍時隱藏游標';
			desc = '跳躍時停用自由移動滑鼠游標。';
		};
		{	cvar = 'GamePadCursorAutoDisableSticks';
			type = Map(2, {[0] = NONE, [1] = TUTORIAL_TITLE2, [2] = STATUS_TEXT_BOTH});
			name = '移動搖桿時隱藏游標';
			desc = '使用搖桿時停用自由移動滑鼠游標。';
			note = '設為兩者時，只有兩個搖桿一起使用才會停用游標。';
		};
		{	cvar = 'CursorCenteredYPos';
			type = Range(0.6, 0.025, 0, 1);
			name = '游標中心點位置';
			desc = '置中的游標和選取目標的垂直位置，以畫面高度為比例。';
		};
		{	cvar = 'GamePadCursorSpeedStart';
			type = Number(0.1, 0.05);
			name = '游標起始速度';
			desc = '游標開始移動時的速度。';
		};
		{	cvar = 'GamePadCursorSpeedAccel';
			type = Number(2, 0.1);
			name = '游標加速度';
			desc = '游標持續移動時，每秒的加速度。';
		};
		{	cvar = 'GamePadCursorSpeedMax';
			type = Number(1, 0.1);
			name = '游標最大速度';
			desc = '游標移動的最高速度。';
		};
	};
	--------------------------------------------------------------------------------------------------------
	Controls = {
	--------------------------------------------------------------------------------------------------------
		{	cvar = 'GamePadAnalogMovement';
			type = Bool(true);
			name = '類比移動';
			desc = '根據搖桿的角度做類比式的連續移動。';
			note = '停用此選項來使用傳統的分散式移動控制。';
		};
		{	cvar = 'GamePadFaceMovementMaxAngle';
			type = Range(115, 5, 0, 180);
			name = '面向搖桿移動最大角度';
			desc = '控制角色何時要從面向前方變成面向搖桿移動的方向，這是與正前方相差的角度。';
			note = '設為 0 時，會永遠面向搖桿移動的方向。\n設為最大值時，永遠不會面向搖桿移動的方向。';
		};
		{	cvar = 'GamePadFaceMovementMaxAngleCombat';
			type = Range(115, 5, 0, 180);
			name = '面向搖桿移動最大角度 (戰鬥)';
			desc = '控制戰鬥中，角色何時要從面向前方變成面向搖桿移動的方向，這是與正前方相差的角度。';
			note = '設為 0 時，會永遠面向搖桿移動的方向。\n設為最大值時，永遠不會面向搖桿移動的方向。';
		};
		{	cvar = 'GamePadRunThreshold';
			type = Range(0.5, 0.1, 0, 1);
			name = '跑步 / 走路的分界點';
			desc = '搖桿要移動多少才會從走路變成跑步。';
		};
		{	cvar = 'GamePadTurnWithCamera';
			type = Map(2, {[0] = NEVER, [1] = '戰鬥中', [2] = ALWAYS});
			name = '角色隨鏡頭轉動';
			desc = '轉動鏡頭角度時，也要轉動角色的面向。';
		};
	};
	--------------------------------------------------------------------------------------------------------
	Camera = {
	--------------------------------------------------------------------------------------------------------
		{	cvar = 'CameraKeepCharacterCentered';
			type = Bool(true);
			name = MOTION_SICKNESS_CHARACTER_CENTERED;
			desc = '角色保持在正中間，避免移動時頭暈。';
		};
		{	cvar = 'CameraReduceUnexpectedMovement';
			type = Bool(true);
			name = MOTION_SICKNESS_REDUCE_CAMERA_MOTION;
			desc = '減少非預期的鏡頭移動，避免移動時頭暈。';
		};
		{	cvar = 'test_cameraDynamicPitch';
			type = Bool(false);
			name = '動態上下旋轉';
			desc = '畫面拉遠時鏡頭往上。';
			note = ('和 "%s" 不相容。'):format(MOTION_SICKNESS_CHARACTER_CENTERED);
		};
		{	cvar = 'test_cameraOverShoulder';
			type = Range(0, 0.5, -1.0, 1.0);
			name = '過肩鏡頭';
			desc = '鏡頭與角色稍微有些水平方向的偏移，更像電影的感覺。';
			note = ('和 "%s" 不相容。'):format(MOTION_SICKNESS_CHARACTER_CENTERED);
		};
		{	cvar = 'CameraFollowOnStick';
			type = Bool(false);
			name = '鏡頭跟隨搖桿 (FOAS)';
			desc = '自動調整鏡頭，讓你只要使用單一搖桿就能控制移動。';
			note = ('|T%s:128:128:0|t'):format([[Interface\AddOns\ConsolePort_Config\Assets\jose.blp]]);
		};
		{	cvar = 'CameraFollowGamepadAdjustDelay';
			type = Number(1, 0.25);
			name = 'FOAS 調整延遲';
			desc = '停止的鏡頭要延遲幾秒才會開始調整角度。';
		};
		{	cvar = 'CameraFollowGamepadAdjustEaseIn';
			type = Number(1, 0.25);
			name = 'FOAS 調整淡入';
			desc = '鏡頭從停止轉換成自動調整 (FOAS) 所花的時間。';
		};
		{
			cvar = 'GamePadCameraLookMaxYaw';
			type = Range(0, 15, -180, 180);
			name = '鏡頭視角左右旋轉最大值';
			desc = '鏡頭 "視角" 功能左右旋轉調整的最大值。';
			note = '鏡頭視角是指依據當前的類比輸入暫時轉動鏡頭。';
		};
		{
			cvar = 'GamePadCameraLookMaxPitch';
			type = Range(0, 5, 0, 90);
			name = '鏡頭視角上下旋轉最大值';
			desc = '鏡頭 "視角" 功能下上旋轉調整的最大值。';
			note = '鏡頭視角是指依據當前的類比輸入暫時轉動鏡頭。';
		};
		{	cvar = 'GamePadCameraYawSpeed';
			type = Range(1, 0.25, -4.0, 4.0);
			name = '鏡頭左右旋轉速度';
			desc = '鏡頭的水平旋轉速度 - 往左/右轉。';
			note = '輸入負數會反轉軸。';
		};
		{	cvar = 'GamePadCameraPitchSpeed';
			type = Range(1, 0.25, -4.0, 4.0);
			name = '鏡頭上下旋轉速度';
			desc = '鏡頭的垂直旋轉速度 - 往上/下轉。';
			note = '輸入負數會反轉軸。';
		};
	};
	--------------------------------------------------------------------------------------------------------
	System = {
	--------------------------------------------------------------------------------------------------------
		{	cvar = 'synchronizeSettings';
			type = Bool(true);
			name = '同步設定';
			desc = '是否要將本機的遊戲設定儲存到伺服器。';
			note = '這會同時同步按鈕綁定、設定選項和巨集。';
		};
		{	cvar = 'synchronizeBindings';
			type = Bool(true);
			name = '同步按鈕綁定';
			desc = '是否要將本機的按鈕綁定儲存到伺服器。';
		};
		{	cvar = 'synchronizeConfig';
			type = Bool(true);
			name = '同步選項';
			desc = '是否要將角色專用和帳號共用的變數儲存到伺服器。';
		};
		{	cvar = 'synchronizeMacros';
			type = Bool(true);
			name = '同步巨集';
			desc = '是否要將本機的巨集設定儲存到伺服器。';
		};
		{	cvar = 'GamePadUseWinRTForXbox';
			type = Bool(true);
			name = '使用 WinRT 搖桿對映 (Xbox)';
			desc = '使用 Microsoft API 將 Xbox 控制器對映至遊戲。';
			note = '移動或按鈕綁定有問題時，請停用此選項。';
		};
		{	cvar = 'GamePadEmulateEsc';
			type = Button;
			name = '模擬 Esc';
			desc = '要用來模擬 Esc 鍵的按鈕。';
			note = '綁定切換顯示遊戲選單便可替換這個按鍵，使用 ConsolePort 時可以不需要模擬這個按鈕。';
		};
		{	cvar = 'GamePadOverlapMouseMs';
			type = Number(2000, 100);
			name = '不同輸入方式的重疊時間';
			desc = '同時使用搖桿和滑鼠時，從一個切換到另一個之前的持續時間。以毫秒為單位。';
		};
	};
	--------------------------------------------------------------------------------------------------------
	Interact = {
	--------------------------------------------------------------------------------------------------------
		{	cvar = 'SoftTargetInteract';
			type = Map(0, SOFT_TARGET_DEVICE_OPTS);
			name = '啟用互動鍵';
			desc = '啟用互動鍵來與遊戲世界中的物件和生物互動。';
			note = ('與當前目標互動時，請使用 %s 所綁定的按鈕。'):format(BLUE_FONT_COLOR:WrapTextInColorCode(BINDING_NAME_INTERACTTARGET));
		};
		{	cvar = 'SoftTargetInteractArc';
			type = Map(0, SOFT_TARGET_ARC_ALLOWANCE);
			name = '互動範圍';
			desc = '互動鍵尋找合適的互動目標的區域。';
		};
		{	cvar = 'SoftTargetInteractRange';
			type = Range(10, 1, 1, 45);
			name = '目標範圍';
			desc = '控制尋找互動目標或物件的距離範圍。';
			note = '不影響與目標互動的實際能力，可能有不同的範圍。';
		};
		{	cvar = 'SoftTargetInteractRangeIsHard';
			type = Bool(false);
			name = '強制目標範圍';
			desc = '設定是否要強制設置目標範圍，就算你能與之互動，也必須在這個範圍內。';
		};
		{	cvar = 'SoftTargetIconInteract';
			type = Bool(true);
			name = '顯示目標圖示';
			desc = '在當前互動目標上方顯示圖示。';
		};
		{	cvar = 'SoftTargetIconGameObject';
			type = Bool(true);
			name = '顯示物件圖示';
			desc = '在當前互動物件上方顯示圖示。';
		};
		{	cvar = 'SoftTargetTooltipInteract';
			type = Bool(false);
			name = '顯示浮動提示資訊';
			desc = '顯示可互動對象的浮動提示資訊。';
		};
	};
	--------------------------------------------------------------------------------------------------------
	Targeting = {
	--------------------------------------------------------------------------------------------------------
		{	cvar = 'SoftTargetEnemy';
			type = Map(0, SOFT_TARGET_DEVICE_OPTS);
			name = '啟用軟選取目標 (敵方)';
			desc = '只要看到敵人就自動選取為目標。';
			note = '按下選取目標的按鈕後，可將軟選取變為硬選取。';
		};
		{	cvar = 'SoftTargetFriend';
			type = Map(0, SOFT_TARGET_DEVICE_OPTS);
			name = '啟用軟選取目標 (友方)';
			desc = '只要看到友方就自動選取為目標。';
			note = '硬選取敵方目標的同時，也可以軟選取友方目標。';
		};
		{	cvar = 'SoftTargetForce';
			type = Map(0, {[0] = OFF, [1] = ENEMY, [2] = FRIEND});
			name = '強制硬選取';
			desc = '將軟選取的目標自動設為當前目標。';
		};
		{	cvar = 'SoftTargetMatchLocked';
			type = Map(0, {[0] = OFF, [1] = '明確的', [2] = '隱含的'});
			name = '鎖定目標';
			desc = '依據選擇的模式來鎖定軟目標。';
			note = '明確的只會鎖定硬選取的目標，隱含的會包含你攻擊的對象。';
		};
		{	cvar = 'SoftTargetNameplateEnemy';
			type = Bool(true);
			name = '顯示軟選取的敵方名條';
			desc = '總是顯示軟選取敵方目標的名條。';
		};
		{	cvar = 'SoftTargetNameplateFriend';
			type = Bool(false);
			name = '顯示軟選取的友方名條';
			desc = '總是顯示軟選取友方目標的名條。';
		};
		{	cvar = 'SoftTargetIconEnemy';
			type = Bool(false);
			name = '顯示敵方目標圖示';
			desc = '在當前敵方軟選取目標的上方顯示圖示。';
		};
		{	cvar = 'SoftTargetIconFriend';
			type = Bool(false);
			name = '顯示友方目標圖示';
			desc = '在當前友方軟選取目標的上方顯示圖示。';
		};
		{	cvar = 'SoftTargetTooltipEnemy';
			type = Bool(false);
			name = '顯示敵方浮動提示資訊';
			desc = '顯示敵方軟選取目標的浮動提示資訊。';
		};
		{	cvar = 'SoftTargetTooltipFriend';
			type = Bool(false);
			name = '顯示友方浮動提示資訊';
			desc = '顯示友方軟選取目標的浮動提示資訊。';
		};
	};
	--------------------------------------------------------------------------------------------------------
	Tooltips = {
	--------------------------------------------------------------------------------------------------------
		{	cvar = 'SoftTargetTooltipDurationMs';
			type = Number(2000, 250, true);
			name = '自動浮動提示資訊持續時間';
			desc = '自動取得目標的浮動提示資訊要顯示多久，以毫秒為單位。';
		};
		{	cvar = 'SoftTargetTooltipLocked';
			type = Bool(false);
			name = '鎖定自動浮動提示資訊';
			desc = '只要目標還存在，自動取得目標的浮動提示資訊會一直顯示。';
		};
	};
	--------------------------------------------------------------------------------------------------------
	Touchpad = {
	--------------------------------------------------------------------------------------------------------
		{	cvar = 'GamePadTouchCursorEnable';
			type = Bool(false);
			name = '使用觸控板游標';
			desc = '允許使用觸控板來控制游標移動。';
		};
		{	cvar = 'GamePadTouchCursorMoveThreshold';
			type = Number(0.042, 0.002, true);
			name = '游標移動臨界值';
			desc = '請在使用觸控板移動游標之前更改。';
			note = '數值愈大愈容易點選。';
		};
		{	cvar = 'GamePadTouchCursorAccel';
			type = Number(1.0, 0.25, true);
			name = '游標加速度';
			desc = '觸控板控制的游標加速度。';
		};
		{	cvar = 'GamePadTouchCursorSpeed';
			type = Number(1.0, 0.25, true);
			name = '游標速度';
			desc = '觸控板控制的游標速度。';
		};
		{	cvar = 'GamePadTouchTapButtons';
			type = Bool(false);
			name = '點選按鈕';
			desc = '啟用點選來按下板控制按鈕。';
			note = '啟用時，點選會被視為按下按鈕。';
		};
		{	cvar = 'GamePadTouchTapMaxMs';
			type = Number(200, 50, true);
			name = '點選時間最大值';
			desc = '視為點選/點一下的最長時間，以毫秒為單位。';
		};
		{	cvar = 'GamePadTouchTapOnlyClick';
			type = Bool(false);
			name = '點選只是點一下';
			desc = '點選只視為游標點一下，不是按下。';
			note = '停用時，按下按鈕也會視為游標點一下。';
		};
		{	cvar = 'GamePadTouchTapRightClick';
			type = Bool(false);
			name = '右鍵點選';
			desc = '點選的游標點一下為點右鍵，而不是左鍵。';
		};
	};
}, {
	__index = Console;
}))

function Console:GetMetadata(key)
	for set, cvars in pairs(self) do
		for i, data in ipairs(cvars) do
			if (data.cvar == key) then
				return data;
			end
		end
	end
end

function Console:GetEmulationForButton(button)
	if (button == 'none') then return end
	for i, data in ipairs(self.Emulation) do
		if (GetCVar(data.cvar) == button) then
			return data;
		end
	end
end

--[[ unhandled:
	
	GamePadCursorCentering = "When using GamePad, center the cursor",
	GamePadCursorOnLogin = "Enable GamePad cursor control on login and character screens",
	GamePadCursorAutoEnable = "",

	GamePadCursorCenteredEmulation = "When cursor is centered for GamePad movement, also emulate mouse clicks",
	GamePadTankTurnSpeed = "If non-zero, character turns like a tank from GamePad movement",
	GamePadForceXInput = "Force game to use XInput, rather than a newer, more advanced api",
	GamePadSingleActiveID = "ID of single GamePad device to use. 0 = Use all devices' combined input",
	GamePadAbbreviatedBindingReverse = "Display main binding button first so it's visible even if truncated on action bar",
	GamePadListDevices = "List all connected GamePad devices in the console",
]]--