if (tk_editorMode) exitWith {"AmmoBoxBig" createVehicle (getPos player);};

private ["_near","_pos"];

systemChat "Creating box and adding items. Please wait..";
_near = player nearObjects ["AmmoBoxBig",50];
_pos = getPosATL player;
if (surfaceIsWater _pos) then {_pos = ATLToASL _pos;};
tk_doneSpawning = nil;
PVDZ_getTickTime = [getPlayerUID player,1,["AmmoBoxBig",_pos],toArray (PVDZ_pass select 0)];
publicVariableServer "PVDZ_getTickTime";

_near spawn {
	private ["_arrow","_box","_near","_startTime"];
	
	_near = _this;
	_startTime = diag_tickTime;
	
	waitUntil {
		uiSleep 1;
		(count (player nearObjects ["AmmoBoxBig",50]) != count _near or (diag_tickTime - _startTime > 15))
	};
	
	_box = objNull;
	{
		if !(_x in _near) exitWith {
			_box = _x;
		};
	} count (player nearObjects ["AmmoBoxBig",50]);
	
	_box hideObject true;
	_arrow = "Sign_arrow_down_large_EP1" createVehicleLocal [0,0,0];
	_arrow setPos (getPosATL _box);
	
	waitUntil {
		uiSleep .4;
		(!isNil "tk_doneSpawning")
	};
	
	deleteVehicle _arrow;
	_box hideObject false;
	player reveal _box;
	systemChat format["Completed adding items to box in %1 seconds",diag_tickTime - _startTime];
};