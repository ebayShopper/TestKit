private ["_function","_index","_params","_script"];

_index = lbCurSel 292901;
_function = call compile lbData [292901,_index];

_script = tk_scriptList select _index;
_params = if (count _script > 2) then {_script select 2} else {0};
[_params,_script select 0,(call tk_getPlayer)] call _function;