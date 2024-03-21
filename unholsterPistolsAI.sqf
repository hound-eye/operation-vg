{
	if (!isPlayer _x && {currentWeapon _x == handgunWeapon _x}) then {
		_x action ['SwitchWeapon', _x, _x, 100];
	};
} forEach allUnits;
