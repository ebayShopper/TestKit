#include "text_scripts.sqf"
#define CENTER getMarkerPos "center"
#define RADIUS ((getMarkerSize "center") select 1)*2

private ["_list","_script","_status","_type"];

_type = _this select 0;
_script = _this select 1;
_status = format ["tk_mark%1On",_type];

call compile format["%1 = !%1;",_status];
call tk_addMap;

if (call compile _status) then {
	[_script,true] call tk_scriptToggle;
	
	[_type,_status] spawn {
		private ["_class","_crew","_dead","_getCrew","_getDead","_getEvent","_list","_marker","_name","_status","_type"];
		
		_type = _this select 0;
		_status = _this select 1;
		_class = if (tk_isEpoch) then {"x_art"} else {"DestroyedVehicle"};
		_list = [{},{},[]];
		
		_getCrew = {
			_crew = [];
			if (isPlayer _this) then {
				{_crew set [count _crew,(_x call tk_getName)]} count crew _this;
				_crew = format ["%1%2",typeOf _this,_crew];
			} else {
				_crew = if (count crew _this > 0) then {""} else {typeOf _this};
			};
			_crew
		};
		_getDead = {
			_dead = [];
			{
				if (_x getVariable["bodyName",""] != "") then {
					_dead set [count _dead,_x];
				};
			} count allDead;
			_dead
		};
		_getEvent = {
			switch (typeOf _this) do {
				case "Misc_cargo_cont_net1";
				case "Misc_cargo_cont_net2";
				case "Misc_cargo_cont_net3": {"CarePackage"};
				case "Supply_Crate_DZE": {"SupplyCrate"};
				case "Gold_Vein_DZE": {"GoldVein"};
				case "Silver_Vein_DZE": {"SilverVein"};
				case "Iron_Vein_DZE": {"IronVein"};
				case "IC_Fireplace1": {"InfectedCamp"};
				case default {typeOf _this};
			};
		};
		
		while {call compile _status} do {
			if (visibleMap or !isNull (uiNamespace getVariable["BIS_RscMiniMap",displayNull])) then {
				_list = switch _type do {
					case "animals": {
						[{"Orange"},{typeOf _this},entities "Animal"]
					};
					case "dead": {
						[{"Red"},{_this getVariable["bodyName","unknown"]},(call _getDead)]
					};
					case "events": {
						[{"Pink"},{_this call _getEvent},nearestObjects [CENTER,["CrashSite","Misc_cargo_cont_net1","Misc_cargo_cont_net2","Misc_cargo_cont_net3","MiningItems","IC_Fireplace1"],RADIUS]]
					};
					case "players": {
						[{"Blue"},{if ((vehicle _this == _this or !tk_markVehiclesOn) && isPlayer _this) then {name _this} else {""}},allUnits]
					};
					case "plots": {
						[{"White"},{"Plot"},entities "Plastic_Pole_EP1_DZ"]
					};
					case "storage": {
						[{"Green"},{typeOf _this},nearestObjects [CENTER,["DZ_storage_base","VaultStorage","VaultStorageLocked","LockboxStorageLocked","LockboxStorage"],RADIUS]]
					};
					case "vehicles": {
						[{if (isPlayer _this) then {"Blue"} else {"Brown"}},{_this call _getCrew},CENTER nearEntities [["Air","LandVehicle","Ship"],RADIUS]]
					};
				};
				{
					_name = format["%1%2",_type,_forEachIndex];
					deleteMarkerLocal _name;
					_marker = createMarkerLocal [_name,getPos _x];
					_marker setMarkerColorLocal format["Color%1",(_x call (_list select 0))];
					_marker setMarkerTextLocal (_x call (_list select 1));			
					_marker setMarkerTypeLocal _class;
				} forEach (_list select 2);
			};
			
			uiSleep 1.5;
		};
		{deleteMarkerLocal format["%1%2",_type,_forEachIndex];} forEach (_list select 2);
	};
} else {
	[_script,false] call tk_scriptToggle;
	_list = [];
	_list resize 4000;
	{deleteMarkerLocal format["%1%2",_type,_forEachIndex];} forEach _list;
};