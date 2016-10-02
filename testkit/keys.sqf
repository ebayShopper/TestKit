#include "\ca\editor\Data\Scripts\dikCodes.h"

keyboard_keys set [DIK_GRAVE,{
	private "_display";
	disableSerialization;
	_display = findDisplay 2929;
	if (!isNull _display) then {
		_display closeDisplay 2;
	} else {
		call tk_open;
	};
	_handled = true
}];
keyboard_keys set [DIK_DELETE,{call tk_delete}];
keyboard_keys set [DIK_5,{call tk_fastForward; _handled = true}];
keyboard_keys set [DIK_6,{call tk_fastUp; _handled = true}];
keyboard_keys set [DIK_F8,{call compile preprocessFileLineNumbers "testkit\test.sqf"; _handled = true}];
keyboard_keys set [DIK_U,{call tk_unlock; _handled = true}];

if (tk_editorMode) then {
	(findDisplay 128) displayAddEventHandler ["KeyDown","
		_handled = false;
		_code = keyboard_keys select (_this select 1);
		if (!isNil '_code') then {call _code;};
		_handled
	"];
};