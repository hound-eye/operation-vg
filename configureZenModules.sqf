["A_Mission", "Add undercover mechanics", {[_this select 1] remoteExec ["HNDM_fnc_undercoverInit", owner (_this select 1)]}] call zen_custom_modules_fnc_register;
["A_Mission", "Remove undercover mechanics", {[_this select 1] remoteExec ["HNDM_fnc_undercoverRemove", owner (_this select 1)]}] call zen_custom_modules_fnc_register;

["A_Mission", "Holster pistols for all AI", {
		{
			if (!isPlayer _x && {currentWeapon _x == handgunWeapon _x}) then {
				_x action ['SwitchWeapon', _x, _x, 100];
			};
		} forEach allUnits;
	}] call zen_custom_modules_fnc_register;

["A_Mission", "Unholster pistols for all AI", {
		{
			if (!isPlayer _x && {currentWeapon _x == handgunWeapon _x}) then {
				_x action ['SwitchWeapon', _x, _x, 100];
			};
		} forEach allUnits;
	}] call zen_custom_modules_fnc_register;


["A_Mission", "Health: Display blood values", {
	if (!isNil "ace_med_debug") exitWith { systemChat "health is already displayed" };
	ace_med_debug = addMissionEventHandler ["Draw3D", {
		{
		_unit = _x;
			if (!(isNil "_unit") AND ((side _unit) == west OR (side _unit) == east OR (side _unit) == civilian))then{
				_pos = ASLToAGL getPosASL _unit;
				_headPos = [_pos select 0, _pos select 1, (_pos select 2) + 1.2];
				_heartRate = _unit getVariable ["ace_medical_heartrate", 00];
				_bloodPressure = _unit getVariable ["ace_medical_bloodpressure", [00,00]];
				_bloodVolume = _unit getVariable ["ace_medical_bloodvolume", 00];
				_Text = format ["HR: %1 | BP: %2 | BV: %3",_heartRate toFixed 1,_bloodPressure,_bloodVolume toFixed 3];
				drawIcon3D ["", [1, 1, 1,1], _headPos, 0, 0, 0, _Text, 2, 0.03, "PuristaBold"];
				_headPos = [_pos select 0, _pos select 1, (_pos select 2) + 0.5];
				_state = _unit getVariable ["cba_statemachine_state0",""];
				_text = "";
				if(_state == "cardiacarrest")then{
					_text = format["cardiacarrest (%1 s)", (_unit getVariable ["ace_medical_statemachine_cardiacarresttimeleft",0]) toFixed 1];
				}else{
					_text = _state;
				};
				drawIcon3D ["", [0.1, 0.45, 1,1], _headPos, 0, 0, 0, _text , 2, 0.03, "PuristaBold"];
			};
		} forEach allUnits;
	}];
}] call zen_custom_modules_fnc_register;

["A_Mission", "Health: Hide blood values", {
	removeMissionEventHandler ["Draw3D", ace_med_debug];
	ace_med_debug=nil;
}] call zen_custom_modules_fnc_register;

["A_Mission", "Reset stamina", {
	_entity=_this select 1;
	if (isNull _entity ) exitWith {systemChat "no entity selected"};
	_code={
		ace_advanced_fatigue_ae1reserve=4000000;
		ace_advanced_fatigue_ae2reserve=84000;
		ace_advanced_fatigue_anreserve=2300;
		ace_advanced_fatigue_anfatigue=0;
		ace_advanced_fatigue_muscledamage=0;
	};
	["ZEN_common_execute", [_code, _entity], _entity] call CBA_fnc_targetEvent;
	systemChat format ["stamina reset for %1", _entity];
}] call zen_custom_modules_fnc_register;

// [{ 
//   systemChat format ["1st Aerobic reserve:%1", ace_advanced_fatigue_ae1reserve]; 
//   systemChat format ["2nd Aerobic reserve:%1", ace_advanced_fatigue_ae2reserve]; 
//   systemChat format ["Anaerobic reserve:%1", ace_advanced_fatigue_anreserve]; 
//   systemChat format ["Anaerobic fatigue:%1", ace_advanced_fatigue_anfatigue]; 
//   systemChat format ["Aiming fatigue:%1", ace_advanced_fatigue_aimfatigue]; 
//   systemChat format ["Muscle damage:%1", ace_advanced_fatigue_muscledamage]; 
// }, 
// 5, 
// []] call CBA_fnc_addPerFrameHandler;
