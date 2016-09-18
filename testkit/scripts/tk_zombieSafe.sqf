tk_zombieSafeOn = !tk_zombieSafeOn;

if (tk_zombieSafeOn) then {
	["Zombie safe",true] call tk_scriptToggle;
	player_zombieCheckOriginal = player_zombieCheck;
	player_zombieCheck = {false};
} else {
	["Zombie safe",false] call tk_scriptToggle;
	player_zombieCheck = player_zombieCheckOriginal;
};