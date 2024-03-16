/*
	Author: Houndeye
	Description:
		Notify undercover units about being in restricted area
	Parameter(s):
		0: OBJECT - unit to notify
	Returns:
		BOOLEAN
	Examples:
		[unit] call HNDM_fnc_notifyRestrictedArea.
*/
/* Private variables */


// start countdown loop, showing warning and time before blowCover
// exit from loop, if cover is already blown
// trigger blowCover if countdown runs out 

/* Stops spectator script */
systemChat "undercover handle area";
params["_ucUnit"];