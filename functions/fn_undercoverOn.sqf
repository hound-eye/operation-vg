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
systemChat "DEBUG UC ON";
if (!captive _ucUnit) then {
	cutRsc ["UndercoverOn","PLAIN"];
};
//and this switches him back to his regular self:
_ucUnit setCaptive true;
true;