// Use F8 key to run this script.
private ["_fnc_dump","_t1"];

_fnc_dump = {
	diag_log format["Test script finished. Code took %1 seconds to run",_this];
	format["Test script finished. Code took %1 seconds to run",_this] call dayz_rollingMessages;
};

_t1 = diag_tickTime;

//	CODE TO RUN START














//	CODE TO RUN FINISH

(diag_tickTime - _t1) call _fnc_dump;