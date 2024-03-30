/*
	Author: Houndeye
	Description:
		Remove undercover mechanics from a unit
	Parameter(s):
		0: OBJECT - unit to disable undercover logic for
	Returns:
		BOOLEAN
	Examples:
		[unit] call HNDM_fnc_undercoverOff
*/
/* Private variables */


// start countdown loop, showing warning and time before blowCover
// exit from loop, if cover is already blown
// trigger blowCover if countdown runs out 

/* Stops spectator script */
params["_ucUnit"];
//systemChat "DEBUG UC OFF";
("HNDM_UC_status" call BIS_fnc_rscLayer) cutRsc ["ArmedMessage","PLAIN"];
//and this switches him back to his regular self:
_ucUnit setCaptive false;
true;
