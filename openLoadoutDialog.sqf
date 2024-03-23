#include "commons.hpp"

waitUntil { !isNull findDisplay DIALOG_LOADOUT_IDD };

_loadouts = missionNamespace getVariable ["ace_arsenal_defaultLoadoutsList", ""];

_gui_list = findDisplay DIALOG_LOADOUT_IDD displayCtrl DIALOG_LOADOUT_LIST_IDC;

HNDM_updateImages =
{
	params ["_loadout"];
	_loadoutArray = parseSimpleArray _loadout select 0;

	private ["_primaryWeaponPicture", "_secondaryWeaponPicture", "_launcherWeaponPicture"];

	_primary = _loadoutArray select 0 select 0;
	if (isNil "_primary") then { systemChat "sus1"; _primaryWeaponPicture = ""; } else {  _primaryWeaponPicture = getText (configFile >> "cfgWeapons" >> _primary >> "picture");};
	ctrlSetText [DIALOG_LOADOUT_PRIMARY_PICTURE, _primaryWeaponPicture];

	_secondary = _loadoutArray select 1 select 0;
	if (isNil "_secondary") then { _secondaryWeaponPicture = "" } else { _secondaryWeaponPicture = getText (configFile >> "cfgWeapons" >> _secondary >> "picture")};
	ctrlSetText [DIALOG_LOADOUT_SECONDARY_PICTURE, _secondaryWeaponPicture];

	_launcher = _loadoutArray select 2 select 0;
	if (isNil "_launcher") then { _launcherWeaponPicture = "" } else { _launcherWeaponPicture = getText (configFile >> "cfgWeapons" >> _launcher >> "picture")};
	ctrlSetText [DIALOG_LOADOUT_LAUNCHER_PICTURE, _launcherWeaponPicture];
};

// fill data
{
	_loadoutName=_x select 0;
	_loadoutData=_x select 1;
	_index = lbAdd [DIALOG_LOADOUT_LIST_IDC, _loadoutName];
	lbSetData [DIALOG_LOADOUT_LIST_IDC, _index, str (_loadoutData)];
} forEach _loadouts;

// select first loadout
_gui_list lbSetCurSel 0;
_loadout = lbData [DIALOG_LOADOUT_LIST_IDC, 0];
[_loadout] call HNDM_updateImages;
uiNamespace setVariable ["HNDM_selected_loadout",_loadout];

_gui_list ctrlAddEventHandler ["LBSelChanged", {
	params ["_control", "_lbCurSel"];
	_loadout = lbData [DIALOG_LOADOUT_LIST_IDC, _lbCurSel];
	[_loadout] call HNDM_updateImages;
	uiNamespace setVariable ["HNDM_selected_loadout",_loadout];
}];

_button = findDisplay DIALOG_LOADOUT_IDD displayCtrl DIALOG_LOADOUT_BUTTON;

_button ctrlAddEventHandler ["ButtonClick", {
	params["_control"];
	_loadout = lbData [DIALOG_LOADOUT_LIST_IDC, lbCurSel DIALOG_LOADOUT_LIST_IDC];
	_loadoutArray = parseSimpleArray _loadout select 0;
	systemChat str (_loadoutArray);
	//_loadout = uiNamespace getVariable "HNDM_selected_loadout";
	//_loadot = _loadout select 0;
	copyToClipboard str (_loadoutArray);
	player setUnitLoadout _loadoutArray;
	closeDialog 1;
}];

[[["rhs_weap_pkm","","","",["rhs_100Rnd_762x54mmR",100],[],""],[],["rhsusf_weap_m9","","","",["rhsusf_mag_15Rnd_9x19_FMJ",15],[],""],["U_I_C_Soldier_Para_1_F",[["ACE_fieldDressing",20],["ACE_personalAidKit",1],["ACE_epinephrine",3],["ACE_morphine",3],["ACE_splint",3],["ACE_tourniquet",2]]],["V_TacVest_oli",[["rhs_100Rnd_762x54mmR",1,100],["rhsusf_mag_15Rnd_9x19_FMJ",3,15],["rhs_mag_m67",2,1]]],["B_AssaultPack_khk",[["rhs_mag_rdg2_white",1,1],["rhs_100Rnd_762x54mmR",2,100],["rhs_mag_m67",1,1]]],"H_Booniehat_khk","",[],["ItemMap","ItemGPS","TFAR_anprc152","ItemCompass","ItemWatch",""]],[]]