dayz_onBack = "";
if (!isNull findDisplay 106) then {
	findDisplay 106 displayCtrl 1209 ctrlSetText "";
};

removeBackpack player;
removeAllItems player;
removeAllWeapons player;
{ player removeMagazine _x } count (magazines player);