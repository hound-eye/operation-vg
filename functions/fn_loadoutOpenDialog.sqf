#include "..\commons.hpp"

params["_display"];

_loadouts = missionNamespace getVariable ["ace_arsenal_defaultLoadoutsList", ""];
_loadouts = [_loadouts, [], {_x select 0}, "ASCEND"] call BIS_fnc_sortBy;
disableSerialization;
_gui_list = _display displayCtrl DIALOG_LOADOUT_LIST_IDC;

HNDM_nilToEmptyArrays=
{
	params["_inputContainer"];
	private _outputContainer = [];
	{
		if (isNil "_x") then {
			_outputContainer pushBack []; 
		} else {
			_outputContainer pushBack _x;
		}
	} forEach _inputContainer;
	_outputContainer;
};

HNDM_setCtrlTooltip=
{
	params["_idc","_text"];
	_control = findDisplay DIALOG_LOADOUT_IDD displayCtrl _idc;
	_control ctrlSetTooltip _text;
};

HNDM_updateOtherItems = 
{
	params["_loadout"];
	// get binos, helmet, nvg, glasses
	// get map, gps, radio, compass, watch
	private _output=[];
	private _itemlist=_loadout select 9; 
	_itemlist pushBack (_loadout select 6);
	_itemlist pushBack (_loadout select 7);
	_itemlist pushBack (_loadout select 8);
	{
		private _itemClass=_x;
		if (typeName _x == "ARRAY") then {
			_itemClass = _itemClass select 0;
		};
		if (isNil "_itemClass") then {
			_itemClass = "";
		};
		_itemName = getText ([_itemClass] call CBA_fnc_getItemConfig >> "displayName");
		if (_itemName != "") then { _output pushBack _itemName };
	} forEach _itemlist;
	
	_text = findDisplay DIALOG_LOADOUT_IDD displayCtrl DIALOG_LOADOUT_OTHER_TEXT;
	_separator = ",";
	_text ctrlSetStructuredText (parseText (_output joinString _separator));
};

HNDM_updateUVBlist =
{
	params["_mode", "_containerArray"];
	// 0 - uniform, 1 - vest, 2 - backpack
	private _finalItems = [];

	// when no gear in the slot 
	if (count _containerArray == 0) then {
		_containerArray=[""];
	};

	private ["_containerName","_containerItems"];
	_containerName=_containerArray select 0;
	_containerItems=_containerArray select 1;
	{
		if (typeName _x == "ARRAY" && {count _x != 0}) then {
			private _classname = _x select 0;
			if (typeName _classname == "ARRAY") then {
				// item is a weapon, so we need to take its name
				_classname = _classname select 0;
			};
			if ( isClass (configFile >> "CfgWeapons" >> _classname)) then {
				_nextParam = _x select 1;
				if (typeName _nextParam == "BOOL") then {
					// item is backpack or vest
					_var = getText (configFile >> "cfgWeapons" >> _classname >> "displayName");
					_finalItems pushBack _var;
				} else {
					_count = _x select 1;
					_var =  "(x" + str(_count) + ") " + getText (configFile >> "cfgWeapons" >> _classname >> "displayName");
					_finalItems pushBack _var;
				};
			} else {
				if ( isClass (configFile >> "CfgMagazines" >> _classname)) then {
					_count = _x select 1;
					_var = "(x" + str(_count) + ") " + getText (configFile >> "cfgMagazines" >> _classname >> "displayName");
					_finalItems pushBack _var;
				} else {
					_var = "unknown item: " + _classname;
					_finalItems pushBack _var;
				};
			};
		} else {
		};
	} forEach ([_containerItems] call HNDM_nilToEmptyArrays);

	private "_text";
	switch (_mode) do
	{
		case 0: { _text = findDisplay DIALOG_LOADOUT_IDD displayCtrl DIALOG_LOADOUT_UNIFORM_TEXT; };
		case 1: { _text = findDisplay DIALOG_LOADOUT_IDD displayCtrl DIALOG_LOADOUT_VEST_TEXT; };
		case 2: { _text = findDisplay DIALOG_LOADOUT_IDD displayCtrl DIALOG_LOADOUT_BACKPACK_TEXT; };
	};
	_separator = "<br/>";
	_text ctrlSetStructuredText (parseText (_finalItems joinString _separator));
};

HNDM_updateWeaponAttachmentsImages =
{
	params["_mode", ["_weaponArray", ["", "", "", "", "", "", ""]]];
	private _slotsToUpdate = [];
	
	switch (_mode) do
	{
		case 0: { 
			_slotsToUpdate = [
				DIALOG_LOADOUT_PRIMARY_MUZZLE_PICTURE,
				DIALOG_LOADOUT_PRIMARY_LIGHT_PICTURE,
				DIALOG_LOADOUT_PRIMARY_OPTICS_PICTURE,
				DIALOG_LOADOUT_PRIMARY_MAG_PICTURE,
				DIALOG_LOADOUT_PRIMARY_GL_PICTURE,
				DIALOG_LOADOUT_PRIMARY_BIPOD_PICTURE
			] };
		case 1: { 
			_slotsToUpdate = [
				DIALOG_LOADOUT_SECONDARY_MUZZLE_PICTURE,
				DIALOG_LOADOUT_SECONDARY_LIGHT_PICTURE,
				DIALOG_LOADOUT_SECONDARY_OPTICS_PICTURE,
				DIALOG_LOADOUT_SECONDARY_MAG_PICTURE,
				1,
				1
			] };
		case 2: { 
			_slotsToUpdate = [
				1,
				1,
				DIALOG_LOADOUT_LAUNCHER_OPTICS_PICTURE,
				DIALOG_LOADOUT_LAUNCHER_MAG_PICTURE,
				1,
				1
			] };
	};
	{
		_idc_for_slot=_x;
		if (_idc_for_slot == 1) then { continue };
		_attachment=_weaponArray select (_forEachIndex+1);
		if (typeName _attachment == "ARRAY") then {
			if (count _attachment == 0) then {
				_attachment="";
			} else {
				_attachment =_attachment select 0;
			}
		};
		private ["_attachmentPicture", "_attachmentTooltip"];

		if (isNil "_attachment" || _attachment == "") then {
			_attachmentPicture = "";
			_attachmentTooltip = "" ;
		} else {
			_configPath = [_attachment] call CBA_fnc_getItemConfig;
			_attachmentPicture = getText (_configPath >> "picture");
			_attachmentTooltip = getText (_configPath >> "displayName");
		};
		ctrlSetText [_idc_for_slot, _attachmentPicture];
		[_idc_for_slot, _attachmentTooltip] call HNDM_setCtrlTooltip;
	} forEach _slotsToUpdate;
};

HNDM_updateWeaponData =
{
	params ["_loadout"];
	_loadoutArray = (parseSimpleArray _loadout) select 0;

	private ["_primaryWeaponPicture", "_secondaryWeaponPicture", "_launcherWeaponPicture"];
	private ["_primaryWeaponTooltip", "_secondaryWeaponTooltip", "_launcherWeaponTooltip"];

	_primary = _loadoutArray select 0 select 0;
	if (isNil "_primary") then { 
		_primaryWeaponPicture = "";
		_primaryWeaponTooltip = "";
		[0] call HNDM_updateWeaponAttachmentsImages; 
	} else { 
		_primaryWeaponPicture = getText (configFile >> "cfgWeapons" >> _primary >> "picture");
		_primaryWeaponTooltip = getText ([_primary] call CBA_fnc_getItemConfig >> "displayName");
		[0, _loadoutArray select 0] call HNDM_updateWeaponAttachmentsImages;
	};
	ctrlSetText [DIALOG_LOADOUT_PRIMARY_PICTURE, _primaryWeaponPicture];
	[DIALOG_LOADOUT_PRIMARY_PICTURE, _primaryWeaponTooltip] call HNDM_setCtrlTooltip;
	//ctrlSetTooltip [DIALOG_LOADOUT_PRIMARY_PICTURE, _primaryWeaponTooltip];
	_secondary = _loadoutArray select 2 select 0;
	if (isNil "_secondary") then { 
		_secondaryWeaponPicture = "";
		_secondaryWeaponTooltip = "";
		[1] call HNDM_updateWeaponAttachmentsImages;
	} else {
		_configPath = _secondary call CBA_fnc_getItemConfig;
		_secondaryWeaponPicture = getText (_configPath >> "picture");
		_secondaryWeaponTooltip = getText (_configPath >> "displayName");
		[1, _loadoutArray select 2] call HNDM_updateWeaponAttachmentsImages;
	};
	ctrlSetText [DIALOG_LOADOUT_SECONDARY_PICTURE, _secondaryWeaponPicture];
	[DIALOG_LOADOUT_SECONDARY_PICTURE, _secondaryWeaponTooltip] call HNDM_setCtrlTooltip;
	_launcher = _loadoutArray select 1 select 0;
	if (isNil "_launcher") then { 
		_launcherWeaponPicture = "";
		_launcherWeaponTooltip = "";
		[2] call HNDM_updateWeaponAttachmentsImages;
	} else { 
		_configPath = _launcher call CBA_fnc_getItemConfig;
		_launcherWeaponPicture = getText (_configPath >> "picture");
		_launcherWeaponTooltip = getText (_configPath >> "displayName");
		[2, _loadoutArray select 1] call HNDM_updateWeaponAttachmentsImages;
	};
	ctrlSetText [DIALOG_LOADOUT_LAUNCHER_PICTURE, _launcherWeaponPicture];
	[DIALOG_LOADOUT_LAUNCHER_PICTURE, _launcherWeaponTooltip] call HNDM_setCtrlTooltip;

	[0, _loadoutArray select 3] call HNDM_updateUVBlist;
	[1, _loadoutArray select 4] call HNDM_updateUVBlist;
	[2, _loadoutArray select 5] call HNDM_updateUVBlist;

	[_loadoutArray] call HNDM_updateOtherItems;
};

// fill data
{
	_loadoutName=_x select 0;
	_loadoutData=_x select 1;
	// for multiplayer, filter the kit by the role prefix
	if (isMultiplayer) then {
		if (([roleDescription player, _loadoutName] call BIS_fnc_inString ) ||
		((roleDescription player == "Infiltrator") && (["Guerrilla", _loadoutName] call BIS_fnc_inString ))) then {
			_index = lbAdd [DIALOG_LOADOUT_LIST_IDC, _loadoutName];
			lbSetData [DIALOG_LOADOUT_LIST_IDC, _index, str (_loadoutData)];
		};
	} else {
		_index = lbAdd [DIALOG_LOADOUT_LIST_IDC, _loadoutName];
		lbSetData [DIALOG_LOADOUT_LIST_IDC, _index, str (_loadoutData)];
	};
} forEach _loadouts;

// select first loadout
lbSetCurSel [DIALOG_LOADOUT_LIST_IDC,0];
_loadout = lbData [DIALOG_LOADOUT_LIST_IDC, 0];
if (!isNil _loadout) then {
	[_loadout] call HNDM_updateWeaponData;
};

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
	player setUnitLoadout _loadoutArray;
	closeDialog 1;
}];
