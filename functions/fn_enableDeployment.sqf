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
params["_deploymentObject","_enabled"];
_attachedMarker = _deploymentObject getVariable "HNDM_attachedMarker";
systemChat str (_attachedMarker);
private "_notification";
if (_enabled) then {
	systemChat "Enabling deployment";
	//_title="New available deployment point";
	//_icon="\A3\ui_f\data\map\markers\military\start_CA.paa";
	_attachedMarker setMarkerAlpha 1;

	_spawns = missionNamespace getVariable ["hndm_spawns", []];
	_spawns pushBack _deploymentObject;
	missionNamespace setVariable ["hndm_spawns", _spawns, true];
	_notification = "EnabledDeployment";

} else {
	systemChat "Disabling deployment";
	//_title="Deployment point unavailable";
	//_icon="\A3\ui_f\data\map\markers\military\objective_CA.paa";
	_attachedMarker setMarkerAlpha 0;

	_spawns = missionNamespace getVariable ["hndm_spawns", []];
	_spawns = _spawns - [_deploymentObject];
	missionNamespace setVariable ["hndm_spawns", _spawns, true];
	_notification = "DisabledDeployment";
};
_priority = 0;
_description = markerText _attachedMarker;

[_notification, [_description]] remoteExec ["BIS_fnc_showNotification",0];
_enabled;
