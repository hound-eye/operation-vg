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
	["_unit", player, [objNull]],
	["_loadout", getUnitLoadout player, []]
];
// flag determines if unit should go uc
private _armed = false;
if (count (getUnitLoadout _unit select 0) != 0) then { _armed = true };
if (count (getUnitLoadout _unit select 1) != 0) then { _armed = true };
if (count (getUnitLoadout _unit select 2) != 0) then { _armed = true };
if (count (getUnitLoadout _unit select 4) != 0) then { _armed = true };

if (!_armed) then {
	[_unit] call HNDM_fnc_undercoverUnarmed;
} else {

	[_unit] call HNDM_fnc_undercoverArmed;
};