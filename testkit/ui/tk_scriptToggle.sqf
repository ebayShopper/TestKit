#include "colors.hpp"
private ["_index","_list","_params","_script","_scriptName","_status"];

_scriptName = _this select 0;
_status = _this select 1;
_list = if (_status) then {["ON",GREEN]} else {["OFF",GREY]};

_index = -1;
{
	if (_x select 0 == _scriptName) exitWith {
		_index = _forEachIndex;
		_script = _x;
	}; 
} forEach tk_scriptList;

if (_index > -1) then {
	// Script
	_params = if (count _script > 2) then {_script select 2} else {0};
	tk_scriptList set [_index, [_script select 0,_script select 1,_params,_status] ];
	
	lbSetColor [292901,_index,_list select 1];
	if (_index < 24) then {
		systemChat format["%1 %2",_scriptName,_list select 0];
	};
} else {
	// Player
	for "_i" from 1 to (lbSize 292904)-1 do {
		if (_scriptName == lbText [292904,_i]) exitWith {
			lbSetColor [292904,_i,_list select 1];
			lbSetCurSel [292904,_i];
		};
	};
};