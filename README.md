This is a UI for testing A2 Epoch and DayZ mod dev builds. It aims to be simple, light weight and minimally invasive.
* Built on Bohemia's functions viewer dialog
* Type and execute code directly in game
* Usable in the editor
* Compatible with vanilla anti-teleport
* Basic access control suitable for public test servers (depends on BattlEye enabled to be effective)

# Install:

**[>> Download <<](https://github.com/ebayShopper/TestKit/archive/master.zip)**

1. In mission\init.sqf find <code>execFSM "\z\addons\dayz_code\system\player_monitor.fsm";</code> Add directly above:

	```sqf
	"PVDZ_login" addPublicVariableEventHandler {call (_this select 1)};
	PVDZ_getTickTime = [getPlayerUID player];
	publicVariableServer "PVDZ_getTickTime";
	```

2. At the very top of <code>dayz_server\init\server_functions.sqf</code> add:

	```sqf
	#include "testkit.sqf"
	```

3. Put testkit.sqf and testkit_ac.sqf in the `dayz_server\init\` folder.
4. Edit the allowed UIDs at the top of testkit.sqf.
5. Put the testkit folder in your client `Arma 2 Operation Arrowhead` folder.

# Editor Usage:
1. Place a center, group and unit.
2. Set the unit to playable.
3. In the unit's init field enter `execVM "testkit\init.sqf"`
4. Optionally save the mission for easy loading next time.

# Legal:
This work is licensed under the DAYZ MOD LICENSE SHARE ALIKE (DML-SA). The full license is here:<br /> https://www.bistudio.com/community/licenses/dayz-mod-license-share-alike
