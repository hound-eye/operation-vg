/*
	Author: Houndeye
	Description:
		Enable or disable deployment for reinforcements.
	Parameter(s):
		0: OBJECT - deployment point marker name
		1: BOOLEAN - true to enable, false to disable
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
params["_deployment","_enabled"];
_enabled=true;
if (_enabled) then {
	_title="New available deployment point";
	_icon="\A3\ui_f\data\map\markers\military\start_CA.paa";
} else {
	_title="Deployment point unavailable";
	_icon="\A3\ui_f\data\map\markers\military\objective_CA.paa";
};
_priority = 0;
_description = "example";

["Default", [_title, _icon, "", _description, _color, 5, 0]] call BIS_fnc_showNotification;
_enabled;
