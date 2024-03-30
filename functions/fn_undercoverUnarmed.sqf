/*
	Author: Houndeye
	Description:
	Parameter(s):
		0: OBJECT - 
	Returns:
		BOOLEAN
	Examples:
		[unit] call HNDM_fnc_undercoverUnarmed
*/
params["_ucUnit"];
systemChat "DEBUG UC ON";
("HNDM_UC_status" call BIS_fnc_rscLayer) cutRsc ["UnarmedMessage","PLAIN"];
//and this switches him back to his regular self:
_ucUnit setCaptive true;
true;