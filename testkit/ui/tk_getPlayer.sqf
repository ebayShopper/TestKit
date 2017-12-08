private ["_index","_player","_uid"];

_index = lbCurSel 292904;
_uid = if (_index < 1) then {"0"} else {lbData [292904,_index]};

_player = cameraOn;
{
	if (_uid == getPlayerUID _x) exitWith {
		_player = _x;
	};
} count allUnits;

_player