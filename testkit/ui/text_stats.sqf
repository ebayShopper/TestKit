format [
"
Humanity: %1\n
Temperature: %2\n
Blood: %3\n
BloodType: %4\n
Hunger: %5\n
Thirst: %6\n
BanditKills: %7  Confirmed: %8\n
HumanKills: %9  Confirmed: %10\n
ZombieKills: %11\n
Headshots: %12\n
Type: %13\n
\n
FPS: %14\n
Players: %15\n
AI: %16\n
Animals: %17 Global / %18 MaxGlobal\n
Zombies: %19 Global / %20 MaxGlobal
",
round (player getVariable ["humanity",0]),
round dayz_temperatur,
round r_player_blood,
player getVariable ["blood_type",0],
round dayz_hunger,
round dayz_thirst,	
player getVariable ["banditKills",0],
player getVariable ["ConfirmedBanditKills",0],
player getVariable ["humanKills",0],
player getVariable ["ConfirmedHumanKills",0],
player getVariable ["zombieKills",0],
player getVariable ["headShots",0],
typeOf (vehicle player),
round diag_fps,
{isPlayer _x} count allUnits,
{!isPlayer _x} count allUnits,
dayz_currentGlobalAnimals,
dayz_maxGlobalAnimals,
dayz_currentGlobalZombies,
dayz_maxGlobalZeds
]