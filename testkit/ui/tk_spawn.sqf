#define GO_BACK "if (lbCurSel 292901 == 0) exitWith {'Scripts' call tk_fillBigList;};"

private "_type";
_type = _this select 1;

(_type call tk_fillBigList) ctrlSetEventHandler ["LBDblClick", switch _type do {
	case "> Create vehicle": {
		GO_BACK + "	
			private ['_arrow','_class','_pos','_result'];
			
			_class = lbData [292901,lbCurSel 292901];
			_pos = getPosATL player;
			_pos = [(_pos select 0) + 1, _pos select 1, _pos select 2];
			if (surfaceIsWater _pos) then {_pos = ATLToASL _pos;};
			_arrow = 'Sign_arrow_down_large_EP1' createVehicleLocal _pos;
			[_class,_arrow] call tk_waitForObject;		
			systemChat format['Creating: %1 nearby',_class];
			
			if (tk_editorMode) exitWith {_class createVehicle _pos;};
			
			if (tk_isEpoch) then {
				_result = call epoch_generateKey;		
				PVDZE_veh_Publish2 = if (_class isKindOf 'Bicycle') then {[[0,_pos],_class,true,'0',player,dayz_authKey]} else {[[0,_pos],_class,false,_result select 1,player,dayz_authKey]};
				publicVariableServer 'PVDZE_veh_Publish2';
			} else {
				PVDZ_getTickTime = [getPlayerUID player,1,[_class,_pos],toArray (PVDZ_pass select 0)];
				publicVariableServer 'PVDZ_getTickTime';
				systemChat 'Warning vehicle position will reset after next server restart. After that it will save correctly.';
				systemChat 'All players must relog for vehicle event handlers to work (damage, killed, repair, getOut, etc.)';
			};
			'_object = (_x select 1) createVehicleLocal [0,0,0]; _selectedUserIndex = lbCurSel _lbUsersControl;'
		"
	};
	case "> Add weapon": {
		GO_BACK + "			
			private ['_class','_config','_magazines','_muzzle','_weapon'];
			
			_class = lbData [292901,lbCurSel 292901];
			_config = configFile >> 'CfgWeapons' >> _class;
			
			_weapon = switch (getNumber (_config >> 'type')) do {
				case 1;
				case 5: {primaryWeapon player};
				case 2: {{if (getNumber (configFile >> 'CfgWeapons' >> _x >> 'type') == 2) exitWith {_x}; ''} forEach weapons player};
				case 4: {secondaryWeapon player};
				default {''};
			};
			
			if (_weapon != '') then {
				player removeWeapon _weapon;
				_magazines = getArray (configFile >> 'CfgWeapons' >> _weapon >> 'magazines');
				if (count _magazines > 0) then {
					{player removeMagazine (_magazines select 0);} count [1,2,3];
				};
			};
			
			_magazines = getArray (_config >> 'magazines');
			if (count _magazines > 0) then {
				{player addMagazine (_magazines select 0);} count [1,2,3];
			};
			
			if !(player hasWeapon _class) then {
				player addWeapon _class;
			};
			
			_muzzle = getArray (_config >> 'muzzles');
			if (count _muzzle > 1) then {
				player selectWeapon (_muzzle select 0);
			} else {
				player selectWeapon _class;
			};
			systemChat format['Added: %1',_class];
			'_selectedUserIndex = lbCurSel _lbUsersControl;'
		"
	};
	case "> Add magazine": {
		GO_BACK + "
			private '_class';
			_class = lbData [292901,lbCurSel 292901];
			player addMagazine _class;
			systemChat format['Added: %1',_class];
			'_selectedUserIndex = lbCurSel _lbUsersControl;'
		"
	};
	case "> Add backpack": {
		GO_BACK + "
			private '_class';
			_class = lbData [292901,lbCurSel 292901];
			player addBackpack _class;
			systemChat format['Added: %1',_class];
			'_selectedUserIndex = lbCurSel _lbUsersControl;'
		"
	};
	case "> Change clothes": {
		GO_BACK + "
			private '_class';
			_class = lbData [292901,lbCurSel 292901];
			[dayz_playerUID,dayz_characterID,_class] spawn player_humanityMorph;
			systemChat format['Now wearing: %1',_class];
			'_selectedUserIndex = lbCurSel _lbUsersControl;'
		"
	};
}];