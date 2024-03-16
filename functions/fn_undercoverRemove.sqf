/*
	Author: Houndeye
	Description:
		Remove undercover mechanics from a unit
	Parameter(s):
		0: OBJECT - unit to disable undercover logic for
	Returns:
		BOOLEAN
	Examples:
		[unit] call HNDM_fnc_blowCover.
*/
/* Private variables */


// start countdown loop, showing warning and time before blowCover
// exit from loop, if cover is already blown
// trigger blowCover if countdown runs out 

/* Stops spectator script */
params["_ucUnit"];
//check if unit is already undercover
HNDM_UC_enabled = missionNamespace getVariable ["HNDM_UC_enabled",false];
if (!HNDM_UC_enabled) exitWith {
	systemChat "### Unit is not undercover! ###"
};

systemChat "DEBUG UC Removed";
if (captive _ucUnit) then {
	_ucUnit setCaptive false;
};
	cutRsc ["UndercoverRemove","PLAIN"];
["weapon", HNDM_UC_EVH_weapon] call CBA_fnc_removePlayerEventHandler;
["loadout", HNDM_UC_EVH_loadout] call CBA_fnc_removePlayerEventHandler;
["vehicle", HNDM_UC_EVH_vehicle] call CBA_fnc_removePlayerEventHandler;
HNDM_UC_enabled=nil;