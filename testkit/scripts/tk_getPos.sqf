private ["_codeBox","_position"];

_position = format ["PLAYER - Dir: %1 Pos: %2 PosASL: %3 PosATL: %4",
	getDir player,
	getPos player,
	getPosASL player,
	getPosATL player
];

disableSerialization;
_codeBox = findDisplay 2929 displayCtrl 292908;
_codeBox ctrlSetText _position;

diag_log _position;
systemChat "Logged to client RPT";