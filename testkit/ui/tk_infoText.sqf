private ["_player","_statsText","_type"];

disableSerialization;
_player = _this select 0;
_type = _this select 1;
_statsText = findDisplay 2929 displayCtrl 292907;

if (_type != tk_infoTextOn) then {
	[_type,true] call tk_scriptToggle;
	[tk_infoTextOn,false] call tk_scriptToggle;
	tk_infoTextOn = _type;
	
	_statsText ctrlSetText (switch _type do {
		case "Stats": {
			#include "text_stats.sqf"
		};
		case "Show hotkeys": {
			#include "text_hotkeys.sqf"
		};
		case "Show helper functions": {
			#include "text_helpers.sqf"
		};
		case "Show server commands": {
			#include "text_commands.sqf"
		};
		default {
			#include "text_player.sqf"
		};
	});
} else {
	if (_type != "Stats") then {
		[0,"Stats"] call tk_infoText;
	};
};