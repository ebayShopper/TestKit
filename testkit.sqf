#define ALLOWED ["123456789","123456789"]
//#define ANTICHEAT //Uncomment to run testkit_ac.sqf on non-privileged clients

"PVDZ_getTickTime" addPublicVariableEventHandler {
	private ["_caller","_exitReason","_key","_name","_param","_type","_uid","_value"];
	
	_value = _this select 1;
	_uid = _value select 0;
	{
		if (_uid == getPlayerUID _x) exitWith {
			if (_uid in ALLOWED) then {
				_caller = _x;
				_name = if (alive _x) then {name _x} else {"DeadPlayer"};
				if (count _value == 1) then { // process login
					PVDZ_login = {call compile preprocessFileLineNumbers "testkit\init.sqf"};
					(owner _x) publicVariableClient "PVDZ_login";
					diag_log format["TESTKIT - Authorized startup by %1(%2)",_name,_uid];
				};
			} else {
#ifdef ANTICHEAT
				PVDZ_login = {
					#include "testkit_ac.sqf"
				};
				(owner _x) publicVariableClient "PVDZ_login";
#endif
			};
		};
	} count allUnits;
	
	if (count _value == 1) exitWith {};
	_type = _value select 1;
	_param = _value select 2;
	_key = _value select 3;
	
	_exitReason = [_this,"TESTKIT",_caller,_key,_uid,_caller] call server_verifySender;
	if (_exitReason != "") exitWith {diag_log _exitReason};
	
	if (_uid in ALLOWED) then {
		diag_log format["TESTKIT - Authorized server execution by %1(%2): %3",_name,_uid, switch (_type) do {
				case 1: { [_caller,_param] call tk_serverSpawnObject; format["spawned %1",_param select 0] };
				case 2: {
					dayzSetDate = [2012,8,2,_param,1];
					publicVariable "dayzSetDate";
					setDate dayzSetDate;
					format["set server to %1time",if (_param == 11) then {"day"} else {"night"}]
				};
				case 3: {
					drn_DynamicWeatherEventArgs = [_param,random _param,_param,"none",_param,0,-1,-1];
					publicVariable "drn_DynamicWeatherEventArgs";
					drn_DynamicWeatherEventArgs call drn_fnc_DynamicWeather_SetWeatherLocal;
					format["set server to %1 weather",if (_param == 0) then {"sunny"} else {"rainy"}]
				};
				case 4: {
					PVCDZ_hlt_Bandage = [_param,_caller];
					PVCDZ_hlt_Epi = [_param,_caller,"ItemEpinephrine"];
					PVCDZ_hlt_PainK = [_param,_caller];
					PVCDZ_hlt_Transfuse = [_param,_caller,12000];
					PVCDZ_hlt_AntiB = [_param,_caller];
					PVCDZ_hlt_Morphine = [_param,_caller];				
					{
						if (_param getVariable [_x,false]) then {
							_param setVariable [_x,false,true];
						};
					} count ["NORRN_unconscious","USEC_isCardiac","USEC_inPain"];
					{owner _param publicVariableClient _x;} count ["PVCDZ_hlt_Bandage","PVCDZ_hlt_Epi","PVCDZ_hlt_Morphine","PVCDZ_hlt_PainK","PVCDZ_hlt_Transfuse","PVCDZ_hlt_AntiB"];
					_param setVariable ["medForceUpdate",true,false];
					format["gave meds to %1",_param]
				};
			}
		];
	};
};

tk_serverSpawnObject = {
	private ["_caller","_class","_config","_count","_id","_ignoreMagazines","_ignoreWeapons","_list","_name","_object","_pos"];
	_caller = _this select 0;
	_class = (_this select 1) select 0;
	_pos = (_this select 1) select 1;

	_object = _class createVehicle _pos;
	_id = format ["%1",ceil(random 8000)];
	_object setVariable ["CharacterID",_id,true];
	_object setVariable ["lastUpdate",diag_ticktime,false];
	_object setVariable ["ObjectUID",_id,true];
	dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_object];
	clearBackpackCargoGlobal _object;
	clearMagazineCargoGlobal _object;
	clearWeaponCargoGlobal _object;
	
	if (_class == "AmmoBoxBig") then {
		_object setVariable ["permaLoot",true,false];
		_ignoreMagazines = [
			"bloodBagBase","SkinBase","wholeBloodBagBase","ItemAntibiotic_base","ItemAntibioticEmpty",
			"ItemBriefcase_Base","ItemBriefcaseEmpty","ItemSilvercase_Base","ItemSodaEmpty","TrashTinCan",
			"ItemFuelcanEmpty","ItemJerrycanEmpty","ItemFuelBarrelEmpty","45Rnd_545x39_RPK",
			"ItemJerryMixed","ItemJerryMixed1","ItemJerryMixed2","ItemJerryMixed3","ItemJerryMixed4"
		];
		_ignoreWeapons = [
			"ItemCore","MineE","ItemMatchbox_base","ItemMatchboxEmpty","ItemKnife_Base","ItemKnife1",
			"ItemKnife2","ItemKnife3","ItemKnife4","ItemKnife5","ItemKnifeBlunt","MeleeFlashlight",
			"MeleeFlashlightRed","ItemHatchetBroken","ItemSledgeHammerBroken","ItemPickaxeBroken",
			"ItemShovelBroken","Mosin_BR_DZ"
		];
		
		_ignoreParents = ["FakeWeapon","ItemMatchbox"];
		_config = configFile >> "CfgWeapons";
		_count = 0;
		_list = [];
		_list resize (count _config);
		{
			_class = _config select _count;
			_count = _count + 1;
			_name = configName _class;
			if (isClass _class && {!isNumber (_class >> "keyid")} && {isNumber (_class >> "type")} && {getNumber (_class >> "scope") > 1} && {getText (_class >> "picture") != ""} && {!(getNumber (_class >> "type") in [1,2]) or (!isClass (_class >> "ItemActions") or {count (_class >> "ItemActions") < 1})} && {!(configName(inheritsFrom _class) in _ignoreParents)} && {!(_name in _ignoreWeapons)}) then {
				_object addWeaponCargoGlobal [_name,4];
			};
		} count _list;
				
		_ignoreParents = ["FakeMagazine","ItemAntibiotic","ItemSodaEmpty","ItemWaterBottle","TrashTinCan"];
		_config = configFile >> "CfgMagazines";
		_count = 0;
		_list = [];
		_list resize (count _config);
		{
			_class = _config select _count;
			_count = _count + 1;
			_name = configName _class;
			if (isClass _class && {getNumber (_class >> "scope") > 1} && {getText (_class >> "picture") != ""} && {!isNumber (_class >> "worth") or getNumber (_class >> "worth") in [100,10000]} && {!(configName(inheritsFrom _class) in _ignoreParents)} && {!(_name in _ignoreMagazines)}) then {
				_object addMagazineCargoGlobal [_name,20];
			};
		} count _list;
		
		_object addBackpackCargoGlobal ["DZ_Backpack_EP1",1];
		tk_doneSpawning = true;
		(owner _caller) publicVariableClient "tk_doneSpawning";
	} else {
		// Vanilla vehicle. No 388 method to get objectID, so position will not save until next restart
		_pos set [2,0];
		format["CHILD:308:%1:%2:%3:%4:%5:%6:%7:%8:%9:",dayZ_instance,_class,0,_id,[0,_pos],[[[],[]],[[],[]],[[],[]]],[],1,_id] call server_hiveWrite;
		_object setVelocity [0,0,1];
		_object call fnc_veh_ResetEH;
	};
};