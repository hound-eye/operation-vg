//createSimpleObject ["a3\weapons_f\ammoboxes\bags\backpack_tortila.p3d",[11681.1,4095.66,1.52588e-005]]
_spawns=[];
_spawns pushBack ["deploy_west", getPosATL spawn_west];
_spawns pushBack ["deploy_hike", getPosATL spawn_hike];
_spawns pushBack ["deploy_safehouse", [9674.14,4112.56,0]];

missionNamespace setVariable ["hndm_spawns", _spawns, true];

sleep 3;
test_table setVariable ["HNDM_test_objects", nearestObjects [test_table, [], 3], true];
intel_table setVariable ["HNDM_intel_objects", nearestObjects [intel_table, [], 3], true];
money_table setVariable ["HNDM_money_objects", nearestObjects [money_table, [], 3], true]; 

sleep 5;

execVM "holsterPistolsAI.sqf";