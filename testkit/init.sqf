// Set 0 to allow teleport on your client. Set 1 to enable vanilla anticheat on your client.
dayz_antihack = 0; // Can be changed on the fly by relogging, regardless of init.sqf setting

#include "ui\colors.hpp"

if (!isNil "tk_scriptList") exitWith {systemChat "ERROR: TestKit reinitialized";};

tk_scriptList = [
	["",""],
	["Invulnerable","tk_invulnerable"],
	["Items box","tk_box"],
	["Mark animals","tk_mark","animals"],
	["Mark dead","tk_mark","dead"],
	["Mark events","tk_mark","events"],
	["Mark players","tk_mark","players"],
	["Mark plots","tk_mark","plots"],
	["Mark storage","tk_mark","storage"],
	["Mark vehicles","tk_mark","vehicles"],
	["Player icons","tk_playerIcons"],
	["Standard gear","tk_standardGear"],
	["Toggle teleport","tk_teleport"],
	["Zombie free","tk_zombieFree"],
	["Zombie safe","tk_zombieSafe"],
	["",""],
	["> Add backpack","tk_spawn"],
	["> Add magazine","tk_spawn"],
	["> Add weapon","tk_spawn"],
	["> Change clothes","tk_spawn"],
	["> Create vehicle","tk_spawn"],
	["",""],
	["BIS debug cam","tk_selectPlayer"],
	["Give meds","tk_selectPlayer"],
	["Refuel and repair","tk_selectPlayer"],
	["View gear","tk_selectPlayer"],
	["",""],
	["Daytime","tk_weather",[2,11]],
	["Nighttime","tk_weather",[2,23]],
	["Rainy weather","tk_weather",[3,1]],
	["Sunny weather","tk_weather",[3,0]],
	["",""],
	["Show hotkeys","tk_infoText"],
	["Show helper functions","tk_infoText"],
	["Show server commands","tk_infoText"]
];

// Scripts
tk_addMap = compile preprocessFileLineNumbers "testkit\scripts\tk_addMap.sqf";
tk_box = compile preprocessFileLineNumbers "testkit\scripts\tk_box.sqf";
tk_delete = compile preprocessFileLineNumbers "testkit\scripts\tk_delete.sqf";
tk_fastForward = compile preprocessFileLineNumbers "testkit\scripts\tk_fastForward.sqf";
tk_fastUp = compile preprocessFileLineNumbers "testkit\scripts\tk_fastUp.sqf";
tk_getPos = compile preprocessFileLineNumbers "testkit\scripts\tk_getPos.sqf";
tk_help = compile preprocessFileLineNumbers "testkit\scripts\tk_help.sqf";
tk_invulnerable = compile preprocessFileLineNumbers "testkit\scripts\tk_invulnerable.sqf";
tk_mark = compile preprocessFileLineNumbers "testkit\scripts\tk_mark.sqf";
tk_profileLog = compile preprocessFileLineNumbers "testkit\scripts\tk_profileLog.sqf";
tk_spawn = compile preprocessFileLineNumbers "testkit\scripts\tk_spawn.sqf";
tk_standardGear = compile preprocessFileLineNumbers "testkit\scripts\tk_standardGear.sqf";
tk_teleport = compile preprocessFileLineNumbers "testkit\scripts\tk_teleport.sqf";
tk_unlock = compile preprocessFileLineNumbers "testkit\scripts\tk_unlock.sqf";
tk_selectPlayer = compile preprocessFileLineNumbers "testkit\scripts\tk_selectPlayer.sqf";
tk_waitForObject = compile preprocessFileLineNumbers "testkit\scripts\tk_waitForObject.sqf";
tk_weather = compile preprocessFileLineNumbers "testkit\scripts\tk_weather.sqf";
tk_wipeGear = compile preprocessFileLineNumbers "testkit\scripts\tk_wipeGear.sqf";
tk_zombieFree = compile preprocessFileLineNumbers "testkit\scripts\tk_zombieFree.sqf";
tk_zombieSafe = compile preprocessFileLineNumbers "testkit\scripts\tk_zombieSafe.sqf";

// UI Functions
tk_fillBigList = compile preprocessFileLineNumbers "testkit\ui\tk_fillBigList.sqf";
tk_fillSmallList = compile preprocessFileLineNumbers "testkit\ui\tk_fillSmallList.sqf";
tk_getName = compile preprocessFileLineNumbers "testkit\ui\tk_getName.sqf";
tk_getPlayer = compile preprocessFileLineNumbers "testkit\ui\tk_getPlayer.sqf";
tk_infoText = compile preprocessFileLineNumbers "testkit\ui\tk_infoText.sqf";
tk_open = compile preprocessFileLineNumbers "testkit\ui\tk_ui.sqf";
tk_playerIcons = compile preprocessFileLineNumbers "testkit\ui\tk_playerIcons.sqf";
tk_runScript = compile preprocessFileLineNumbers "testkit\ui\tk_runScript.sqf";
tk_scriptToggle = compile preprocessFileLineNumbers "testkit\ui\tk_scriptToggle.sqf";

// Variables
tk_invulnerableOn = false;
tk_markAnimalsOn = false;
tk_markDeadOn = false;
tk_markEventsOn = false;
tk_markPlayersOn = false;
tk_markPlotsOn = false;
tk_markStorageOn = false;
tk_markVehiclesOn = false;
tk_playerIconsOn = false;
tk_teleportOn = false;
tk_zombieFreeOn = false;
tk_zombieSafeOn = false;
tk_editorMode = !isNull findDisplay 128;
tk_infoTextOn = "none";
tk_isEpoch = isClass (configFile >> "CfgWeapons" >> "Chainsaw");

if (tk_editorMode) then {
	BIS_fnc_findSafePos = compile preprocessFileLineNumbers "ca\modules\functions\misc\fn_findSafePos.sqf";
	BIS_fnc_help = compile preprocessFileLineNumbers "ca\modules\functions\misc\fn_help.sqf";
	dayz_classicBloodBagSystem = true;
	dayz_currentGlobalAnimals = 0;
	dayz_currentGlobalZombies = 0;
	dayz_maxGlobalAnimals = 0;
	dayz_maxGlobalZeds = 0;
	dayz_onBack = "";
	dayz_hunger = 0;
	dayz_thirst = 0;
	dayz_nutrition = 0;
	dayz_temperatur = 0;
	r_player_blood = 0;
	epoch_generateKey = {[0,0]};
	fnc_usec_damageHandler = {0};
	player_humanityMorph = {};
	player_zombieCheck = {};
	PVDZ_pass = ["none","none"];
};

[] spawn {
	if (tk_editorMode) then {
		Dayz_loginCompleted = true;
		keyboard_keys = [];
		keyboard_keys resize 256;
	};
	waitUntil {uiSleep 1;(!isNil "Dayz_loginCompleted" && !isNil "keyboard_keys")};
	uiSleep 2;
	systemChat "Tilde '~' to open testkit";
	execVM "testkit\keys.sqf";
};