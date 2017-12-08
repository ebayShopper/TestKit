#include "colors.hpp"

tk_playerIconsOn = !tk_playerIconsOn;

if (tk_playerIconsOn) then {
	["Player icons",true] call tk_scriptToggle;
	
	setGroupIconsVisible [false,true];	
	[] spawn {
		private "_leader";
		while {tk_playerIconsOn} do {
			{
				_leader = leader _x;
				if (isPlayer _leader && player != _leader) then {
					if (count (_x getGroupIcon 1) < 1) then {_x addGroupIcon ["x_art",[0,0]];};
					_x setGroupIconParams [GREEN,format ["%1 %2m",(_leader call tk_getName),ceil (_leader distance player)],1,true];
				};
			} count allGroups;
			uiSleep 0.5;
		};
	};
} else {
	["Player icons",false] call tk_scriptToggle;
	setGroupIconsVisible [false,false];
};