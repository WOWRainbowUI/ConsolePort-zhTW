local __, db = ...; __ = 1; local Profile = {};
local kSelectAxisOptions = {
	LStickX = '左搖桿 X',
	LStickY = '左搖桿 Y',
	RStickX = '右搖桿 X',
	RStickY = '右搖桿 Y',
	LTrigger = '左板機',
	RTrigger = '右板機',
	GStickX = '陀螺儀 X',
	GStickY = '陀螺儀 Y',
	PStickX = '觸控板 X',
	PStickY = '觸控板 Y',
};
setfenv(__, setmetatable(db('Data'), {__index = _G}));
------------------------------------------------------------------------------------------------------------
-- Gamepad API profile values
------------------------------------------------------------------------------------------------------------
db:Register('Profile', CPAPI.Proxy({
	['移動輸入'] = {
		{	name = '移動盲區';
			path = 'stickConfigs/<stick:Movement>/deadzone';
			data = Range(0.25, 0.05, 0, 0.95);
			desc = '移動的 2D 盲區，同時考慮 X 和 Y 方向移動。';
			note = ('|T%s:128:128:0|t'):format([[Interface\AddOns\ConsolePort_Config\Assets\Deadzone2Da.blp]]);
		};
		{
			name = '移動 X 軸';
			path = 'stickConfigs/<stick:Movement>/axisX';
			data = Map('LStickX', kSelectAxisOptions);
			desc = '左/右移動的類比輸入。';
		};
		{
			name = '移動 Y 軸';
			path = 'stickConfigs/<stick:Movement>/axisY';
			data = Map('LStickY', kSelectAxisOptions);
			desc = '前/後移動的類比輸入。';
		};
	};
	['鏡頭輸入'] = {
		{	name = '鏡頭左右旋轉盲區';
			path = 'stickConfigs/<stick:Camera>/deadzoneX';
			data = Range(0.05, 0.05, 0, 0.95);
			desc = '僅用於鏡頭左右旋轉的盲區，在 2D 盲區之前套用。';
			note = ('|T%s:128:128:0|t'):format([[Interface\AddOns\ConsolePort_Config\Assets\DeadzoneXa.blp]]);
		};
		{	name = '鏡頭上下旋轉盲區';
			path = 'stickConfigs/<stick:Camera>/deadzoneY';
			data = Range(0.2, 0.05, 0, 0.95);
			desc = '僅用於鏡頭上下旋轉的盲區，在 2D 盲區之前套用。';
			note = ('|T%s:128:128:0|t'):format([[Interface\AddOns\ConsolePort_Config\Assets\DeadzoneYa.blp]]);
		};
		{	name = '鏡頭 2D 盲區';
			path = 'stickConfigs/<stick:Camera>/deadzone';
			data = Range(0.25, 0.05, 0, 0.95);
			desc = '鏡頭的 2D 盲區，同時考慮上下和左右旋轉移動。';
			note = ('|T%s:128:128:0|t'):format([[Interface\AddOns\ConsolePort_Config\Assets\Deadzone2Da.blp]]);
		};
		{
			name = '鏡頭左右旋轉軸';
			path = 'stickConfigs/<stick:Camera>/axisX';
			data = Map('RStickX', kSelectAxisOptions);
			desc = '鏡頭左/右旋轉的類比輸入。';
		};
		{
			name = '鏡頭上下旋轉軸';
			path = 'stickConfigs/<stick:Camera>/axisY';
			data = Map('RStickY', kSelectAxisOptions);
			desc = '鏡頭上/下旋轉的類比輸入。';
		};
		{
			name = '鏡頭視角左右旋轉軸';
			path = 'stickConfigs/<stick:Look>/axisX';
			data = Map('GStickX', kSelectAxisOptions);
			desc = '鏡頭 "視角" 功能左/右旋轉的類比輸入。';
			note = '鏡頭視角是指依據當前的類比輸入暫時轉動鏡頭。';
		};
		{
			name = '鏡頭視角上下旋轉軸';
			path = 'stickConfigs/<stick:Look>/axisY';
			data = Map('GStickY', kSelectAxisOptions);
			desc = '鏡頭 "視角" 功能上/下旋轉的類比輸入。';
			note = '鏡頭視角是指依據當前的類比輸入暫時轉動鏡頭。';
		};
	};
}, Profile))

function Profile:GetObject(path)
	for section, fields in pairs(self) do
		for i, field in ipairs(fields) do
			if ( field.path == path ) then
				return field, section, i;
			end
		end
	end
end

function Profile:GetConfiguredValue(path)
	local field = self:GetObject(path)
	if field then
		return field.data:Get()
	end
end