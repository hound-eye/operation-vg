#include "commons.hpp"

waitUntil { !isNull findDisplay DIALOG_LOADOUT_IDD };

_loadouts = missionNamespace getVariable ["ace_arsenal_defaultLoadoutsList", ""];
disableSerialization;
_gui_list = findDisplay DIALOG_LOADOUT_IDD displayCtrl DIALOG_LOADOUT_LIST_IDC;

HNDM_updateUVBlist =
{
	params["_mode", "_containerArray"];
	// 0 - uniform, 1 - vest, 2 - backpack
	private _finalItems = [];

	{
		copyToClipboard str (_containerArray);
		_classname = _x select 0;

		if (typeName _classname == "ARRAY") then {
			systemChat "found weapon?container?";
		} else {
			// systemChat str (_classname);
			if ( isClass (configFile >> "CfgWeapons" >> _classname)) then {
				systemChat ("found weapon" + _classname);
				_var = _classname;
				_finalItems pushBack _var;
			} else {
				if ( isClass (configFile >> "CfgMagazines" >> _classname)) then {
					_count = _x select 1;
					//systemChat str (_count);
					_var = "(x" + str(_count) + ") " + getText (configFile >> "cfgMagazines" >> _classname >> "displayName");
					systemChat _var;
					_finalItems pushBack _var;
				} else {
					systemChat str "found something ";
					_var = _classname;
					_finalItems pushBack _var;
					systemChat str (_forEachIndex);
				};
			};
		}
	} forEach (_containerArray select 1);

	private "_text";
	switch (_mode) do
	{
		case 0: { _text = findDisplay DIALOG_LOADOUT_IDD displayCtrl DIALOG_LOADOUT_UNIFORM_TEXT; };
		case 1: { _text = findDisplay DIALOG_LOADOUT_IDD displayCtrl DIALOG_LOADOUT_VEST_TEXT; };
		case 2: { _text = findDisplay DIALOG_LOADOUT_IDD displayCtrl DIALOG_LOADOUT_BACKPACK_TEXT; };
		default { hint "sus" };
	};
	//_separator = toString[13] + toString[10];
	_separator = "<br/>";
	_text ctrlSetStructuredText (parseText (_finalItems joinString _separator));
};


HNDM_updateWeaponAttachmentsImages =
{
	params["_mode", "_weaponArray"];
	private "_opticsPicture";
	private "_opticsTooltip";

	// handle secondary & launcher attachments
	_optics = _weaponArray select 3;
	if (isNil "_optics") then { _opticsPicture = ""; _opticsTooltip = "" } else { 
		_opticsPicture = getText (configFile >> "cfgWeapons" >> _optics >> "picture");
		_opticsTooltip = getText (configFile >> "cfgWeapons" >> _optics >> "displayName");
	};
	ctrlSetText [DIALOG_LOADOUT_PRIMARY_OPTICS_PICTURE, _opticsPicture];
	//ctrlSetTooltip [DIALOG_LOADOUT_PRIMARY_OPTICS_PICTURE, _opticsTooltip];
};

HNDM_updateWeaponData =
{
	params ["_loadout"];
	_loadoutArray = parseSimpleArray _loadout select 0;

	private ["_primaryWeaponPicture", "_secondaryWeaponPicture", "_launcherWeaponPicture"];
	private ["_primaryWeaponTooltip", "_secondaryWeaponTooltip", "_launcherWeaponTooltip"];

	_primary = _loadoutArray select 0 select 0;
	if (isNil "_primary") then { _primaryWeaponPicture = ""; _primaryWeaponTooltip = "" } else { 
			_primaryWeaponPicture = getText (configFile >> "cfgWeapons" >> _primary >> "picture");
			_primaryWeaponTooltip = getText (configFile >> "cfgWeapons" >> _primary >> "displayName");
			[0, _loadoutArray select 0] call HNDM_updateWeaponAttachmentsImages;
	};
	ctrlSetText [DIALOG_LOADOUT_PRIMARY_PICTURE, _primaryWeaponPicture];
	//ctrlSetTooltip [DIALOG_LOADOUT_PRIMARY_PICTURE, _primaryWeaponTooltip];
	_secondary = _loadoutArray select 1 select 0;
	if (isNil "_secondary") then { _secondaryWeaponPicture = "" } else { 
			_secondaryWeaponPicture = getText (configFile >> "cfgWeapons" >> _secondary >> "picture")
			//[1] call handleAttachments;
		};
	ctrlSetText [DIALOG_LOADOUT_SECONDARY_PICTURE, _secondaryWeaponPicture];

	_launcher = _loadoutArray select 2 select 0;
	if (isNil "_launcher") then { _launcherWeaponPicture = "" } else { _launcherWeaponPicture = getText (configFile >> "cfgWeapons" >> _launcher >> "picture")};
	ctrlSetText [DIALOG_LOADOUT_LAUNCHER_PICTURE, _launcherWeaponPicture];

	//Populate uniform/text/backpack
	[0, _loadoutArray select 3] call HNDM_updateUVBlist;
	[1, _loadoutArray select 4] call HNDM_updateUVBlist;
	[2, _loadoutArray select 5] call HNDM_updateUVBlist;
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
[_loadout] call HNDM_updateWeaponData;

_gui_list ctrlAddEventHandler ["LBSelChanged", {
	params ["_control", "_lbCurSel"];
	_loadout = lbData [DIALOG_LOADOUT_LIST_IDC, _lbCurSel];
	[_loadout] call HNDM_updateWeaponData;
}];

_button = findDisplay DIALOG_LOADOUT_IDD displayCtrl DIALOG_LOADOUT_BUTTON;

_button ctrlAddEventHandler ["ButtonClick", {
	params["_control"];
	_loadout = lbData [DIALOG_LOADOUT_LIST_IDC, lbCurSel DIALOG_LOADOUT_LIST_IDC];
	_loadoutArray = parseSimpleArray _loadout select 0;
	systemChat str (_loadoutArray);
	copyToClipboard str (_loadoutArray);
	player setUnitLoadout _loadoutArray;
	closeDialog 1;
}];
