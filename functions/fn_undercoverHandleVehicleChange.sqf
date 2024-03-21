/*
	Author: Houndeye
	Description:
		Initialize unit as undercover
	Parameter(s):
		0: OBJECT - unit to disable undercover logic for
	Returns:
		BOOLEAN
	Examples:
		[unit] call HNDM_fnc_undercover
*/
/* Private variables */
params [
	["_unit", player, [objNull]]
	,["_veh", vehicle player, [objNull]]
];
systemChat "DEBUG switched vehicle";
//if the vehicle has no weapons, nothing will change:
if ( (_veh currentWeaponTurret [0]) isEqualTo "" ) exitWith {};
//but if it did, this will happen:
[_unit] call HNDM_fnc_undercoverOff;