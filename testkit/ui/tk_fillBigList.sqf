#include "colors.hpp"
private ["_bigList","_class","_color","_condition","_config","_filter","_function",
"_ignoreMagazines","_ignoreParents","_ignoreWeapons","_image","_index","_list","_name","_root","_text"];

disableSerialization;
_bigList = findDisplay 2929 displayCtrl 292901;
lbClear _bigList;

_filter = {
	_root = _this select 0;
	_condition = _this select 1;
	_image = if (count _this > 2) then {"portrait"} else {"picture"};
	_config = configFile >> _root;
	_bigList lbAdd "..";
	_bigList lbSetColor [0,WHITE];
	_count = 0;
	_list = [];
	_list resize (count _config);
	{
		_class = _config select _count;
		_count = _count + 1;
		_name = configName _class;
		
		if (isClass _class && {getNumber (_class >> "scope") > 1} && {getText (_class >> "picture") != ""} && _condition) then {
			_color = GREEN;
			_text = "";
			if (_root == "CfgVehicles") then {
				switch true do {
					case (_name isKindOf "StaticWeapon"): {_text = "StaticWeapon: "; _color = GREY;};
					case (_name isKindOf "LandVehicle"): {_text = "LandVehicle: ";};
					case (_name isKindOf "Air"): {_text = "Air: "; _color = ORANGE;};
					case (_name isKindOf "Ship"): {_text = "Ship: "; _color = BLUE;};
				};
			};
			if (_root == "CfgWeapons") then {
				switch getNumber (_class >> "type") do {
					case 1: {_text = "Primary: ";};
					case 5: {_text = "Large: ";};
					case 256;
					case 4096;
					case 131072: {_text = "Tool: "; _color = BLUE;};
					case 2: {_text = "Pistol: "; _color = ORANGE;};
					case 4: {_text = "Launcher: "; _color = GREY;};
				};
			};
			_index = _bigList lbAdd format["%1%2",_text,_name];
			_bigList lbSetColor [_index,_color];
			_bigList lbSetData [_index,_name];
			_bigList lbSetPicture [_index,getText (_class >> _image)];
		};
	} count _list;
	
	lbSort _bigList;
};

switch _this do {
	case "Scripts": {
		_bigList ctrlSetEventHandler ["LBDblClick","call tk_runScript;"];
		{
			_name = _x select 0;
			_function = _x select 1;
			_index = _bigList lbAdd _name;
			_bigList lbSetData [_index,_function];
			_bigList lbSetColor [_index, switch true do {
				case (_function == "tk_spawn"): {WHITE};
				case (_function == "tk_weather"): {BLUE};
				case (_function == "tk_pickPlayer"): {ORANGE};
				case (count _x > 3 && {_x select 3}): {GREEN};
				case default {GREY};
			}];
		} count tk_scriptList;
	};
	case "> Create vehicle": {
		["CfgVehicles",{_name isKindOf "LandVehicle" or {_name isKindOf "Air" && !(["Parachute",_name] call fnc_inString)} or {_name isKindOf "Ship"}}] call _filter;
	};
	case "> Add weapon": {
		_ignoreParents = ["FakeWeapon","ItemMatchbox"];
		_ignoreWeapons = [
			"ItemCore","MineE","ItemMatchbox_base","ItemMatchboxEmpty","ItemKnife_Base","ItemKnife1",
			"ItemKnife2","ItemKnife3","ItemKnife4","ItemKnife5","ItemKnifeBlunt","MeleeFlashlight",
			"MeleeFlashlightRed"
		];
		[
			"CfgWeapons", 
			{
				!isNumber (_class >> "keyid") &&
				{isNumber (_class >> "type")} &&
				{!(configName(inheritsFrom _class) in _ignoreParents)} &&
				{!(_name in _ignoreWeapons)}
			}
		] call _filter;
	};
	case "> Add magazine": {
		_ignoreParents = ["FakeMagazine","ItemAntibiotic","ItemSodaEmpty","ItemWaterBottle","TrashTinCan"];
		_ignoreMagazines = [
			"bloodBagBase","SkinBase","wholeBloodBagBase","ItemAntibiotic_base","ItemAntibioticEmpty",
			"ItemBriefcase_Base","ItemBriefcaseEmpty","ItemSilvercase_Base","ItemSodaEmpty","TrashTinCan",
			"ItemFuelcanEmpty","ItemJerrycanEmpty","ItemFuelBarrelEmpty","45Rnd_545x39_RPK",
			"ItemJerryMixed","ItemJerryMixed1","ItemJerryMixed2","ItemJerryMixed3","ItemJerryMixed4"
		];
		[
			"CfgMagazines",
			{
				(!isNumber (_class >> "worth") or getNumber (_class >> "worth") in [100,10000]) && // Full silver and gold briefcases only
				{!(configName(inheritsFrom _class) in _ignoreParents)} &&
				{!(_name in _ignoreMagazines)}
			}
		] call _filter;
	};
	case "> Add backpack": {
		["CfgVehicles",{getText (_class >> "vehicleClass") == "Backpacks" && _name != "IED_placement_BAF"}] call _filter;
	};
	case "> Change clothes": {
		["CfgVehicles",{getNumber (_class >> "isMan") > 0 && _name != "Zed_Base"},true] call _filter;
	};
};

_bigList