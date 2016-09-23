private "_bloodbag";
_bloodbag = if (dayz_classicBloodBagSystem) then {"ItemBloodbag"} else {"bloodBagONEG"};

call tk_wipeGear;
dayz_onBack = "MeleeHatchet";

player addBackpack "DZ_Backpack_EP1";
{unitBackpack player addMagazineCargoGlobal [_x,2];} count [
	"100Rnd_762x51_M240","ItemBandage",
	_bloodbag,"ItemAntibiotic","ItemEpinephrine","ItemMorphine","ItemPainkiller",
	"bloodTester","ItemHeatPack","FoodCanPotatoes","ItemSodaR4z0r"
];

{player addMagazine _x;} count [
	"15Rnd_9x19_M9SD","15Rnd_9x19_M9SD","15Rnd_9x19_M9SD",
	"100Rnd_762x51_M240","100Rnd_762x51_M240",
	"ItemBandage","ItemBandage","ItemBandage","ItemBandage","ItemAntibacterialWipe",
	_bloodbag,"ItemAntibiotic","ItemEpinephrine","ItemMorphine","ItemPainkiller",
	"FoodRabbitCooked","ItemWaterbottle","Skin_Camo1_DZ"
];
if (tk_isEpoch) then {player addMagazine "ItemBriefcase100oz";};

{player addWeapon _x;} count [
	"Mk48_CCO_DZ","M9_SD_DZ",
	"Binocular_Vector","NVGoggles",
	"ItemCompass","ItemCrowbar","Itemetool","ItemGPS",
	"ItemKnife","Itemmatchbox","Itemtoolbox"
];

player selectWeapon primaryWeapon player;
systemChat "Added standard gear";
