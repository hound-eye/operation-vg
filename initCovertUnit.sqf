params ["_u"];
_u setCaptive true;
_u addEventHandler ["fired",{[_this] execVM "blowCover.sqf"}];