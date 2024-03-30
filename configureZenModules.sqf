["A_Mission", "Undercover: Enable unit", {[_this select 1] remoteExec ["HNDM_fnc_undercoverInit", owner (_this select 1)]}] call zen_custom_modules_fnc_register;
["A_Mission", "Undercover: Disable unit", {[_this select 1] remoteExec ["HNDM_fnc_undercoverRemove", owner (_this select 1)]}] call zen_custom_modules_fnc_register;

["A_Mission", "Unholster pistols for all AI", {
	{
		if (!isPlayer _x && {primaryWeapon _x == ""}) then {
			_x selectWeapon (handgunWeapon _x);
		};
	} forEach units west;
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

["A_Mission", "Stamina: Reset stamina for unit", {
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

["A_Mission", "Mission: Show objectives overlay", {
	if (!isNil "ace_med_debug") exitWith { systemChat "health is already displayed" };
	objective_overlay = addMissionEventHandler ["Draw3D", {
		{
		_unit = _x;
			if (!(isNil "_unit") AND ((side _unit) == west OR (side _unit) == east OR (side _unit) == resistance OR (side _unit) == civilian))then {
				if (!(isNil "test_backpack") && { test_backpack == unitBackpack _unit } ) then {
					_pos = ASLToAGL getPosASL _unit;
					_headPos = [_pos select 0, _pos select 1, (_pos select 2) + 1.2];
					_Text = format ["Merman's hair transplantant"];
					drawIcon3D ["", [1, 1, 1,1], _headPos, 0, 0, 0, _Text, 2, 0.03, "PuristaBold"];
				};
				if (!(isNil "money_backpack") && { money_backpack == unitBackpack _unit } ) then {
					_pos = ASLToAGL getPosASL _unit;
					_headPos = [_pos select 0, _pos select 1, (_pos select 2) + 1.2];
					_Text = format ["Money"];
					drawIcon3D ["", [1, 1, 1,1], _headPos, 0, 0, 0, _Text, 2, 0.03, "PuristaBold"];
				};
				if (!(isNil "intel_backpack") && { intel_backpack == unitBackpack _unit } ) then {
					_pos = ASLToAGL getPosASL _unit;
					_headPos = [_pos select 0, _pos select 1, (_pos select 2) + 1.2];
					_Text = format ["Intel"];
					drawIcon3D ["", [1, 1, 1,1], _headPos, 0, 0, 0, _Text, 2, 0.03, "PuristaBold"];
				};
			};
		} forEach allUnits;
	}];
}] call zen_custom_modules_fnc_register;


["A_Mission", "Mission: Hide objectives overlay", {
	removeMissionEventHandler ["Draw3D", objective_overlay];
	objective_overlay=nil;
}] call zen_custom_modules_fnc_register;
