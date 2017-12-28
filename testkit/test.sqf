// Use F8 key to run this script.
private ["_fnc_dump","_t1"];

_fnc_dump = {
	#define TK_LOG (localize "str_disp_intel_time" + format[" %1 - ",diag_tickTime] + format["Code took %1 seconds to run",_this])
	diag_log TK_LOG;
	systemChat TK_LOG;
};

_t1 = diag_tickTime;

//	CODE TO RUN START














//	CODE TO RUN FINISH

(diag_tickTime - _t1) call _fnc_dump;