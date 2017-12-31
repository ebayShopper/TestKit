if (!isNil "tk_editorKeyDown") then {
	(findDisplay 128) displayRemoveEventHandler ["KeyDown",tk_editorKeyDown];
};

tk_editorKeyDown = (findDisplay 128) displayAddEventHandler ["KeyDown","
	_handled = false;
	_code = keyboard_keys select (_this select 1);
	if (!isNil '_code') then {call _code;};
	_handled
"];