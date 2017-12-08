private "_display";
disableSerialization;
_display = findDisplay 12 displayCtrl 51;

call tk_addMap;
tk_teleportOn = !tk_teleportOn;

if (tk_teleportOn) then {
	tk_doTeleport = {
		private ["_height","_pos"];
		_height = if (vehicle player isKindOf "Air" && (getPosATL vehicle player) select 2 > 5) then {100} else {0.5};
		_pos = [_this select 0,_this select 1,_height];
		preloadCamera _pos;
		(vehicle player) setPos _pos;
		openMap [false,false];
		{player reveal _x} count (player nearEntities ["AllVehicles",100]);
	};
	
	["Toggle teleport",true] call tk_scriptToggle;
	_display ctrlSetEventHandler ["MouseButtonUp","
		if (_this select 6) then {(_this select 0 ctrlMapScreenToWorld [_this select 2,_this select 3]) call tk_doTeleport};
		true
	"];
} else {
	["Toggle teleport",false] call tk_scriptToggle;
	_display ctrlSetEventHandler ["MouseButtonUp","false"];
};