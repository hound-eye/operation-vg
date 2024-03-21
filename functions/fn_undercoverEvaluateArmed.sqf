/*
	Author: Houndeye
	Description:
		Notify undercover units about being in restricted area
	Parameter(s):
		0: OBJECT - unit to notify
	Returns:
		BOOLEAN
	Examples:
		[unit] call HNDM_fnc_undercoverHandleArea.
*/
/* Private variables */


// start countdown loop, showing warning and time before blowCover
// exit from loop, if cover is already blown
// trigger blowCover if countdown runs out 

/* Stops spectator script */
params["_ucUnit"];
if ((currentWeapon _ucUnit != "") || { (primaryWeapon _ucUnit != "") || { (secondaryWeapon _ucUnit != "") || { (handgunWeapon _ucUnit != "") || vest _ucUnit != "" } } }) then {
	[_ucUnit] call HNDM_fnc_undercoverArmed;
	true;
} else {
	[_ucUnit] call HNDM_fnc_undercoverUnarmed;
	false;
};
