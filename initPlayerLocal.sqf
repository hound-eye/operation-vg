// add actions for briefing board slides
execVM "configureBriefingBoard.sqf";
// enable diary entries
execVM "configureDiary.sqf";

// configure spectator action at main base
spectator_screen addAction ["<t color='#00FF00'>Spectator</t>", HNDM_fnc_spectate, [], 1, true, true, "", "_this distance _target < 3"];

// configure respawn action for ammo boxes

// enable diary entries
execVM "configureZenModules.sqf";

// init.sqf
//  ["ace_arsenal_displayOpened", {
//     params["_display"];
// 	_idc=1003;
//     systemChat "sus";
//     _button = _display displayCtrl _idc;
// 	systemChat (ctrl _button);
// 	copyToClipboard str (ctrl _idc);
	
// 	call compile (buttonAction _idc);
// }] call CBA_fnc_addEventHandler;