new_full_ammo_powerup(drop_item, player) {
        players = get_players( player.team );

	if ( isDefined( level._get_game_module_players ) ) {
		players = [[ level._get_game_module_players ]]( player );
	}

	i = 0;
	while ( i < players.size ) {
		if ( players[ i ] maps\mp\zombies\_zm_laststand::player_is_in_laststand() ) {
			i++;
			continue;
		}    
		else {
			primary_weapons = players[ i ] getweaponslist( 1 );
			players[ i ] notify( "zmb_max_ammo" );
			players[ i ] notify( "zmb_lost_knife" );
			players[ i ] notify( "zmb_disable_claymore_prompt" );
			players[ i ] notify( "zmb_disable_spikemore_prompt" );

			x = 0;
			while ( x < primary_weapons.size ) {
				if ( level.headshots_only && is_lethal_grenade( primary_weapons[ x ] ) ) {
					x++;
					continue;
				}
				else {
					if ( isDefined( level.zombie_include_equipment ) && isDefined( level.zombie_include_equipment[ primary_weapons[ x ] ] ) )	{
						x++;
						continue;
					}
					else {
						if ( players[ i ] hasweapon( primary_weapons[ x ] ) ) {
							players[ i ] givemaxammo( primary_weapons[ x ] );
              players[ i ] setweaponammoclip( primary_weapons[ x ], weaponclipsize( primary_weapons[ x ] ) );
						}
					}
				}
				x++;
			}
		}
		i++;
	}
	level thread full_ammo_on_hud( drop_item, player.team );
}
