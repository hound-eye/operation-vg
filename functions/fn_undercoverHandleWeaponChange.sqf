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
	,["_weapon", currentWeapon player, [""]]
];
if (primaryWeapon _unit != "") exitWith {
	[_unit] call HNDM_fnc_undercoverArmed;
};
if (secondaryWeapon _unit != "") exitWith {
	[_unit] call HNDM_fnc_undercoverOff;
};
if (handgunWeapon _unit != "") exitWith {
	[_unit] call HNDM_fnc_undercoverOff;
};

//if the player changed to binoculars, there will be no change (if he was undercover, he will remain undercover - if not, then not)
if (binocular _unit != "" && {_weapon isEqualTo (binocular _unit)}) exitWith {};


//if the player changes to no weapon he will go undercover:
if ( _weapon isEqualTo "" ) exitWith {
	[_unit] call HNDM_fnc_undercoverUnarmed;
};
//the stuff below here is being executed, if none of the above applied:
[_unit] call HNDM_fnc_undercoverArmed;