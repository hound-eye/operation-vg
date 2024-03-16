// add actions for briefing board slides
execVM "configureBriefingBoard.sqf";
// enable diary entries
execVM "configureDiary.sqf";

// configure spectator action at main base
spectator_screen addAction ["<t color='#00FF00'>Spectator</t>", HNDM_fnc_spectate, [], 1, true, true, "", "_this distance _target < 3"];
spectator_table addAction ["<t color='#00FFFF'>Spectator</t>", HNDM_fnc_spectate, [], 1, true, true, "", "_this distance _target < 3"];

spectator_screen addAction ["<t color='#FFFF00'>MERMANS CLUNGE</t>", {systemChat "clunge not found";}, [], 1, true, true, "", "_this distance _target < 3"];

// configure respawn action for ammo boxes

// enable diary entries
execVM "configureZenModules.sqf";