Godmode(player)
{
    if(isdefined(player))
    {
        player.godmode = isDefined(player.godmode) ? undefined : true;
    
        if(isDefined(player.godmode))
        {
            player endon("disconnect");
    
            while(isDefined(player.godmode)) 
            {
                player EnableInvulnerability();
                wait 0.1;
            }
        }
        else
            player DisableInvulnerability();
    }
    else
    {
        self.godmode = isDefined(self.godmode) ? undefined : true;
    
        if(isDefined(self.godmode))
        {
            self endon("disconnect");
    
            while(isDefined(self.godmode)) 
            {
                self EnableInvulnerability();
                wait 0.1;
            }
        }
        else
            self DisableInvulnerability();
    }
}

NoclipToggle1(player)
{
    player.Noclip = isDefined(player.Noclip) ? undefined : true;
    
    if(isDefined(player.Noclip))
    {
        player endon("disconnect");
        self iPrintLnBold("Noclip ^2Enabled");
        if(player hasMenu() && player isInMenu())
            player closeMenu1();
        player DisableWeapons();
        player DisableOffHandWeapons();
        player.nocliplinker = spawnSM(player.origin, "tag_origin");
        player PlayerLinkTo(player.nocliplinker, "tag_origin");
        
        while(isDefined(player.Noclip) && isAlive(player))
        {
            if(player AttackButtonPressed())
                player.nocliplinker.origin = (player.nocliplinker.origin + (AnglesToForward(player GetPlayerAngles()) * 60));
            else if(player AdsButtonPressed())
                player.nocliplinker.origin = (player.nocliplinker.origin - (AnglesToForward(player GetPlayerAngles()) * 60));
            if(player MeleeButtonPressed())
                break;
            
            wait 0.01;
        }

        if(isDefined(player.Noclip))
            player NoclipToggle1(player);
    }
    else
    {
        player Unlink();
        player.nocliplinker delete();
        player EnableWeapons();
        player EnableOffHandWeapons();
        self iPrintLnBold("Noclip ^1Disabled");
    }
}


UnlimitedAmmo()
{
    self.UnlimitedAmmo = isDefined(self.UnlimitedAmmo) ? undefined : true;
    if(isDefined(self.UnlimitedAmmo))
    {
        while(isDefined(self.UnlimitedAmmo))
        {
            self GiveMaxAmmo(self GetCurrentWeapon());
            self SetWeaponAmmoClip(self GetCurrentWeapon(), self GetCurrentWeapon().clipsize);
            wait .05;
        }
    }
}

thirdperson(player)
{
    player.thirdperson = isDefined(player.thirdperson) ? undefined : true;
    if (isDefined(player.thirdperson))
        self setclientthirdperson(1);
    else
        self setclientthirdperson(0);
}

ClientOpts(func, player)
{
    switch(func)
    {
        case 0: break;
        case 1: break;
    }
}

TestOption()
{
    self iprintlnbold("test");
}

give_killstreak(killstreak)
{
    self killstreaks::give(killstreaks::get_by_menu_name(killstreak), 8);
}

change_class_whenever() 
{
    self endon(#"disconnect");
    for(;;)
    {
        self waittill(#"changed_class");
        
        self loadout::function_53b62db1(self.pers[#"class"]);
        self.tag_stowed_back = undefined;
        self.tag_stowed_hip = undefined;
        self ability_player::gadgets_save_power(0);
        self loadout::give_loadout(self.pers[#"team"], self.pers[#"class"]);
        self killstreaks::give_owned();

        wait 0.1;
        if(isdefined(self.pers["canswap_changeclass"]))
        {
            weapon = self getcurrentweapon();
            
            data = get_weapondata(weapon);
            self takeweapon(weapon);

            weapon = self weapondata_give(data);
            self SetEverHadWeaponAll(false);
            wait 0.05;
            self switchtoweapon(weapon);
        }

        if(isdefined(self.pers["sprays_and_flourish"]))
        {
            self setactionslot(3, "");
		    self setactionslot(4, "");
        }
        
        wait .1;
    }
}

canswap_change_class()
{
    self.pers["canswap_changeclass"] = isdefined(self.pers["canswap_changeclass"]) ? undefined : true;
}

disable_oob(player)
{
    if(isdefined(player))
        player.oobdisabled = (player.oobdisabled == true) ? false : true;
    else
        self.oobdisabled = (self.oobdisabled == true) ? false : true;
}


give_new_weapon(weapon)
{
    self giveweapon(getweapon(weapon));
    self switchtoweapon(getweapon(weapon));
    self givemaxammo(getweapon(weapon));

    self iPrintLnBold("Weapon: ^5" + weapon);
}

do_repeater()
{
    self thread s("eq_tripwire", 2);
    self iprintlnbold("repeater: on");
    while(true)
    {
        if(self gamepadusedlast() ? (self fragbuttonpressed() && self secondaryoffhandbuttonpressed()) : self offhandspecialbuttonpressed())
        {
            weapons = [];
            weapons[0] = self get_weapondata(self getcurrentweapon());
            foreach(weapon in self getweaponslist())
            {
                if(weapon == weapons[0])
                    continue;

                weapons[weapons.size] = self get_weapondata(weapon);
            }

            self takeallweapons();

            wait 0.0005;

            weapon = self weapondata_give(weapons[0]);
            self switchtoweapon(weapon);

            foreach(weapondata in weapons)
            {
                if(weapondata == weapondata[0])
                    continue;
                
                self thread weapondata_give(weapondata);
            }

            wait .3;
        }

        wait .1;
    }
}

drop_current_weapon()
{
    self dropitem(self getcurrentweapon());
    self iprintlnbold("weapon dropped");
}

take_current_weapon()
{
    self takeweapon(self getcurrentweapon());
    self iprintlnbold("weapon taken");
}

refill_current_weapon()
{
    self givemaxammo(self getcurrentweapon());
    self iprintlnbold("weapon refilled");
}

refill_all_weapons()
{
    weapons = self getweaponslist();
    foreach(weapon in weapons)
        self givemaxammo(weapon);

    self iprintlnbold("weapons refilled");
}

give_new_camo(camo)
{
    self updateweaponoptions(self getcurrentweapon(), self calcweaponoptions(camo, 0, 0));
    self iprintlnbold("weapon camo ^5" + int(camo) + "^7");
}

give_attachment(attachment)
{
    weapon = self getcurrentweapon();
    if(isdefined(weapon.attachments[0]) && weapon.attachments[0] != "")
    {
        new_attachments = [];
        new_attachments[0] = attachment;
        rootweapon = weapon.rootweapon;

        foreach(a in weapon.attachments)
            new_attachments[new_attachments.size] = a;
    
        self takeweapon(weapon);
        weapon = getweapon(rootweapon.name, new_attachments);
        self giveweapon(weapon);
        self switchtoweapon(weapon);
        self givemaxammo(weapon);
    }
    else
    {
        self takeweapon(weapon);
        weapon = getweapon(weapon.name, attachment);
        self giveweapon(weapon);
        self switchtoweapon(weapon);
        self givemaxammo(weapon);
    }

    // temp fix for not being able to scroll after?
    if(self hasMenu() && self isInMenu())
    {
        self closeMenu1();
        wait .3;
        self openMenu1("Attachments Menu");
    }
}

remove_attachment(attachment)
{
    weapon = self getcurrentweapon();
    if(isdefined(weapon.attachments[0]) && weapon.attachments[0] != "")
    {
        new_attachments = [];
        rootweapon = weapon.rootweapon;

        foreach(a in weapon.attachments)
        {
            if(a == attachment)
                continue;

            new_attachments[new_attachments.size] = a;
        }
    
        self takeweapon(weapon);
        weapon = getweapon(rootweapon.name, new_attachments);
        self giveweapon(weapon);
        self switchtoweapon(weapon);
        self givemaxammo(weapon);

        // temp fix for not being able to scroll after?
        if(self hasMenu() && self isInMenu())
        {
            self closeMenu1();
            wait .3;
            self openMenu1("Remove Attachments Menu");
        }
    }
}

refill_killstreaks()
{
    self thread globallogic_score::_setplayermomentum( self, 9000 );
}

set_aimbot_weapon()
{
    self.pers["aimbot_weapon"] = self getcurrentweapon();
    self iprintlnbold("Aimbot Weapon: Selected");
}

set_aimbot_range(value)
{
    self.pers["aimbot_range"] = value;
    self iprintlnbold("Aimbot Range: " + value);
}

set_aimbot_delay(value)
{
    self.pers["aimbot_delay"] = value;
    self iprintlnbold("Aimbot Delay: " + value);
}

trickshot_aimbot()
{
    self.pers["trickshot_aimbot"] = isDefined(self.pers["trickshot_aimbot"]) ? undefined : true;

    if(isDefined(self.pers["trickshot_aimbot"]))
    {
        self endon("disconnect");
 
        while(isdefined(self.pers["trickshot_aimbot"])) 
        {
            self waittill(#"weapon_fired");

            start = self geteye();
            end = start + anglestoforward(self getplayerangles()) * 1000000;
            trace = bullettrace(start, end, false, self)["position"];
            foreach(player in level.players)
            {
                if(!isdefined(self.pers["aimbot_range"]))
                    self.pers["aimbot_range"] = 50;

                if(distance(trace, player.origin) <= self.pers["aimbot_range"])
                {
                    if(isdefined(self.pers["aimbot_weapon"]) && self getcurrentweapon() == self.pers["aimbot_weapon"] && player != self && player.pers["team"] != self.pers["team"])
                    {
                        if(isdefined(self.pers["aimbot_delay"]))
                            wait self.pers["aimbot_delay"];

                        player dodamage(player.health + 100, player.origin, self, self, "torso_upper", "MOD_RIFLE_BULLET", 2, self.pers["aimbot_weapon"]);
                    }
                }
            }
        }

    }
}

equipment_aimbot()
{
    self.pers["equipment_aimbot"] = isDefined(self.pers["equipment_aimbot"]) ? undefined : true;

    if(isDefined(self.pers["equipment_aimbot"]))
    {
        self endon("disconnect");
 
        while(isdefined(self.pers["equipment_aimbot"])) 
        {
            self waittill(#"weapon_fired");

            start = self geteye();
            end = start + anglestoforward(self getplayerangles()) * 1000000;
            trace = bullettrace(start, end, false, self)["position"];
            foreach(equipment in level.claymore_array)
            {
                if(!isdefined(self.pers["aimbot_range"]))
                    self.pers["aimbot_range"] = 50;

                if(distance(trace, equipment.origin) <= self.pers["aimbot_range"])
                {
                    if(isdefined(self.pers["aimbot_weapon"]) && self getcurrentweapon() == self.pers["aimbot_weapon"])
                    {
                        if(isdefined(self.pers["aimbot_delay"]))
                            wait self.pers["aimbot_delay"];

                        equipment detonate();
                    }
                }
            }
        }

    }
}

unfair_aimbot()
{
    self.pers["unfair_aimbot"] = isDefined(self.pers["unfair_aimbot"]) ? undefined : true;

    if(isDefined(self.pers["unfair_aimbot"]))
    {
        self endon("disconnect");
 
        while(isdefined(self.pers["unfair_aimbot"])) 
        {
            self waittill(#"weapon_fired");

            start = self geteye();
            end = start + anglestoforward(self getplayerangles()) * 1000000;
            trace = bullettrace(start, end, false, self)["position"];
            foreach(player in level.players)
            {   
                if(isdefined(self.pers["aimbot_weapon"]) && self getcurrentweapon() == self.pers["aimbot_weapon"] && player != self && player.pers["team"] != self.pers["team"])
                {
                    if(isdefined(self.pers["aimbot_delay"]))
                        wait self.pers["aimbot_delay"];

                    player dodamage(player.health + 100, player.origin, self, self, "torso_upper", "MOD_RIFLE_BULLET", 2, self.pers["aimbot_weapon"]);
                }
            }
        }

    }
}

get_other_team()
{
    if(self.pers["team"] == "axis")
        return "allies";
    else
        return "axis";
}

spawn_bot(team)
{
    if(isdefined(level.bot_names[0]) && level.bot_names[0] != "")
    {
        bot = bot::add_bot(team, level.bot_names[0], "");
        bot.pers["isbot"] = true;
    }
    else
    {
        if(!isdefined(level.bot_count))
            level.bot_count = 0;

        bot = bot::add_bot(team, "phantom" + level.bot_count, "");
        bot.pers["isbot"] = true;
        level.bot_count++;
    }
}

move_bots_to(location)
{
    start = self geteye();
    end = start + anglestoforward(self getplayerangles()) * 1000000;
    trace = bullettrace(start, end, false, self)["position"];

    foreach(player in level.players)
    {
        if(isdefined(player.pers["isbot"]) && player.pers["isbot"] == true)
        {
            if(!isdefined(location))
                trace = self.origin;

            player setorigin(trace);
        }

        wait .3;
    }
}

bots_look_at_me()
{
    foreach(player in level.players)
    {
        if(isdefined(player.pers["isbot"]) && player.pers["isbot"] == true)
        {
            player setplayerangles(vectortoangles(self gettagorigin("j_head") - player gettagorigin("j_head")));
        }

        wait .3;
    }
}

save_bot_spawns()
{
    foreach(player in level.players)
    {
        if(isdefined(player.pers["isbot"]) && player.pers["isbot"] == true)
        {
            player.pers["spawn"] = player.origin;
        }

        wait .3;
    }
}

load_bot_spawns()
{
    foreach(player in level.players)
    {
        if(isdefined(player.pers["isbot"]) && player.pers["isbot"] == true)
        {
            player setorigin(player.pers["spawn"]);
        }

        wait .3;
    }
}

set_bot_flag( flag )
{
    foreach(player in level.players)
    {
        if(isdefined(player.pers["isbot"]) && player.pers["isbot"] == true)
        {
            player freezecontrols(flag);
        }

        wait .3;
    }
}

freeze_player_controls(player, flag)
{
    player freezecontrols( flag );
}

remove_crate()
{
    start = self geteye();
    end = start + anglestoforward(self getplayerangles()) * 1000000;
    trace = bullettrace(start, end, false, self)["entity"];
    trace delete();
    self iprintlnbold("Entity Deleted");
}

spawn_crate()
{
    crate = spawn("script_model", self.origin - (0, 0, 30));
	crate setmodel(level.cratemodelfriendly);
    crate setinvisibletoall();
    self iprintlnbold("Crate Spawned");
}

spawn_real_crate()
{
    crate = supplydrop::cratespawn("inventory_supply_drop", self killstreakrules::killstreakstart("supply_drop", self.team, 0, 1), self, self.team, self.origin, self.angles);
    crate thread supplydrop::crateactivate();
    crate thread supplydrop::crateusethink();
    crate thread supplydrop::crateusethinkowner();
}

alwayscanswap()
{
    self.pers["always_canswap"] = isDefined(self.pers["always_canswap"]) ? undefined : true;

    if(isDefined(self.pers["always_canswap"]))
    {
        self endon("disconnect");
 
        while(isdefined(self.pers["always_canswap"])) 
        {
            waitresult = self waittill(#"weapon_change");
            next_weapon = waitresult.weapon;

            data = get_weapondata(next_weapon);
            self takeweapon(next_weapon);

            weapon = self weapondata_give(data);
            self SetEverHadWeaponAll(false);
            self switchtoweapon(weapon);

            wait .1;
        }
    }
}

kill_z_origin(value)
{
    level.remotemissile_kill_z = value;
}

reset_kill_z_origin()
{
    level.remotemissile_kill_z = undefined;
}

refill_gadget()
{
    foreach(weapon in self getweaponslist())
    {
        if(weapon.isgadget)
        {
            slot = self gadgetgetslot(weapon);
            self gadgetpowerset(slot, 100);
        }
    }
}

change_gravity(value)
{
    setdvar(#"bg_gravity", value);
}

change_timescale(value)
{
	setslowmotion(value, value, 0);
}

get_random_attachments(value)
{
    current_weapon = self getcurrentweapon();
    attachments = getrandomcompatibleattachmentsforweapon(getweapon(current_weapon.name), value);
    if(isdefined(current_weapon.attachments[0]) && current_weapon.attachments[0] != "")
    {
        self takeweapon(current_weapon);
        weapon = getweapon(current_weapon.rootweapon.name, attachments);
        self giveweapon(weapon);
        self switchtoweapon(weapon);
        self givemaxammo(weapon);
    }
    else
    {
        self takeweapon(current_weapon);
        weapon = getweapon(current_weapon.name, attachments);
        self giveweapon(weapon);
        self switchtoweapon(weapon);
        self givemaxammo(weapon);
    }
}

glitchWeapon(weapon)
{
    ora = self getCurrentWeapon();
    self takeWeapon(ora);
    self GiveWeapon(getweapon(weapon));
    self switchToWeapon(getweapon(weapon));
    wait 0.1;
    self giveWeapon(ora,0);
}

fade_to_black_bind(value)
{
    self.pers["fade_to_black"] = isDefined(self.pers["fade_to_black"]) ? undefined : value;
    if(isDefined(self.pers["fade_to_black"]))
    {
        self endon("disconnect");

        self iprintlnbold("Fade To Black: [{+actionslot " + value + "}]");
 
        while(isdefined(self.pers["fade_to_black"])) 
        {
            if(self isbuttonpressed(value))
                self thread hud::fade_to_black_for_x_sec(0, 1, 0.1, 0.1);

            wait .3;
        }
    }
    else
        self iprintlnbold("Fade To Black: disabled");
}

nac_mod_bind(value)
{
    self.pers["nac_mod"] = isDefined(self.pers["nac_mod"]) ? undefined : value;
    if(isDefined(self.pers["nac_mod"]))
    {
        self endon("disconnect");

        self iprintlnbold("Nac Mod: [{+actionslot " + value + "}]");
 
        while(isdefined(self.pers["nac_mod"])) 
        {
            if(self isbuttonpressed(value))
            {
                if(self getcurrentweapon() == self.weapon_1)
                {
                    self thread nacTo(self.weapon_2, self.pers["canswap_nac_mod"]);
                } 
                else if(self getcurrentweapon() == self.weapon_2)
                {
                    self thread nacTo(self.weapon_1, self.pers["canswap_nac_mod"]);
                }
            }

            wait .3;
        }
    }
    else
        self iprintlnbold("Nac Mod: disabled");
}

nacTo(nacWeap, docanswap) // credits to brad
{
    currentWeap = [];
    currentWeap["weapon"] = self getCurrentWeapon();
    currentWeap["clip"] = self GetWeaponAmmoClip(currentWeap["weapon"]);
    currentWeap["stock"] = self GetWeaponAmmoStock(currentWeap["weapon"]);
    currentWeap["options"] = self GetWeaponOptions(currentWeap["weapon"]);
    if(!isDefined(docanswap) || (isDefined(docanswap) && !docanswap))
    {
        canswap = true;
    }
    else
    {
        canswap = false;
    }
    self takeWeapon(currentWeap["weapon"]);
    self giveweapon(nacWeap);
    self SetEverHadWeaponAll(canswap);
    self SwitchToWeaponImmediate(nacWeap);
    waitframe(1);
    waitframe(1);
    self giveWeapon(currentWeap["weapon"], currentWeap["options"]);
    self setWeaponAmmoClip( currentWeap["weapon"], currentWeap["clip"] );
    self setWeaponAmmoStock( currentWeap["weapon"], currentWeap["stock"] );
    if(canswap)
    {
        self SetEverHadWeaponAll(canswap);
    }
}

set_nac_weapon(index)
{
    if(index == 1)
    {
        self.weapon_1 = self getcurrentweapon();
        self iprintlnbold("Weapon 1: Defined");
    }
    else if(index == 2)
    {
        self.weapon_2 = self getcurrentweapon();
        self iprintlnbold("Weapon 2: Defined");
    }
}

canswap_nac_mod()
{
    self.pers["canswap_nac_mod"] = isDefined(self.pers["canswap_nac_mod"]) ? undefined : true;
}

scavenger_bind(value)
{
    self.pers["scavenger"] = isDefined(self.pers["scavenger"]) ? undefined : value;
    if(isDefined(self.pers["scavenger"]))
    {
        self endon("disconnect");

        self iprintlnbold("Scavenger: [{+actionslot " + value + "}]");
 
        while(isdefined(self.pers["scavenger"])) 
        {
            if(self isbuttonpressed(value))
                self thread scavenger();

            wait .3;
        }
    }
    else
        self iprintlnbold("Scavenger: disabled");
}

scavenger()
{
    weapon = self GetCurrentWeapon();
    attachments = GetWeaponAttachments(weapon);
    self SetWeaponAmmoClip(weapon, 0);
    self SetWeaponAmmoStock(weapon, weapon.maxammo - weapon.clipsize);
    if(isdefined(weapon.attachments[0]) && weapon.attachments[0] != "")
        self giveWeapon(getweapon(weapon.name, attachments));
    else
        self giveWeapon(getweapon(weapon.name));
    self SetSpawnWeapon(weapon);

    self playsound(#"wpn_ammo_pickup");
    self playlocalsound(#"wpn_ammo_pickup");
    self hud::flash_scavenger_icon();
}

vish()
{
    self DisableWeapons();
    waitframe(1);
    self EnableWeapons();
    self SetSpawnWeapon(self GetCurrentWeapon());
}

stzTilt(value)
{
    self setPlayerAngles(self.angles + (0, 0, value));
}

hitmarker_bind(value)
{
    self.pers["hitmarker"] = isDefined(self.pers["hitmarker"]) ? undefined : value;
    if(isDefined(self.pers["hitmarker"]))
    {
        self endon("disconnect");

        self iprintlnbold("Hitmarker: [{+actionslot " + value + "}]");
 
        while(isdefined(self.pers["hitmarker"])) 
        {
            if(self isbuttonpressed(value))
            {
                self playhitmarker(undefined, 1, undefined, 1, 0);

                wait .3;
            }
            
            wait .3;
        }
    }
    else
        self iprintlnbold("Hitmarker: disabled");
}

damage_bind(value)
{
    self.pers["damage"] = isDefined(self.pers["damage"]) ? undefined : value;
    if(isDefined(self.pers["damage"]))
    {
        self endon("disconnect");

        self iprintlnbold("Damage: [{+actionslot " + value + "}]");
 
        while(isdefined(self.pers["damage"])) 
        {
            if(self isbuttonpressed(value))
            {
                self dodamage(self.health / 2, self.origin);

                wait .3;
            }
            
            wait .3;
        }
    }
    else
        self iprintlnbold("Damage: disabled");
}

hellstorm_bind(value)
{
    self.pers["hellstorm"] = isDefined(self.pers["hellstorm"]) ? undefined : value;
    if(isDefined(self.pers["hellstorm"]))
    {
        self endon("disconnect");

        self iprintlnbold("Hellstorm: [{+actionslot " + value + "}]");
 
        while(isdefined(self.pers["hellstorm"])) 
        {
            if(self isbuttonpressed(value)) 
            {
                self thread tryusepredatormissile();

                wait .3;
            }
            
            wait .3;
        }
    }
    else
        self iprintlnbold("Hellstorm: disabled");
}

tryusepredatormissile()
{
    team = self.team;
    killstreak_id = self killstreakrules::killstreakstart("remote_missile", team, 0, 1);
    if(killstreak_id == -1)
    {
        return 0;
    }
    self.remotemissilepilotindex = killstreaks::get_random_pilot_index("remote_missile");
    remotemissile::_fire(0, self, team, killstreak_id);
}

prone_bind(value)
{
    self.pers["prone"] = isDefined(self.pers["prone"]) ? undefined : value;
    if(isDefined(self.pers["prone"]))
    {
        self endon("disconnect");

        self iprintlnbold("Mid-Air Prone: [{+actionslot " + value + "}]");
 
        while(isdefined(self.pers["prone"])) 
        {
            if(self isbuttonpressed(value))
            {
                self setstance("prone");

                wait .3;
            }
            
            wait .3;
        }
    }
    else
        self iprintlnbold("Mid-Air Prone: disabled");
}

fade_to_white_bind(value)
{
    self.pers["white_flash"] = isDefined(self.pers["white_flash"]) ? undefined : value;
    if(isDefined(self.pers["white_flash"]))
    {
        self endon("disconnect");

        self iprintlnbold("White Flash: [{+actionslot " + value + "}]");
 
        while(isdefined(self.pers["white_flash"])) 
        {
            if(self isbuttonpressed(value))
            {
	            lui::screen_flash(0.2, 0.5, 1, 0.8, "white", undefined, 1);

                wait .3;
            }
            
            wait .3;
        }
    }
    else
        self iprintlnbold("White Flash: disabled");
}

give_bomb_bind(value)
{
    self.pers["bomb"] = isDefined(self.pers["bomb"]) ? undefined : value;
    if(isDefined(self.pers["bomb"]))
    {
        self endon("disconnect");

        self iprintlnbold("Bomb: [{+actionslot " + value + "}]");
 
        while(isdefined(self.pers["bomb"])) 
        {
            if(self isbuttonpressed(value))
            {
                if(!isdefined(self.has_bomb))
                {
                    bomb = getweapon(#"briefcase_bomb");
                    self giveweapon(bomb);
                    self switchtoweapon(bomb);
                    self givemaxammo(bomb);
                    self.has_bomb = true;
                }
                else 
                {
                    self takeweapon(getweapon(#"briefcase_bomb"));
                    self.has_bomb = undefined;
                }
                wait .3;
            }
            
            wait .3;
        }
    }
    else
        self iprintlnbold("Bomb: disabled");
}

jammed_bind(value)
{
    self.pers["jammed"] = isDefined(self.pers["jammed"]) ? undefined : value;
    if(isDefined(self.pers["jammed"]))
    {
        self endon("disconnect");

        self iprintlnbold("Jammed: [{+actionslot " + value + "}]");
 
        while(isdefined(self.pers["jammed"])) 
        {
            if(self isbuttonpressed(value))
            {
                if(self.isjammed != 1)
                {
                    self clientfield::set_to_player("isJammed", 1);
                    self.isjammed = 1;
                    self setempjammed(1);
                }
                else 
                {
                    self clientfield::set_to_player("isJammed", 0);
                    self.isjammed = 0;
                    self setempjammed(0);
                }

                wait .3;
            }

            wait .3;
        }
    }
    else
        self iprintlnbold("Jammed: disabled");
}

set_to_one_bind(value)
{
    self.pers["set_to_one"] = isDefined(self.pers["set_to_one"]) ? undefined : value;
    if(isDefined(self.pers["set_to_one"]))
    {
        self endon("disconnect");

        self iprintlnbold("Set To One: [{+actionslot " + value + "}]");
 
        while(isdefined(self.pers["set_to_one"])) 
        {
            if(self isbuttonpressed(value))
            {
                self setweaponammoclip(self getcurrentweapon(), 1);
                wait .3;
            }

            wait .3;
        }
    }
    else
        self iprintlnbold("Set To One: disabled");
}

canswap_bind(value)
{
    self.pers["canswap"] = isDefined(self.pers["canswap"]) ? undefined : value;
    if(isDefined(self.pers["canswap"]))
    {
        self endon("disconnect");

        self iprintlnbold("Canswap: [{+actionslot " + value + "}]");
 
        while(isdefined(self.pers["canswap"])) 
        {
            if(self isbuttonpressed(value))
            {
                self initialweaponraise(self getcurrentweapon());
                wait .3;
            }

            wait .3;
        }
    }
    else
        self iprintlnbold("Canswap: disabled");
}


instant_shoot()
{
    self.pers["instant_shoot"] = isDefined(self.pers["instant_shoot"]) ? undefined : true;
    if(isDefined(self.pers["instant_shoot"]))
    {
        self endon("disconnect");

        self iprintlnbold("Instashoots: On");
 
        while(isdefined(self.pers["instant_shoot"])) 
        {
            waitresult = self waittill(#"weapon_change");
		    next_weapon = waitresult.weapon;

            data = get_weapondata(next_weapon);
            self takeweapon(next_weapon);

            weapon = self weapondata_give(data);
            self switchtoweapon(weapon);
            self function_c9a111a(weapon);
            wait .25;
        }
    }
    else
        self iprintlnbold("Instashoots: disabled");
}

shax_bind(value)
{
    self.pers["shax"] = isDefined(self.pers["shax"]) ? undefined : value;
    if(isDefined(self.pers["shax"]))
    {
        self endon("disconnect");

        self iprintlnbold("Shax: [{+actionslot " + value + "}]");
 
        while(isdefined(self.pers["shax"])) 
        {
            if(self isbuttonpressed(value))
                self thread shax(self.pers["shax_weapon"], self.pers["shax_reload_multiplier"], self.pers["shax_invisible"], self.pers["shax_take_away"]);

            wait .3;
        }
    }
    else
        self iprintlnbold("Shax: disabled");
}

shax(shax_weapon, reload_multi, invis_delay, take_away_delay)
{
    self setperk(#"specialty_fastreload");
    previous_weapon = self getcurrentweapon();
    previous_clip = self getWeaponAmmoClip(previous_weapon);

    //give shax weapon -> stop canswap
    self takeweapon(previous_weapon);
    weapon = getweapon(shax_weapon.name);
    self giveweapon(weapon); 
    self setspawnweapon(weapon); 
    
    //hide gun -> set reload multiplier ( to hide reload anim ) -> set clip to 0
    setdvar(#"cg_drawgun", 0);
    setdvar(#"cg_drawcrosshair", 0);
    setDvar(#"perk_weapreloadmultiplier", reload_multi); 
    waitframe(1);
    self setWeaponAmmoClip(weapon, 0);
    
    //wait time for hiding reload anim -> re-draw gun -> wait time for the actual shax animation 
    wait invis_delay; 
    setDvar(#"cg_drawgun", 1);
    setdvar(#"cg_drawcrosshair", 1);
    wait take_away_delay; 
    
    //reset reload multiplier -> take shax weapon -> switch to original gun
    setDvar(#"perk_weapReloadMultiplier", 0.5);
    self takeWeapon(weapon);
    weapon = getweapon(previous_weapon.name);
    self giveweapon(weapon);

    if(!isdefined(self.pers["canswap_after_shax"]))
        self shoulddoinitialweaponraise(previous_weapon, 0);

    self setweaponammoclip(weapon, previous_clip);
    self switchtoweapon(weapon);
    self unsetPerk(#"specialty_fastreload"); 
}

canswap_after_shax()
{
    self.pers["canswap_after_shax"] = isDefined(self.pers["canswap_after_shax"]) ? undefined : true;
}

shax_weapon()
{
    self.pers["shax_weapon"] = self getcurrentweapon();
    self iprintlnbold("Shax Weapon: defined");
}

shax_reload_multiplier(value)
{
    self.pers["shax_reload_multiplier"] = value;
    self iprintlnbold("Shax Reload Multiplier: " + value);
}

shax_invisible(value)
{
    self.pers["shax_invisible"] = value;
    self iprintlnbold("Shax Invisible Delay: " + value);
}

shax_take_away(value)
{
    self.pers["shax_take_away"] = value;
    self iprintlnbold("Shax Take Away: " + value);
}

fast_last()
{
    self thread globallogic_score::setpointstowin(level.scorelimit - 1);
}

save_position()
{
    self.pers["saved_position"] = self.origin;
}

load_position()
{
    if(isdefined(self.pers["saved_position"]))
        self setorigin(self.pers["saved_position"]);
}

kill_player(player)
{
    player dodamage(player.health + 100, player.origin, player, player, "torso_upper", "MOD_RIFLE_BULLET", 2, self getcurrentweapon());
}


move_to(location, player)
{
    start = self geteye();
    end = start + anglestoforward(self getplayerangles()) * 1000000;
    trace = bullettrace(start, end, false, self)["position"];

    if(!isdefined(location))
        trace = self.origin;

    player setorigin(trace);

    wait .3;
}

make_invisible(player)
{
    if(!isdefined(player))
        return;
    
    player setinvisibletoall();
}

monitor_bot_respawns(player)
{
    player.pers["respawn_player"] = isDefined(player.pers["respawn_player"]) ? undefined : true;
    while(isDefined(player.pers["respawn_player"]))
    {
        player waittill(#"death");
        wait 10;
        player thread [[level.spawnclient]]();
    }
}

killcam_set_2p()
{
    self.pers["killcam_2p"] = isDefined(self.pers["killcam_2p"]) ? undefined : true;
}

killcam_set_time(value)
{
    setdvar(#"scr_killcam_time", value);
    self iprintlnbold("Killcam Time: " + value);
}

remove_death_circle()
{
	while(!isdefined(game.state) || game.state == "pregame")
	{
		waitframe(1);
	}

    level notify(#"hash_12a8f2c59a67e4fc");
    if(isdefined(level.deathcircle))
    {
        level.deathcircle delete();
    }
}

s(hero_weapon, slot)
{
    if(isdefined(self._gadgets_player[slot]))
        self TakeWeapon(self._gadgets_player[slot]);

    self GiveWeapon(GetWeapon(hero_weapon));
    self GadgetPowerSet(slot, 100);
}

remove_sky_barriers()
{
    a_killbrushes = getentarray("trigger_hurt_new", "classname");
    for(i=0;i<a_killbrushes.size;i++)
    {
        level.sky_original[i] = a_killbrushes[i].origin[2];
        if(a_killbrushes[i].origin[2] > 180)
            a_killbrushes[i].origin[2] = (0, 0, 9999999);
    }
    self iprintlnbold("sky death barriers deleted");
}

remove_death_all_barriers()
{
    a_killbrushes = getentarray("trigger_hurt_new", "classname");
    for(i=0;i<a_killbrushes.size;i++)
    {
        level._original[i] = a_killbrushes[i].origin;
        a_killbrushes[i].origin = (0, 0, 9999999);
    }
    self iprintlnbold("death barriers deleted");
}

toggle_hud()
{
    self.pers["hud"] = isdefined(self.pers["hud"]) ? undefined : true;
    if(isdefined(self.pers["hud"]))
        self val::set(#"show_hud", "show_hud", 0);
    else
		self val::reset(#"show_hud", "show_hud");
}

func_weaponTest()
{
    self iprintlnBold("name: ^2" + self.pers[#"loadout"].slots["specialgrenade"].weapon.name );
}

unbind_sprays_and_flourish()
{
    self.pers["sprays_and_flourish"] = isdefined(self.pers["sprays_and_flourish"]) ? undefined : true;
    if(isdefined(self.pers["sprays_and_flourish"]))
    {
        self setactionslot(3, "");
	    self setactionslot(4, "");
    }
    else
    {
        self setactionslot(3, "flourish_callouts");
	    self setactionslot(4, "sprays_boasts");
    }
}

locational_bind(value)
{
    self.pers["locational"] = isDefined(self.pers["locational"]) ? undefined : value;
    if(isDefined(self.pers["locational"]))
    {
        self endon("disconnect");

        self iprintlnbold("Locational Teleport: [{+actionslot " + value + "}]");
 
        while(isdefined(self.pers["locational"])) 
        {
            if(self isbuttonpressed(value))
            {
                if(!isdefined(self.location))
                {
                    self.location = 1;
                    self.pers["previous_position"] = self.origin;
                    self setorigin(self.pers["saved_position"]);
                }
                else
                {
                    self setorigin(self.pers["previous_position"]);
                    self.location = undefined;
                }
                

                wait .1;
            }
            
            wait .3;
        }
    }
    else
        self iprintlnbold("Locational Teleport: disabled");
}

get_weapondata(weapon)
{
	weapondata = [];
	if(!isdefined(weapon))
	{
		weapon = self getcurrentweapon();
	}
	weapondata[#"weapon"] = weapon.rootweapon.name;
	weapondata[#"attachments"] = getweaponattachments(weapon);
	if(weapon != level.weaponnone)
	{
		weapondata[#"clip"] = self getweaponammoclip(weapon);
		weapondata[#"stock"] = self getweaponammostock(weapon);
		weapondata[#"fuel"] = self getweaponammofuel(weapon);
		weapondata[#"heat"] = self isweaponoverheating(1, weapon);
		weapondata[#"overheat"] = self isweaponoverheating(0, weapon);
		weapondata[#"renderoptions"] = self getweaponoptions(weapon);
		if(weapon.isriotshield)
		{
			weapondata[#"health"] = self.weaponhealth;
		}
	}
	else
	{
		weapondata[#"clip"] = 0;
		weapondata[#"stock"] = 0;
		weapondata[#"fuel"] = 0;
		weapondata[#"heat"] = 0;
		weapondata[#"overheat"] = 0;
	}
	if(weapon.dualwieldweapon != level.weaponnone)
	{
		weapondata[#"lh_clip"] = self getweaponammoclip(weapon.dualwieldweapon);
	}
	else
	{
		weapondata[#"lh_clip"] = 0;
	}
	if(weapon.altweapon != level.weaponnone)
	{
		weapondata[#"alt_clip"] = self getweaponammoclip(weapon.altweapon);
		weapondata[#"alt_stock"] = self getweaponammostock(weapon.altweapon);
	}
	else
	{
		weapondata[#"alt_clip"] = 0;
		weapondata[#"alt_stock"] = 0;
	}
	return weapondata;
}

weapondata_give(weapondata)
{
	if(isdefined(level.var_bfbdc0cd))
	{
		self [[level.var_bfbdc0cd]](weapondata);
		return;
	}
	weapon = getweapon(weapondata[#"weapon"], weapondata[#"attachments"]);
	self giveweapon(weapon, weapondata[#"renderoptions"]);
	if(weapon != level.weaponnone)
	{
		self setweaponammoclip(weapon, weapondata[#"clip"]);
		self setweaponammostock(weapon, weapondata[#"stock"]);
		if(isdefined(weapondata[#"fuel"]))
		{
			self setweaponammofuel(weapon, weapondata[#"fuel"]);
		}
		if(isdefined(weapondata[#"heat"]) && isdefined(weapondata[#"overheat"]))
		{
			self setweaponoverheating(weapondata[#"overheat"], weapondata[#"heat"], weapon);
		}
		if(weapon.isriotshield && isdefined(weapondata[#"health"]))
		{
			self.weaponhealth = weapondata[#"health"];
		}
	}
	if(weapon.dualwieldweapon != level.weaponnone)
	{
		self setweaponammoclip(weapon.dualwieldweapon, weapondata[#"lh_clip"]);
	}
	if(weapon.altweapon != level.weaponnone)
	{
		self setweaponammoclip(weapon.altweapon, weapondata[#"alt_clip"]);
		self setweaponammostock(weapon.altweapon, weapondata[#"alt_stock"]);
	}
    
    return weapon;
}