private ["_option","_params"];

_params = _this select 0;
_option = _this select 1;

PVDZ_getTickTime = [getPlayerUID player,_params select 0,_params select 1,toArray (PVDZ_pass select 0)];
publicVariableServer "PVDZ_getTickTime";

systemChat format["Changing server to %1",_option];