//client-side script
_mission = loadFile "texts\mission.html";
_enemy = loadFile "texts\enemy.html";
_terrain = loadFile "texts\terrain.html";
_troops = loadFile "texts\troops.html";
_time = loadFile "texts\time.html";
_civilians = loadFile "texts\civilians.html";

player createDiaryRecord ["Diary", ["Civilians",_civilians]];
player createDiaryRecord ["Diary", ["Time",_time]];
player createDiaryRecord ["Diary", ["Troops",_troops]];
player createDiaryRecord ["Diary", ["Terrain",_terrain]];
player createDiaryRecord ["Diary", ["Enemy",_enemy]];
player createDiaryRecord ["Diary", ["Mission",_mission]];

// clean up CBA
0 spawn {
    waitUntil {!isNil "cba_help_DiaryRecordAddons"};

    // delete whole subject
    player removeDiarySubject "cba_help_docs";
};