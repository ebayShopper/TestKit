#include "colors.hpp"
private ["_index","_name","_smallList","_viewing"];

_viewing = _this;
disableSerialization;
_smallList = findDisplay 2929 displayCtrl 292904;
lbClear _smallList;

_smallList lbAdd "";
_smallList ctrlSetEventHandler ["LBDblClick","
	if (_this select 1 < 1) exitWith {};
	
	private ['_player','_text'];
	
	_text = (_this select 0) lbText (_this select 1);
	_player = call tk_getPlayer;
	
	if (_player == player) then {
		[0,'Stats'] call tk_infoText;
	} else {
		[_player,_text] call tk_infoText;
	};
	(vehicle _player) switchCamera 'EXTERNAL';
	systemChat format['Viewing %1',_text];
"];

{
	if (isPlayer _x) then {
		_name = format ["%1 (%2)",name _x,getPlayerUID _x];
		_index = _smallList lbAdd _name;
		_smallList lbSetData [_index,getPlayerUID _x];
		
		if (_name == _viewing) then {
			_smallList lbSetColor [_index,GREEN];
			[_x,_viewing] call tk_infoText;
		} else {
			_smallList lbSetColor [_index,GREY];
		};
	};
} count allUnits;