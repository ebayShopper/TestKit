tk_zombieFreeOn = !tk_zombieFreeOn;

if (tk_zombieFreeOn) then {
	["Zombie free",true] call tk_scriptToggle;
	
	[] spawn {
		while {tk_zombieFreeOn} do {
			{deleteVehicle _x} count (vehicle player nearEntities ["zZombie_Base",100]);
			uiSleep 2;
		};
	};
} else {
	["Zombie free",false] call tk_scriptToggle;
};