/*
	Author: Houndeye
	Description:
		Gather playes at spawn_area trigger, and send them to the toPos object's location.
	Parameter(s):
	Returns:
		BOOLEAN
	Examples:
		[thisTrigger] call HNDM_fnc_onObjectiveCompletion.
*/
if (!isServer) exitWith {};

[{ 2 fadeSound 0; [0,"BLACK",2,0] call BIS_fnc_fadeEffect;}] remoteExec ["call"];
sleep 3;
[[2025, 4, 30, 5, 30]] remoteExec ["setDate"];
sleep 2;
[{2 fadeSound 1; cutText ["Time - 05:30", "BLACK IN", 5]; }] remoteExec ["call"];
true;