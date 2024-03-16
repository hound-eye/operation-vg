/*
	Author: Houndeye
	Description:
		Configure spectator
	Parameter(s):
		0: OBJECT - unit to stop spectating
	Returns:
		BOOLEAN
	Examples:
		[kill_obj_trigger] call HNDM_fnc_onObjectiveCompletion.
*/
/* Private variables */

/* Enables post processing effects for spectator */

BIS_fnc_feedback_allowPP = true;
/* Stops spectator script */
("BIS_fnc_respawnSpectator" call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
("HNDM_hint" call BIS_fnc_rscLayer) cutText ["", "PLAIN"];
/* Removes event handlers detecting key press */
if (!isNil "BEARB_SpectatorEH") then {
	(findDisplay 46) displayRemoveEventHandler ["KeyDown", BEARB_SpectatorEH];
};
/* Allows unit moving */
player enableSimulation true;
true;