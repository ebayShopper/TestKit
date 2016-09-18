#include "colors.hpp"
private ["_bigList","_codeBox","_codeText","_display","_smallList","_statsText","_topBar","_viewing"];
disableSerialization;

createDialog "RscFunctionsViewer";
_display = findDisplay 2929;
_bigList = _display displayCtrl 292901;
_smallList = _display displayCtrl 292904;
_topBar = _display displayCtrl 292905;
_codeText = _display displayCtrl 292906;
_statsText = _display displayCtrl 292907;
_codeBox = _display displayCtrl 292908;
{ctrlShow [_x,false];} count [292902,292903,292909,292910,292911];

_bigList ctrlSetPosition [.03,.44,.48,.48]; //.48h optimal
_bigList ctrlCommit 0;
_smallList ctrlSetPosition [.03,.1,.48,.28]; //.28h optimal
_smallList ctrlCommit 0;
_topBar ctrlSetBackgroundColor GREEN;
_topBar ctrlSetPosition [0,0,1,.045];
_topBar ctrlSetText "";
_topBar ctrlCommit 0;

_codeText ctrlSetPosition [.55,.65,.19,.05];
_codeText ctrlSetText "Enter code to run:";
_codeText ctrlSetTextColor GREY;
_codeText ctrlCommit 0;
_codeBox ctrlSetEventHandler ["KeyDown","
	if (_this select 1 == 0x1C) then {
		call compile ('[] spawn {' + ctrlText (_this select 0) + '};');
		systemChat 'Code executed';
	};
"];
_codeBox ctrlSetFontHeight .03;
_codeBox ctrlSetPosition [.55,.7,.42,.222];
_codeBox ctrlCommit 0;

_statsText ctrlSetFontHeight .03;
_statsText ctrlSetPosition [.55,.1,.42,.542];
_statsText ctrlSetTextColor GREY;
_statsText ctrlCommit 0;

_viewing = tk_infoTextOn;
[tk_infoTextOn,false] call tk_scriptToggle;
tk_infoTextOn = "none";
[0,"Stats"] call tk_infoText;

"Scripts" call tk_fillBigList;
_viewing call tk_fillSmallList;