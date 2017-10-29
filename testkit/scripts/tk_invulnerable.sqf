{missionNamespace setVariable [_x,false]} count [
	"r_action","r_action_unload","r_doLoop","r_drag_sqf","r_fracture_arms","r_fracture_legs",
	"r_interrupt","r_player_cardiac","r_player_handler","r_player_infected","r_player_injured",
	"r_player_inpain","r_player_lowblood","r_player_unconscious",
	"r_player_unconsciousInProgress","r_player_unconsciousInputDisabled"
];

{
	if (player getVariable [_x,0] > 0) then {
		player setVariable [_x,0,true];
	};
} count ["hit_hands","hit_legs","unconsciousTime"];

{
	if (player getVariable [_x,false]) then {
		player setVariable [_x,false,true];
	};
} count [
	"NORRN_unconscious","USEC_infected","USEC_injured",
	"USEC_inPain","USEC_isCardiac","USEC_lowBlood"
];

dayz_hunger = 0;
dayz_thirst = 0;
dayz_temperatur = 36;
dayz_sourceBleeding = objNull;
r_player_timeout = 0;
player setHit ["body",0];
player setHit ["hands",0];
player setHit ["legs",0];
player setVariable ["medForceUpdate",true,true];
player setVariable ["messing",[dayz_hunger,dayz_thirst,dayz_nutrition],true];
player setVariable ["startcombattimer",0,false];
player setVariable ["USEC_BloodQty",12000,true];
"dynamicBlur" ppEffectAdjust [0]; 
"dynamicBlur" ppEffectCommit 5;
disableUserInput false;
resetCamShake;
0 fadeSound 1;

tk_invulnerableOn = !tk_invulnerableOn;

if (tk_invulnerableOn) then {
	["Invulnerable",true] call tk_scriptToggle;
	fnc_usec_damageHandlerOriginal = fnc_usec_damageHandler;
	[] spawn {
		while {tk_invulnerableOn} do {
			dayz_temperatur = 36;
			dayz_thirst = 0;
			fnc_usec_damageHandler = {0};
			r_player_blood = 12000;
			r_player_infected = false;
			r_player_inpain = false;
			player setVariable ["combattimeout",0,false];
			uiSleep 1;
		};
	};
} else {
	["Invulnerable",false] call tk_scriptToggle;
	fnc_usec_damageHandler = fnc_usec_damageHandlerOriginal;
};