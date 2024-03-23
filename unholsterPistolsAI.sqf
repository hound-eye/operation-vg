{
	if (!isPlayer _x && {primaryWeapon _x == ""}) then {
		_x selectWeapon (handgunWeapon _x);
	};
} forEach units west;
