/*
	Author: Houndeye
	Description:
		Gather playes at spawn_area trigger, and send them to the toPos object's location.
	Parameter(s):
		0: OBJECT - objective trigger.
		1: OBJECT - object, whose position.
		2: STRING - message that will be sent upon arrival
	Returns:
		BOOLEAN
	Examples:
		[kill_obj_trigger] call HNDM_fnc_onObjectiveCompletion.
*/
if (!isServer) exitWith {};

// script does nothing, if reinforcements are already being deployed
[missionNamespace, "HNDM_deployingInProgress", false] call BIS_fnc_getServerVariable;
if (HNDM_deployingInProgress) exitWith {};
[missionNamespace, "HNDM_deployingInProgress", true] call BIS_fnc_setServerVariable;

params ["_spawnObject"];

//_toPos - object, whose position is used to deploy reinforcements to
//_deployMessage - message that is sent upon reinforcements arrival
private ["_chat","_toPos", "_deployMessage"];

//determine player that is used to send chat messages
if (isNil "zeus") then {
	_chat=player;
} else {
	_chat=zeus;
};

switch (_spawnObject) do
{
	case spawn_camp:
	{
		_toPos = getPosATL spawn_camp;
		_deployMessage = "Deploying to the western camp";
	};
	case spawn_hike:
	{
		_toPos = getPosATL spawn_hike;
		_deployMessage = "Deploying to hiker's path";
	};
	case spawn_safehouse:
	{
		_toPos = getPosATL spawn_safehouse;
		_deployMessage = "Deploying to safehouse";
	};
	case spawn_contact:
	{
		_toPos = getPosATL spawn_contact;
		_deployMessage = "Friendly reinforcements inbound, south of contant compound.";
	};
};

_spawnees = list spawn_area;

if (count _spawnees > 0) then 
{
	[_chat, "Objective complete! Sending available reinforcements to your location."] remoteExec ["sideChat"]; 
};

// hint players in the trigger, that they are about to be deployed

for [{_i=10},{_i>=2},{_i=_i-1}] do 
{
	{
		if (isPlayer _x ) then {
			[format ["Deploying friendly reinforcements in %1 seconds", _i]] remoteExec ["hint", owner _x]; 
		};
	} forEach _spawnees;
	sleep 1;
	{
		if (isPlayer _x ) then {
			["Deploying now!"] remoteExec ["hint", owner _x];
		};
	} forEach _spawnees;
};

if (count _spawnees > 0) then
{
	// 2 second before teleport, apply screen blackout (for players)
	{
		if (isPlayer _x ) then 
		{
			[0,"BLACK",2,0] remoteExec ["BIS_fnc_fadeEffect", owner _x];
		};
	} forEach _spawnees;
	sleep 2;
	// at 0 seconds, teleport units and clear the screen (for players)
	{
		_emptyPos = _toPos findEmptyPosition [0, 10];
		if (count _emptyPos == 0) then 
		{
			_emptyPos = _toPos;
		};
		_x setPosATL _emptyPos;
		if (isPlayer _x) then 
		{
			[] remoteExec ["HNDM_fnc_stopSpectate", owner _x];
			[""] remoteExec ["hintSilent", owner _x];
			[1,"BLACK",1,0] remoteExec ["BIS_fnc_fadeEffect", owner _x];
		};
	} forEach _spawnees;
	[_chat, _deployMessage] remoteExec ["sideChat"];
};

[missionNamespace, "HNDM_deployingInProgress", false] call BIS_fnc_setServerVariable;

true;

