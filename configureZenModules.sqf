["A_Mission", "Add undercover mechanics", {[_this select 1] remoteExec ["HNDM_fnc_undercoverInit", owner (_this select 1)]}] call zen_custom_modules_fnc_register;
["A_Mission", "Remove undercover mechanics", {[_this select 1] remoteExec ["HNDM_fnc_undercoverRemove", owner (_this select 1)]}] call zen_custom_modules_fnc_register;

["A_Mission", "Holster pistols for all AI", {
		{
			if (!isPlayer _x && {currentWeapon _x == handgunWeapon _x}) then {
				systemChat "holstering weapon for " + str (_x);
				_x action ['SwitchWeapon', _x, _x, 100];
			};
		} forEach allUnits;
	}] call zen_custom_modules_fnc_register;


