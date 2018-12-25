/*
	1. Put the file containing editor output in the main Arma game directory
	2. Update _fileName below
	3. In the file to compact replace all occurrences of:
		};
	with:
		bigObjectArray set [count bigObjectArray,_this];};
	There should only be one after each object.
	4. Run compact.sqf
*/

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
		_compact = [_type,_pos,(getDir _x)];
		if (_type isKindOf "Man") then {
			outPutUnits = outPutUnits + ",
	" + str(_compact);		
		} else {
			outPutObjects = outPutObjects + ",
	" + str(_compact);
		};
	} count bigObjectArray;
	{deleteVehicle _x;} count bigObjectArray;
	outPutObjects = outPutObjects + format["
End objects output for file: %1
",_fileName];
	outPutUnits = outPutUnits + format["
End units output for file: %1
",_fileName];
	profileNamespace setVariable["objectsArrayOutput",outPutObjects];
	profileNamespace setVariable["unitsArrayOutput",outPutUnits];
	saveProfileNamespace;
	systemChat "Output to ArmAProfile file complete";
} else {
	systemChat "File name incorrect";
};
