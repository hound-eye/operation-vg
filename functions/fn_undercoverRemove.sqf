/*
	Author: Houndeye
	Description:
		Remove undercover mechanics from a unit
	Parameter(s):
		0: OBJECT - unit to disable undercover logic for
	Returns:
		BOOLEAN
	Examples:
		[unit] call HNDM_fnc_undercoverRemove
*/
/* Private variables */


// start countdown loop, showing warning and time before blowCover
// exit from loop, if cover is already blown
// trigger blowCover if countdown runs out 

/* Stops spectator script */
params["_ucUnit"];
_ucUnit setCaptive false;
("HNDM_UC_status" call BIS_fnc_rscLayer) cutRsc ["UndercoverRemoveMessage","PLAIN"];
["weapon", _ucUnit getVariable "HNDM_UC_EVH_weapon"] call CBA_fnc_removePlayerEventHandler;
["loadout",  _ucUnit getVariable "HNDM_UC_EVH_loadout"] call CBA_fnc_removePlayerEventHandler;
["vehicle",  _ucUnit getVariable "HNDM_UC_EVH_vehicle"] call CBA_fnc_removePlayerEventHandler;
_ucUnit setVariable ["HNDM_UC_enabled",nil,true];
true;