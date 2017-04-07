/*
	Use to obtain coordinates for waterHoleProxy.
	https://github.com/DayZMod/DayZ/tree/Development/SQF/dayz_code/system/mission/[MapName]/waterHoleProxy.sqf
	
	Non-ambient wells and ponds with classnames should be added to water sources instead:
	https://github.com/DayZMod/DayZ/blob/Development/SQF/dayz_code/Configs/CfgVehicles/Buildings/WaterSources.hpp
*/
#define CENTER getMarkerPos "center"
#define RADIUS ((getMarkerSize "center") select 1)*2
#define IS_WATER_HOLE typeOf _x == "" && (["_well",str _x] call fnc_inString or (["pond",str _x] call fnc_inString))

private ["_codeBox","_object","_return"];

if (typeName _this == "SCALAR") then {
	//Get all waterHoles on map, freezes game and may take up to 20 minutes to finish
	_return = format["
Begin waterHoleProxy output for map: %1,
",worldName];
	
	//Clear all non-ambient objects first to speed up loop
	{deleteVehicle _x} count (entities "All");
	
	{
		if (IS_WATER_HOLE) then {
			_return = _return + format["
	%1, // [%2] %3",["WaterHoleProxy",(getPosATL _x),0],_x,mapGridPosition _x];
		};
	//} count nearestObjects [CENTER,[],RADIUS];
	} count (CENTER nearObjects RADIUS);
	
	_return = _return + format["
End waterHoleProxy output for map: %1
",worldName];

	profileNamespace setVariable ["waterHoleProxy",_return];
	saveProfileNamespace;
	systemChat "Output to ArmAProfile file complete";
	systemChat "Be sure to clear profile file later to prevent slow game loading";
} else {
	//Get single closest waterhole
	_return = [];
	_object = objNull;
	{
		if (IS_WATER_HOLE) exitWith {
			_return = getPosATL _x;
			_object = _x;
		};
	} count nearestObjects [player,[],50];

	_return = format["Pos:%1 Object:%2 Grid:%3",_return,_object,mapGridPosition _return];
	
	disableSerialization;
	_codeBox = findDisplay 2929 displayCtrl 292908;
	_codeBox ctrlSetText _return;

	diag_log _return;
	systemChat _return;
	systemChat "Logged to client RPT";
};