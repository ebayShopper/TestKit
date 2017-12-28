private ["_option","_player","_strH","_text","_vehicle"];

_option = _this select 1;
_player = _this select 2;
_vehicle = vehicle _player;
_text = format ["%1 (%2)",(_player call tk_getName),getPlayerUID _player];

switch _option do {
	case "BIS debug cam": {
		_vehicle exec "camera.sqs";
		systemChat format["Viewing: %1",_text];
		systemChat "WASD+LShift+QZ = move, NumPadArrows = tilt, NumPad+- = zoom, L = crosshair, N = NV, Click on map = TP, RMB = exit";
	};
	case "Give meds": {
		systemChat format["Gave meds to: %1",_text];
		if (player distance _player > 5 && _player getVariable ["NORRN_unconscious",false]) then {
			systemChat "You must be within 5m of player to give epinephrine";
		};
		PVDZ_getTickTime = [getPlayerUID player,4,_player,dayz_authKey];
		publicVariableServer "PVDZ_getTickTime";
	};
	case "Refuel and repair": {
		_vehicle setDamage 0;
		_vehicle setVectorUp [0,0,1];
		if (local _vehicle) then {
			[_vehicle,1] call local_setFuel;
		} else {
			PVDZ_send = [_vehicle,"SetFuel",[_vehicle,1]];
			publicVariableServer "PVDZ_send";
		};
		{
			if (([_vehicle,_x] call object_getHit) > 0) then {
				_vehicle setVariable [_strH,0,true];
			};
		} count (_vehicle call vehicle_getHitpoints);
		systemChat format["Refueled and repaired: %1's vehicle",_text];
	};
	case "View gear": {
		createGearDialog [_player,"RscDisplayGear"];
		systemChat format["Viewing: %1's gear",_text];
	};
};