params["_position"];

[0,"BLACK",2,0] call BIS_fnc_fadeEffect;
[{
	_position = parseSimpleArray _this;
	[1,"BLACK",1,0] call BIS_fnc_fadeEffect;
	_emptyPos = _position findEmptyPosition [0, 10];
	if (count _emptyPos == 0) then 
	{
		_emptyPos = _position;
	};
	player setPosATL _emptyPos;
}, _position, 5] call CBA_fnc_waitAndExecute;
