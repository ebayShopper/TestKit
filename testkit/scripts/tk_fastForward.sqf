tk_fastForwardOn = !tk_fastForwardOn;

if (tk_fastForwardOn) then {
	["Fast forward",true] call tk_scriptToggle;
	
	tk_doFastForward = {
		if (vehicle player != player) exitWith {};
		private ["_direction","_position"];
		
		_direction = direction player;
		_position = getPos player;
		_position = [
			(_position select 0) + 4 * (sin _direction),
			(_position select 1) + 4 * (cos _direction),
			(_position select 2)
		];
		player setPos _position;
	};
} else {
	["Fast forward",false] call tk_scriptToggle;
	tk_doFastForward = {};
};