/*
	Use to obtain coordinates for waterHoleProxy.
	https://github.com/DayZMod/DayZ/tree/Development/SQF/dayz_code/system/mission/[MapName]/waterHoleProxy.sqf
	
	Non-ambient wells and ponds with classnames should be added to water sources instead:
	https://github.com/DayZMod/DayZ/blob/Development/SQF/dayz_code/Configs/CfgVehicles/Buildings/WaterSources.hpp
	
	Usage:
	call tk_getWaterHole; //Get closest waterHole and log to client RPT
	800 call tk_getWaterHole; //Get all waterHoles in 800m radius and log to ArmAProfile file
*/
#define IS_WATER_HOLE typeOf _x == "" && (["_well",str _x] call fnc_inString or (["pond",str _x] call fnc_inString))

private ["_count","_list","_return"];
_return = [];

if (typeName _this == "SCALAR") then {
	//Get all waterHoles in radius, a large radius may freeze the game and take a long time to finish
	_list = nearestObjects [player,[],_this];
	_count = count _list;
	
	_return = format["
Begin waterHoleProxy output for %1,
",worldName];
	
	{
		if (IS_WATER_HOLE) then {
			_return = _return + format["
	%1, // [%2] %3",["WaterHoleProxy",(getPosATL _x),0],_x,mapGridPosition _x];
		};
		
		systemChat format["%1 / %2",_forEachIndex,_count];
	} forEach _list;
	
	_return = _return + format["
End waterHoleProxy output for %1
",worldName];

	profileNamespace setVariable ["waterHoleProxy",_return];
	saveProfileNamespace;
	systemChat "Output to ArmAProfile file complete";
} else {
	//Get single closest waterhole
	{
		if (IS_WATER_HOLE) exitWith {
			_return = format["
	%1, // [%2] %3
	",["WaterHoleProxy",(getPosATL _x),0],_x,mapGridPosition _x];
		};
	} forEach nearestObjects [player,[],50];

	diag_log _return;
	systemChat _return;
	systemChat "Logged to client RPT";
};