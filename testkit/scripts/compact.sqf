_fileName = "mission.sqf"; // Name of file to convert

private ["_compact","_fileName","_heightLand","_heightSea","_pos","_type"];
if ((preprocessFileLineNumbers _fileName) != "") then {
	outPutObjects = format["
Begin objects output for file: %1",_fileName];
	outPutUnits = format["
Begin units output for file: %1",_fileName];
	bigObjectArray = [];
	call compile preProcessFileLineNumbers _fileName;
	{
		_heightLand = getPosATL _x;
		_heightSea = getPosASL _x;
		_pos = getPos _x;
		if (surfaceIsWater _pos) then {_pos set [2,(_heightSea select 2)];} else {_pos set [2,(_heightLand select 2)];};
		_type = typeOf _x;
		_compact = [];
		_compact set [0,_type];
		_compact set [1,_pos];
		_compact set [2,getDir _x];
		if (_type isKindOf "Man") then {
			outPutUnits = outPutUnits +  ",
	" + str(_compact);		
		} else {
			outPutObjects = outPutObjects +  ",
	" + str(_compact);
		};
	} count bigObjectArray;
	{deleteVehicle _x;} count bigObjectArray;
	outPutObjects = outPutObjects +  format["
End objects output for file: %1
",_fileName];
	outPutUnits = outPutUnits +  format["
End units output for file: %1
",_fileName];
	profileNamespace setVariable["objectsArrayOutput",outPutObjects];
	profileNamespace setVariable["unitsArrayOutput",outPutUnits];
	saveProfileNamespace;
	cutText ["Output to ArmAProfile file complete","PLAIN",3];
	systemChat "Output to ArmAProfile file complete";
} else {
	cutText ["File name incorrect","PLAIN",3];
	systemChat "File name incorrect";
};
