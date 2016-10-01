if (vehicle player != player) exitWith {};
private ["_direction","_position"];

_direction = direction player;
_position = getPos player;
_position = [
	(_position select 0) + 4 * (sin _direction),
	(_position select 1) + 4 * (cos _direction),
	(_position select 2)
];
player setPos _position;