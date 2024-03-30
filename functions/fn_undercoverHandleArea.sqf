/*
	Author: Houndeye
	Description:
		Notify undercover units about being in restricted area
	Parameter(s):
		0: OBJECT - unit to notify
	Returns:
		BOOLEAN
	Examples:
		[unit] call HNDM_fnc_undercoverHandleArea.
*/
/* Private variables */


// start countdown loop, showing warning and time before blowCover
// exit from loop, if cover is already blown
// trigger blowCover if countdown runs out 

/* Stops spectator script */
params["_unitsList"];
if (!(player getVariable ["HNDM_UC_enabled", false])) exitWith {
	//systemChat "unit is not undercover!";
};
[{ 
  params["_unitsList", "_handlerId"];
  systemChat str (_unitsList);
  if (isNil {player getVariable "HNDM_UC_restricted_area_time"}) then {
	player setVariable ["HNDM_UC_restricted_area_time", diag_tickTime, false]; 
  };
  if (player in _unitsList) then {
	// calculate time spent in the trigger
	_new_time = round (diag_tickTime - (player getVariable ["HNDM_UC_restricted_area_time", 0])); 
	// systemChat format ["You are in restricted area for %1 seconds",_new_time];
	[player] call HNDM_fnc_undercoverSuspect;
	if (_new_time >= 7) then {
		// unit blows his cover
		player setVariable ["HNDM_UC_restricted_area_time", nil, false]; 
		_handlerId call CBA_fnc_removePerFrameHandler;
		[player] call HNDM_fnc_undercoverRemove;
	}
  } else {
	// unit is in the clear, do the loadout check again
	// systemChat "You left restricted area";
	player setVariable ["HNDM_UC_restricted_area_time", nil, false]; 
  	_handlerId call CBA_fnc_removePerFrameHandler;
	player call HNDM_fnc_undercoverEvaluateArmed;
  };
}, 
1, 
_unitsList] call CBA_fnc_addPerFrameHandler;
