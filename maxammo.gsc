#include maps\_utility; 
#include common_scripts\utility; 
#include maps\_hud_util;
init()
{
    level thread onplayerconnect();
}

onplayerconnect()
{
    level endon("end_game");
	for(;;)
	{
		level waittill("connected", player);
		player thread maxammo();
	}
}

maxammo()
{
	level endon("end_game");
	self endon("disconnect");
    self waittill("spawned_player");
    wait 5;
    self iprintln("Bo3 Max ammo added.");
	for(;;) 
	{
		self waittill("zmb_max_ammo");
		current_weapons = self getweaponslist(1);
		for(i=0;i<current_weapons.size;i++) 
		{
			self setweaponammoclip(current_weapons[i], weaponclipsize(current_weapons[i]));
		}
	}
}
