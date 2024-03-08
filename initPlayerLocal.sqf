private _weapon = currentWeapon player;
if (_weapon isEqualTo "" || _weapon isEqualTo (binocular player)) then {
	player setCaptive true;
};

undercover_switch = {
	params [
		["_unit", player, [objNull]]
		,["_weapon", currentWeapon player, [""]]
	];
	player sideChat "sussy gussy3";
	if ( _weapon isEqualTo "") exitWith {
		player sideChat "NO WEAPON";
		if !(captive _unit) then {
			hint "You are now undercover.";
		};
		player sideChat "SET UNDERCOVER";
		_unit setCaptive true;
	};
	if (captive _unit) then {
		player sideChat "UNSET UNDERCOVER1";
		hint "You are no longer undercover.";
	};
	player sideChat "UNSET UNDERCOVER2";
	_unit setCaptive false;
};

undercover_evh = ["weapon", {[_this select 0, _this select 1] call undercover_switch}] call CBA_fnc_addPlayerEventHandler;
