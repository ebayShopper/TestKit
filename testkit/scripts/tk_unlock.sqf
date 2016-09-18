private ["_charID","_class","_config","_count","_info","_list","_name","_target","_type"];

_target = cursorTarget;
if (isNull _target) exitWith {systemChat "cursorTarget isNull!"};
_type = typeOf _target;
_charID = parseNumber (_target getVariable ["CharacterID","0"]);

_info = format ["%1 CharID:%2 ObjID:%3 ObjUID:%4 OwnerPUID:%5 DoorFriends:%6 PlotFriends:%7 Dir:%8 Pos:%9 PosASL:%10 PosATL:%11",
	_type,
	_charID,
	_target getVariable ["ObjectID","0"],
	_target getVariable ["ObjectUID","0"],
	_target getVariable ["ownerPUID","0"],
	_target getVariable ["doorfriends",[]],
	_target getVariable ["plotfriends",[]],
	getDir _target,
	getPos _target,
	getPosASL _target,
	getPosATL _target
];

diag_log _info;
systemChat _info;
systemChat "Logged to client RPT";
if (!tk_isEpoch) exitWith {};

if (locked _target) then {
	[0,0,0,[_target,"Hotkey"]] call compile preProcessFileLineNumbers "\z\addons\dayz_code\actions\unlock_veh.sqf";
};

if (_charID != 0 && (_type isKindOf "LandVehicle" or {_type isKindOf "Air"} or {_type isKindOf "Ship"})) then {
	_config = configFile >> "CfgWeapons";
	_count = 0;
	_list = [];
	_list resize (count _config);
	{
		_class = _config select _count;
		_count = _count + 1;
		_name = configName _class;
		if (isClass _class && {getNumber (_class >> "keyid") == _charID}) exitWith {
			if !(_name in weapons player) then {
				player addWeapon _name;
				systemChat "Key added to toolbelt";
			};
		};
	} count _list;
};