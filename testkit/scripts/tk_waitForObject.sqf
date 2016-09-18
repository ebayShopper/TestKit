private ["_class","_sign","_near"];

_class = _this select 0;
_sign = _this select 1;
_near = count (nearestObjects [player,[_class],50]);

[_class,_sign,_near] spawn {
	_class = _this select 0;
	_sign = _this select 1;
	_near = _this select 2;

	waitUntil {
		uiSleep 1;
		(count (nearestObjects [player,[_class],50]) != _near)
	};

	if (!isNull _sign) then {
		deleteVehicle _sign;
	};

	{player reveal _x;} count (nearestObjects [player,[_class],50]);
};