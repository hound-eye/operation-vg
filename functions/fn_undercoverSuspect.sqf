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
/* Private variables */
params["_ucUnit"];
("HNDM_UC_status" call BIS_fnc_rscLayer) cutRsc ["SuspectMessage","PLAIN"];
//and this switches him back to his regular self:
true;