/*
	Author: Houndeye
	Description:
		Initialize unit as undercover
	Parameter(s):
		0: OBJECT - unit to disable undercover logic for
	Returns:
		BOOLEAN
	Examples:
		[unit] call HNDM_fnc_initializeUndercover
*/
/* Private variables */
systemChat "undercover init";
params["_ucUnit"];

//check if unit is already undercover
HNDM_UC_enabled = missionNamespace getVariable ["HNDM_UC_enabled",false];
if (HNDM_UC_enabled) exitWith {
	systemChat "### Unit already enabled as undercover! ###"
};

HNDM_UC_enabled=true;
[_ucUnit] call HNDM_fnc_undercoverOn;


//the next part is what happens if the player changes his weapon (on foot):
undercover_scriptfnc_switch_weapon = {
	params [
		["_unit", player, [objNull]]
		,["_weapon", currentWeapon player, [""]]
	];
	systemChat "DEBUG switched weapon";
	systemChat str(_unit);
	if (primaryWeapon _unit != "") exitWith {
		[_unit] call HNDM_fnc_undercoverOff;
	};
	if (secondaryWeapon _unit != "") exitWith {
		[_unit] call HNDM_fnc_undercoverOff;
	};

  	//if the player changed to binoculars, there will be no change (if he was undercover, he will remain undercover - if not, then not)
	if (binocular _unit != "" && {_weapon isEqualTo (binocular _unit)}) exitWith {};


	//if the player changes to no weapon he will go undercover:
	if ( _weapon isEqualTo "" ) exitWith {
		[_unit] call HNDM_fnc_undercoverOn;
	};
  	//the stuff below here is being executed, if none of the above applied:
	[_unit] call HNDM_fnc_undercoverOff;
};

undercover_scriptfnc_switch_loadout = {
	params [
		["_unit", player, [objNull]],
		["_loadout", getUnitLoadout player, []]
	];
	systemChat "DEBUG changed loadout";
	// flag determines if unit should go uc
	private _armed = false;
	if (count (getUnitLoadout _unit select 0) != 0) then { _armed = true };
	if (count (getUnitLoadout _unit select 1) != 0) then { _armed = true };
	if (count (getUnitLoadout _unit select 2) != 0) then { _armed = true };

	if (!_armed) then {
		[_unit] call HNDM_fnc_undercoverOn;
	} else {

		[_unit] call HNDM_fnc_undercoverOff;
	};
};

//the following is what appens if the player jumps into a vehicle:
undercover_scriptfnc_switch_vehicle = {
	params [
		["_unit", player, [objNull]]
		,["_veh", vehicle player, [objNull]]
	];
	systemChat "DEBUG switched vehicle";
  	//if the vehicle has no weapons, nothing will change:
	if ( (_veh currentWeaponTurret [0]) isEqualTo "" ) exitWith {};
	//but if it did, this will happen:
	[_unit] call HNDM_fnc_undercoverOff;
};

undercover_scriptevh_inventory = player addEventHandler ["InventoryClosed", {
	params ["_unit", "_container"];
	if (_container isKindOf "WeaponHolder") then
	{
		//deleteVehicle _container;
	};
}];

//and here we add the cba-playerEventHandler: They trigger everytime something happens and will execute some code:
//this one executes the code within {} (which is our undercover_scriptfnc_switch_onfoot from above) if the player changes his weapon:
HNDM_UC_EVH_weapon = ["weapon", {[_this select 0, _this select 1] call undercover_scriptfnc_switch_weapon}] call CBA_fnc_addPlayerEventHandler;
HNDM_UC_EVH_loadout = ["loadout", {[_this select 0, _this select 1] call undercover_scriptfnc_switch_loadout}] call CBA_fnc_addPlayerEventHandler;
//this one executes the code within {} (which is our undercover_scriptfnc_switch_inVeh from above) if the player changes his vehicle:
HNDM_UC_EVH_vehicle = ["vehicle", {[_this select 0, _this select 1] call undercover_scriptfnc_switch_vehicle}] call CBA_fnc_addPlayerEventHandler;
//and done.