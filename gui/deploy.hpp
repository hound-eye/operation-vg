class DialogDeployMenu
{
	idd = 7987;
	onLoad = "_this spawn HNDM_fnc_deployOpenDialog";
	class controls
	{
		#include "\a3\ui_f\hpp\definecommoncolors.inc"
		#include "\a3\ui_f\hpp\definecommongrids.inc"
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Houndeye, v1.063, #Menybo)
		////////////////////////////////////////////////////////

		class background: RscText
		{
			idc = 1000;

			x = 0.3275 * safezoneW + safezoneX;
			y = 0.348 * safezoneH + safezoneY;
			w = 0.347813 * safezoneW;
			h = 0.196 * safezoneH;
			colorBackground[] = {0,0,0,0.5};
		};
		class RscFrame_1800: RscFrame
		{
			idc = 1800;

			text = "Select destination"; //--- ToDo: Localize;
			x = 0.3275 * safezoneW + safezoneX;
			y = 0.334 * safezoneH + safezoneY;
			w = 0.347813 * safezoneW;
			h = 0.21 * safezoneH;
			sizeEx = 1 * GUI_GRID_H;
		};
		class RscButtonMenu_2400: RscButtonMenu
		{
			idc = 2400;

			text = "Deploy"; //--- ToDo: Localize;
			x = 0.57875 * safezoneW + safezoneX;
			y = 0.402 * safezoneH + safezoneY;
			w = 0.07875 * safezoneW;
			h = 0.042 * safezoneH;
			colorBackground[] = {0,1,-1,0.5};
		};
		class RscButtonMenuCancel_2700: RscButtonMenuCancel
		{
			x = 0.57875 * safezoneW + safezoneX;
			y = 0.472 * safezoneH + safezoneY;
			w = 0.07875 * safezoneW;
			h = 0.042 * safezoneH;
		};
		class RscListbox_1500: RscListBox
		{
			idc = 1500;

			x = 0.335938 * safezoneW + safezoneX;
			y = 0.388 * safezoneH + safezoneY;
			w = 0.232031 * safezoneW;
			h = 0.088 * safezoneH;
		};
		class RscStructuredText_1100: RscStructuredText
		{
			idc = 1100;

			x = 0.335 * safezoneW + safezoneX;
			y = 0.489 * safezoneH + safezoneY;
			w = 0.232031 * safezoneW;
			h = 0.044 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};