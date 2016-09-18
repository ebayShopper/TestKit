tk_fastUpOn = !tk_fastUpOn;

if (tk_fastUpOn) then {
	["Fast up",true] call tk_scriptToggle;
	
	tk_doFastUp = {
		private "_velocity";
		_velocity = velocity player;
		player setVelocity [_velocity select 0,_velocity select 1,4];
	};
} else {
	["Fast up",false] call tk_scriptToggle;
	tk_doFastUp = {};
};