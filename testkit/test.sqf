// Use F8 key to run this script.

private ["_fnc_dump","_t1"];

_fnc_dump = {
	diag_log format["Test script finished. Code took %1 seconds to run",_this];
	systemChat format["Test script finished. Code took %1 seconds to run",_this];
};

systemChat "Test script started.";
_t1 = diag_tickTime;

//	CODE TO RUN START






//player addEventHandler ["HandleDamage",{diag_log format["HandleDamage: Unit:%1 Hit:%2 Damage:%3 Source:%4 Ammo:%5",_this select 0,_this select 1,_this select 2,_this select 3,_this select 4];}];








//	CODE TO RUN FINISH

(diag_tickTime - _t1) call _fnc_dump;