{
	_ctrl lbAdd getText (_x >> "displayName");
	_ctrl lbSetPicture [_foreachindex,getText (_x >> "texture")];
	_ctrl lbSetTooltip [_foreachindex,getText (_x >> "displayName")];
} forEach ("true" configClasses (configFile >> "CfgRanks"));
_ctrl lbSetCurSel 0;