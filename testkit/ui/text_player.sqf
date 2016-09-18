format [
"
Humanity: %1\n
Blood: %2\n
BloodType: %3\n
BanditKills: %4  Confirmed: %5\n
HumanKills: %6  Confirmed: %7\n
ZombieKills: %8\n
Headshots: %9\n
Money: %10\n
CharacterID: %11\n
Type: %12
",
round (_player getVariable ["humanity",0]),
round (_player getVariable ["USEC_BloodQty",12000]),
_player getVariable ["blood_type",0],
_player getVariable ["banditKills",0],
_player getVariable ["ConfirmedBanditKills",0],
_player getVariable ["humanKills",0],
_player getVariable ["ConfirmedHumanKills",0],
_player getVariable ["zombieKills",0],
_player getVariable ["headShots",0],
_player getVariable ["cashMoney",0],
_player getVariable ["CharacterID",0],
typeOf (vehicle _player)
]