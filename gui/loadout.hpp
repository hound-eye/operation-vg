
class DialogLoadoutMenu
{
	idd = 7986;
	onLoad = "_this spawn HNDM_fnc_loadoutOpenDialog";
	class controls
	{
		#include "\a3\ui_f\hpp\definecommoncolors.inc"
		#include "\a3\ui_f\hpp\definecommongrids.inc"

				////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT START (by Houndeye, v1.063, #Weloba)
		////////////////////////////////////////////////////////

		class background: RscText
		{
			idc = 1000;
			x = 0.292719 * safezoneW + safezoneX;
			y = 0.225 * safezoneH + safezoneY;
			w = 0.4125 * safezoneW;
			h = 0.55 * safezoneH;
			colorBackground[] = {0,0,0,0.9};
		};
		class imageBackgound: RscText
		{
			idc = 1001;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.247 * safezoneH + safezoneY;
			w = 0.37125 * safezoneW;
			h = 0.154 * safezoneH;
			colorBackground[] = {1,1,1,0.2};
		};
		class RscListbox_1500: RscListBox
		{
			colorSelect[] = {0.98,0.65,0,1};
			colorSelectBackground[] = {0.24,0.24,0.24,0.6};
			colorScrollBar[] = {1,0,0,1};

			idc = 1002;
			text = "Loadout name"; //--- ToDo: Localize;
			x = 0.360781 * safezoneW + safezoneX;
			y = 0.665 * safezoneH + safezoneY;
			w = 0.170156 * safezoneW;
			h = 0.088 * safezoneH;
			colorText[] = {0.85,0.47,0,1};
			colorBackground[] = {0.12,0.12,0.12,1};
		};
		class RscButtonMenu_2400: RscButtonMenu
		{
			idc = 2400;
			text = "Apply"; //--- ToDo: Localize;
			x = 0.572187 * safezoneW + safezoneX;
			y = 0.71 * safezoneH + safezoneY;
			w = 0.0525 * safezoneW;
			h = 0.042 * safezoneH;
			colorBackground[] = {0,0.5,0,0.3};
		};
		class RscButtonMenuCancel_2700: RscButtonMenuCancel
		{
			x = 0.637812 * safezoneW + safezoneX;
			y = 0.71 * safezoneH + safezoneY;
			w = 0.0525 * safezoneW;
			h = 0.042 * safezoneH;
			colorBackground[] = {0.5,0,0,0.3};
		};
		class RscFrame_1802: RscFrame
		{
			idc = 1800;
			text = "Weapons"; //--- ToDo: Localize;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.236 * safezoneH + safezoneY;
			w = 0.37125 * safezoneW;
			h = 0.165 * safezoneH;
			colorBackground[] = {1,1,1,1};
			colorActive[] = {1,1,1,1};
			sizeEx = 1 * GUI_GRID_H;
		};
		class RscFrame_1803: RscFrame
		{
			idc = 1803;
			text = "Backpack"; //--- ToDo: Localize;
			x = 0.572187 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.176 * safezoneH;
			colorBackground[] = {1,1,1,1};
			colorActive[] = {1,1,1,1};
			sizeEx = 1 * GUI_GRID_H;
		};
		class VestFrame: RscFrame
		{
			idc = 1802;
			text = "Vest"; //--- ToDo: Localize;
			x = 0.44328 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.176 * safezoneH;
			colorBackground[] = {1,1,1,1};
			colorActive[] = {1,1,1,1};
			sizeEx = 1 * GUI_GRID_H;
		};
		class RscFrame_1801: RscFrame
		{
			idc = 1801;
			text = "Uniform"; //--- ToDo: Localize;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.401 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.176 * safezoneH;
			colorBackground[] = {1,1,1,1};
			colorActive[] = {1,1,1,1};
			sizeEx = 1 * GUI_GRID_H;
		};
		class RscText_1003: RscText
		{
			idc = 1003;
			style = 16;
			text = "Select preset:"; //--- ToDo: Localize;
			x = 0.303125 * safezoneW + safezoneX;
			y = 0.668 * safezoneH + safezoneY;
			w = 0.0525 * safezoneW;
			h = 0.084 * safezoneH;
		};
		class RscControlsGroup_2300: RscControlsGroup
		{
			idc = 2300;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.154 * safezoneH;
			class Controls
			{
				class UniformText: RscStructuredText
				{
					idc = 1101;
					x = -2.9197e-008 * safezoneW;
					y = 1.63913e-008 * safezoneH;
					w = 0.113437 * safezoneW;
					h = 0.154 * safezoneH;
				};
			};
		};
		class RscControlsGroup_2301: RscControlsGroup
		{
			idc = 2301;
			x = 0.443281 * safezoneW + safezoneX;
			y = 0.423 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.154 * safezoneH;
			class Controls
			{
				class VestText: RscStructuredText
				{
					idc = 1100;
					x = 2.33576e-007 * safezoneW;
					y = 1.63913e-008 * safezoneH;
					w = 0.113437 * safezoneW;
					h = 0.154 * safezoneH;
				};
			};
		};
		class RscControlsGroup_2302: RscControlsGroup
		{
			idc = 2302;
			x = 0.572187 * safezoneW + safezoneX;
			y = 0.412 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.165 * safezoneH;
			class Controls
			{
				class BackpackText: RscStructuredText
				{
					idc = 1102;
					x = 4.91738e-007 * safezoneW;
					y = 0.011 * safezoneH;
					w = 0.113437 * safezoneW;
					h = 0.154 * safezoneH;
				};
			};
		};
		class RscPictureSecondaryOptics: RscPicture
		{
			idc = 1214;
			text = "#(argb,8,8,3)color(1,1,1,0.3)";
			x = 0.505156 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class SpecialConrolGroup: RscControlsGroup
		{
			idc = 2303;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.599 * safezoneH + safezoneY;
			w = 0.37125 * safezoneW;
			h = 0.044 * safezoneH;
			class Controls
			{
				class RscStructuredText_1103: RscStructuredText
				{
					idc = 1103;
					x = -2.9197e-008 * safezoneW;
					y = 0.011 * safezoneH;
					w = 0.37125 * safezoneW;
					h = 0.044 * safezoneH;
				};
			};
		};
		class RscFrame_1804: RscFrame
		{
			idc = 1804;
			text = "Other"; //--- ToDo: Localize;
			x = 0.314375 * safezoneW + safezoneX;
			y = 0.588 * safezoneH + safezoneY;
			w = 0.37125 * safezoneW;
			h = 0.055 * safezoneH;
			sizeEx = 1 * GUI_GRID_H;
		};
		class RscPicturePrimary: RscPicture
		{
			idc = 1200;
			text = "#(argb,8,8,3)color(1,1,1,0.3)";
			x = 0.324687 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.12375 * safezoneW;
			h = 0.077 * safezoneH;
			colorBackground[] = {1,1,1,0.5};
		};
		class RscPictureLauncher: RscPicture
		{
			idc = 1201;
			text = "#(argb,8,8,3)color(1,1,1,0.3)";
			x = 0.561875 * safezoneW + safezoneX;
			y = 0.258 * safezoneH + safezoneY;
			w = 0.113437 * safezoneW;
			h = 0.077 * safezoneH;
			colorBackground[] = {1,1,1,0.5};
		};
		class RscPictureSecondary: RscPicture
		{
			idc = 1202;
			text = "#(argb,8,8,3)color(1,1,1,0.3)";
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.269 * safezoneH + safezoneY;
			w = 0.0825 * safezoneW;
			h = 0.066 * safezoneH;
			colorBackground[] = {1,1,1,0.5};
		};
		class RscPicturePrimaryOptics: RscPicture
		{
			idc = 1203;
			text = "#(argb,8,8,3)color(1,1,1,0.3)";
			x = 0.386562 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class RscPicturePrimaryMag: RscPicture
		{
			idc = 1204;
			text = "#(argb,8,8,3)color(1,1,1,0.3)";
			x = 0.427812 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class RscPicturePrimaryGL: RscPicture
		{
			idc = 1205;
			text = "#(argb,8,8,3)color(1,1,1,0.3)";
			x = 0.407187 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class RscPicturePrimaryMuzzle: RscPicture
		{
			idc = 1206;
			text = "#(argb,8,8,3)color(1,1,1,0.3)";
			x = 0.324687 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class RscPicturePrimaryLight: RscPicture
		{
			idc = 1207;
			text = "#(argb,8,8,3)color(1,1,1,0.3)";
			x = 0.365937 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class RscPicturePrimaryBipod: RscPicture
		{
			idc = 1208;
			text = "#(argb,8,8,3)color(1,1,1,0.3)";
			x = 0.345312 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class RscPictureLauncherMag: RscPicture
		{
			idc = 1209;
			text = "#(argb,8,8,3)color(1,1,1,0.3)";
			x = 0.561875 * safezoneW + safezoneX;
			y = 0.313 * safezoneH + safezoneY;
			w = 0.0928125 * safezoneW;
			h = 0.066 * safezoneH;
		};
		class RscPictureLauncherOptics: RscPicture
		{
			idc = 1210;
			text = "#(argb,8,8,3)color(1,1,1,0.3)";
			x = 0.654688 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class RscPictureSecondaryMuzzle: RscPicture
		{
			idc = 1211;
			text = "#(argb,8,8,3)color(1,1,1,0.3)";
			x = 0.463906 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.044 * safezoneH;
			tooltip = "SUS"; //--- ToDo: Localize;
		};
		class RscPictureSecondaryMag: RscPicture
		{
			idc = 1212;
			text = "#(argb,8,8,3)color(1,1,1,0.3)";
			x = 0.525781 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.044 * safezoneH;
		};
		class RscPictureSecondaryLight: RscPicture
		{
			idc = 1213;
			text = "#(argb,8,8,3)color(1,1,1,0.3)";
			x = 0.484531 * safezoneW + safezoneX;
			y = 0.335 * safezoneH + safezoneY;
			w = 0.020625 * safezoneW;
			h = 0.044 * safezoneH;
		};
		////////////////////////////////////////////////////////
		// GUI EDITOR OUTPUT END
		////////////////////////////////////////////////////////
	};
};
