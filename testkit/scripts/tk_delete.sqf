private ["_objectID","_objectUID","_target"];

_target = cursorTarget;

if (isNull _target) then {
	systemChat "cursorTarget isNull!";
} else {
	_objectID = _target getVariable ["ObjectID","0"];
	_objectUID = _target getVariable ["ObjectUID","0"];

	if (_objectID != "0" or _objectUID != "0") then {
		PVDZ_obj_Destroy = [_objectID,_objectUID,player,_target,dayz_authKey];
		publicVariableServer "PVDZ_obj_Destroy";
	};
	
	deleteVehicle _target;
	systemChat format["Deleted: %1",typeOf _target];
};