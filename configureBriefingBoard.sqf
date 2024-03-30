/// add actions to control slides
briefing_screen_1 addAction ["Briefing: Gendarmerie", {briefing_screen_1 setObjectTextureGlobal [0, "images\gendarm.paa"];}, [], 1, true, true, "", "_this distance _target < 2"];
briefing_screen_1 addAction ["Briefing: HIDF", {briefing_screen_1 setObjectTextureGlobal [0, "images\hidf.paa"]}, [], 1, true, true, "", "_this distance _target < 2"];
briefing_screen_1 addAction ["Briefing: Target", {briefing_screen_1 setObjectTextureGlobal [0, "images\task_intel.paa"];}, [], 1, true, true, "", "_this distance _target < 2"];
briefing_screen_1 addAction ["Briefing: Objectives", {briefing_screen_1 setObjectTextureGlobal [0, "images\objectives.paa"];}, [], 1, true, true, "", "_this distance _target < 2"];
briefing_screen_1 addAction ["Briefing: Contact", {briefing_screen_1 setObjectTextureGlobal [0, "images\task_money.paa"];}, [], 1, true, true, "", "_this distance _target < 2"];
briefing_screen_1 addAction ["Briefing: Coast Guard", {briefing_screen_1 setObjectTextureGlobal [0, "images\task_extract.paa"];}, [], 1, true, true, "", "_this distance _target < 2"];
