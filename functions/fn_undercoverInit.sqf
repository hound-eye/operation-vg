/*
	Author: Houndeye
	Description:
		Initialize unit as undercover
	Parameter(s):
		0: OBJECT - unit to disable undercover logic for
	Returns:
		BOOLEAN
	Examples:
		[unit] call HNDM_fnc_undercoverInit
*/
/* Private variables */
systemChat "undercover init";
params["_ucUnit"];

//check if unit is already undercover
//HNDM_UC_enabled = missionNamespace getVariable ["HNDM_UC_enabled",false];
_ucEnabled = _ucUnit getVariable ["HNDM_UC_enabled", false];

if (_ucEnabled) exitWith {
	systemChat "### Unit already enabled as undercover! ###";
	false;
};

_ucUnit setVariable ["HNDM_UC_enabled", true, false];
//give unit armed/unarmed status
[_ucUnit] call HNDM_fnc_undercoverEvaluateArmed;
//the next part is what happens if the player changes his weapon (on foot):

//and here we add the cba-playerEventHandler: They trigger everytime something happens and will execute some code:
//this one executes the code within {} (which is our undercover_scriptfnc_switch_onfoot from above) if the player changes his weapon:
HNDM_UC_EVH_weapon = ["weapon", {[_this select 0, _this select 1] call HNDM_fnc_undercoverHandleWeaponChange}] call CBA_fnc_addPlayerEventHandler;
HNDM_UC_EVH_loadout = ["loadout", {[_this select 0, _this select 1] call HNDM_fnc_undercoverHandleLoadoutChange}] call CBA_fnc_addPlayerEventHandler;
//this one executes the code within {} (which is our undercover_scriptfnc_switch_inVeh from above) if the player changes his vehicle:
HNDM_UC_EVH_vehicle = ["vehicle", {[_this select 0, _this select 1] call HNDM_fnc_undercoverHandleVehicleChange}] call CBA_fnc_addPlayerEventHandler;
//and done.
true;