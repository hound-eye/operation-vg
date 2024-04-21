["A_Mission_Undercover", "Undercover: Enable unit", {
	_player = _this select 1;
	if (!isNull _player) then {
		_player remoteExecCall ["HNDM_fnc_undercoverInit", _player];
		systemChat format ["activated UC status for %1", _player];
	} else {
		systemChat "Must select a valid player!";
	};
	
}] call zen_custom_modules_fnc_register;

["A_Mission_Undercover", "Undercover: Disable unit", {
	_player = _this select 1;
	if (!isNull _player) then {
		_player remoteExecCall ["HNDM_fnc_undercoverRemove", _player];
		systemChat format ["removed UC status for %1", _player];
	} else {
		systemChat "Must select a valid player!";
	};

}] call zen_custom_modules_fnc_register;
["A_Mission_Undercover", "Undercover: DISABLE FOR ALL PLAYERS", {
	{
		_uc_status = _x getVariable ["HNDM_UC_enabled",false];
		if (_uc_status ) then {
			[_x] remoteExec ["HNDM_fnc_undercoverRemove", _x];
			systemChat format ["removed UC status for %1", _x];
		}
	} forEach allPlayers;
	}] call zen_custom_modules_fnc_register;

// mission overlay
["A_Mission_Overlays", "Health: Display blood values", {
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

["A_Mission_Overlays", "Health: Hide blood values", {
	removeMissionEventHandler ["Draw3D", ace_med_debug];
	ace_med_debug=nil;
}] call zen_custom_modules_fnc_register;

["A_Mission_Misc", "Stamina: Reset stamina for unit", {
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

["A_Mission_Overlays", "Mission: Show objectives overlay", {
	if (!isNil "objective_overlay") exitWith { systemChat "health is already displayed" };
	objective_overlay = addMissionEventHandler ["Draw3D", {
		{
			if (!isNil { _x select 0}) then {
				_pos = ASLToAGL getPosASL (objectParent (_x select 0)); 
				_headPos = [_pos select 0, _pos select 1, (_pos select 2) + 1.2];
				_Text = format ["Merman's hair transplantant"];
				drawIcon3D ["", [1, 1, 1,1], _headPos, 0, 0, 0, (_x select 1), 2, 0.03, "PuristaBold"];
			}
		} forEach [[test_backpack, "Merman's Hair Transplant"], [money_backpack, "Money"], [intel_backpack, "Intel"]];
	}];
}] call zen_custom_modules_fnc_register;

["A_Mission_Overlays", "Mission: Hide objectives overlay", {
	removeMissionEventHandler ["Draw3D", objective_overlay];
	objective_overlay=nil;
}] call zen_custom_modules_fnc_register;

["A_Mission_Deploy", "Deploy: Enable Deployment", {
	_board = _this select 1;
	[_board, true] call HNDM_fnc_enableDeployment;
}] call zen_custom_modules_fnc_register;

["A_Mission_Deploy", "Deploy: Disable Deployment", {
	_board = _this select 1;
	[_board, false] call HNDM_fnc_enableDeployment;
}] call zen_custom_modules_fnc_register;

["A_Mission_AI", "AI: Unholster pistols for all AI", {
	_modulePos = _this select 0;
	_units = _modulePos nearEntities ["Man", 200];
	{
		if (!isPlayer _x && {primaryWeapon _x == ""}) then {
			_x selectWeapon (handgunWeapon _x);
		};
		_x enableAI "MOVE";
	} forEach _units;
}] call zen_custom_modules_fnc_register;

["A_Mission_Tasks_Bonus_Intel", "CREATE Eliminate all intelligence officers", {
	_taskBrief = "<img image='images\bonus_intel.paa' width='367' height='256'/><br/>Locate and eliminate intelligence officer, who are in charge of this COIN operation, before they could make their escape.";
	[east, "tsk_bonus_intel", [_taskBrief, "Eliminate all intelligence officers"], objNull, "CREATED", -1, true, "kill"] call BIS_fnc_taskCreate;
}] call zen_custom_modules_fnc_register;

["A_Mission_Tasks_Bonus_Intel", "FAIL Eliminate all intelligence officers", {
	["tsk_bonus_intel", "FAILED", true] call BIS_fnc_taskSetState;
	// create task
}] call zen_custom_modules_fnc_register;

["A_Mission_Tasks_Bonus_Intel", "SUCCEED Eliminate all intelligence officers", {
	["tsk_bonus_intel", "SUCCEEDED", true] call BIS_fnc_taskSetState;
}] call zen_custom_modules_fnc_register;


["A_Mission_Tasks_Bonus_Money", "CREATE Defend the contact", {
	_taskBrief = "<img image='images\bonus_money.paa' width='367' height='256'/><br/>You have been ambushed! Fend off the attack and prevent your goods from falling into the enemy's hands.";
	[east, "tsk_bonus_money", [_taskBrief, "Defend the contact"], objNull, "CREATED", -1, true, "defend"] call BIS_fnc_taskCreate;
}] call zen_custom_modules_fnc_register;

["A_Mission_Tasks_Bonus_Money", "FAIL Defend the contact", {
	["tsk_bonus_money", "FAILED", true] call BIS_fnc_taskSetState;
}] call zen_custom_modules_fnc_register;

["A_Mission_Tasks_Bonus_Money", "SUCCEED Defend the contact", {
	["tsk_bonus_money", "SUCCEEDED", true] call BIS_fnc_taskSetState;
}] call zen_custom_modules_fnc_register;


["A_Mission_Tasks_Bonus_Extract", "CREATE Hold the docks until extraction arrives", {
	_taskBrief = "<img image='images\bonus_extract.paa' width='367' height='256'/><br/>Our reinforcements are en-route to give you transport off the island. Hold on!";
	[east, "bonus_extract", [_taskBrief, "Hold the docks until extraction arrives"], objNull, "CREATED", -1, true, "defend"] call BIS_fnc_taskCreate;
}] call zen_custom_modules_fnc_register;

["A_Mission_Tasks_Bonus_Extract", "FAIL Hold the docks until extraction arrives", {
	["tsk_bonus_extract", "FAILED", true] call BIS_fnc_taskSetState;
}] call zen_custom_modules_fnc_register;

["A_Mission_Tasks_Bonus_Extract", "SUCCEED Hold the docks until extraction arrives", {
	["tsk_bonus_extract", "SUCCEEDED", true] call BIS_fnc_taskSetState;
}] call zen_custom_modules_fnc_register;


["A_Mission_Tasks_MAIN", "FAIL Intel", {
	["TSK_INTEL", "FAILED", true] call BIS_fnc_taskSetState;
	// create task
}] call zen_custom_modules_fnc_register;

["A_Mission_Tasks_MAIN", "SUCCEED Intel", {
	["TSK_INTEL", "SUCCEEDED", true] call BIS_fnc_taskSetState;
}] call zen_custom_modules_fnc_register;

["A_Mission_Tasks_MAIN", "FAIL Money", {
	["TSK_MONEY", "FAILED", true] call BIS_fnc_taskSetState;
	// create task
}] call zen_custom_modules_fnc_register;

["A_Mission_Tasks_MAIN", "SUCCEED Money", {
	["TSK_MONEY", "SUCCEEDED", true] call BIS_fnc_taskSetState;
}] call zen_custom_modules_fnc_register;

["A_Mission_Tasks_MAIN", "FAIL Extract", {
	["TSK_EXTRACT", "FAILED", true] call BIS_fnc_taskSetState;
	// create task
}] call zen_custom_modules_fnc_register;

["A_Mission_Tasks_MAIN", "SUCCEED Extract", {
	["TSK_EXTRACT", "SUCCEEDED", true] call BIS_fnc_taskSetState;
}] call zen_custom_modules_fnc_register;