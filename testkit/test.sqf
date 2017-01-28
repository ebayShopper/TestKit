// Use F8 key to run this script.
#include "ui\text_scripts.sqf"

private ["_fnc_dump","_t1"];

_fnc_dump = {
	diag_log format["Test script finished. Code took %1 seconds to run",_this];
	systemChat format["Test script finished. Code took %1 seconds to run",_this];
};

systemChat "Test script started.";
_t1 = diag_tickTime;

//	CODE TO RUN START














//	CODE TO RUN FINISH

(diag_tickTime - _t1) call _fnc_dump;