//createSimpleObject ["a3\weapons_f\ammoboxes\bags\backpack_tortila.p3d",[11681.1,4095.66,1.52588e-005]]
[missionNamespace, "HNDM_allowedReinforcements", true] call BIS_fnc_setServerVariable;
[missionNamespace, "HNDM_deployingInProgress", false] call BIS_fnc_setServerVariable;

sleep 3;
intel_table setVariable ["HNDM_intel_objects", nearestObjects [intel_table, [], 3], true];  
money_table setVariable ["HNDM_money_objects", nearestObjects [money_table, [], 3], true]; 

_test_objects = nearestObjects [test_table, [], 3];
test_table setVariable ["HNDM_test_objects", _test_objects, true];  
_test_objects = +_test_objects;
// _obj_intel = nearestObjects [intel_table, [], 3];
// [missionNamespace, "HNDM_objective_intel", obj_intel]
// call BIS_fnc_setServerVariable;

// _obj_money = nearestObjects [money_table, [], 3];
// [missionNamespace, "HNDM_objective_money", _obj_money]
// call BIS_fnc_setServerVariable;

// _obj_test = nearestObjects [test_table, [], 3];
// [missionNamespace, "HNDM_objective_money", _obj_test]
// call BIS_fnc_setServerVariable;

sleep 10;

execVM "holsterPistolsAI.sqf";