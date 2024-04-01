#include "..\commons.hpp"

params["_display"];

_deployments = missionNamespace getVariable ["hndm_spawns", []];
_deployments = [_deployments, [], {markerText (_x getVariable "hndm_attachedMarker")}, "ASCEND"] call BIS_fnc_sortBy;
disableSerialization;

_gui_list = _display displayCtrl DIALOG_DEPLOY_LIST_IDC;

{
	_deployment_name = markerText (_x getVariable "hndm_attachedMarker");
	_deployment_position = getPosATL _x;
	_index = lbAdd [DIALOG_DEPLOY_LIST_IDC, _deployment_name];
	lbSetData [DIALOG_DEPLOY_LIST_IDC, _index, str (_deployment_position)];
} forEach _deployments;

ctrlEnable [DIALOG_DEPLOY_BUTTON_DEPLOY, false];

HNDM_handleSelect = 
{
	params["_curSel"];
	_name = lbText [DIALOG_DEPLOY_LIST_IDC, _curSel];
	systemChat format ["cur sel: %3, name: %1, var: %2", _name, player getVariable ["HNDM_UC_enabled", false], _curSel];

	_control = _display displayCtrl DIALOG_DEPLOY_BUTTON_DEPLOY;

	if (
		(["undercover only", _name] call BIS_fnc_inString ) && { !(player getVariable ["HNDM_UC_enabled", false]) }
	) then {
		_control ctrlSetBackgroundColor [0,0,0,0.5];
		ctrlEnable [DIALOG_DEPLOY_BUTTON_DEPLOY, false];
		ctrlSetText [DIALOG_DEPLOY_INFO, "Only for Undercover"];
	} else {
		_control ctrlSetBackgroundColor [0,1,-1,0.5];
		ctrlEnable [DIALOG_DEPLOY_BUTTON_DEPLOY, true];
		ctrlSetText [DIALOG_DEPLOY_INFO, ""];
	};
};

_gui_list ctrlAddEventHandler ["LBSelChanged", {
	params ["_control", "_lbCurSel"];
	_loadout = lbData [DIALOG_LOADOUT_LIST_IDC, _lbCurSel];
	[_lbCurSel] call HNDM_handleSelect;
}];


_button = _display displayCtrl DIALOG_DEPLOY_BUTTON_DEPLOY;
_button ctrlAddEventHandler ["ButtonClick", {
	params["_control"];
	_deployment = lbData [DIALOG_DEPLOY_LIST_IDC, lbCurSel DIALOG_DEPLOY_LIST_IDC];
	copyToClipboard str (_deployment);
	systemChat str (_deployment);
	[_deployment] call HNDM_fnc_deployTravelToDeployment;
	closeDialog 1;
}];
