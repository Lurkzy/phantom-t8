runMenuIndex(menu)
{
    self endon("disconnect");

    if(!isDefined(menu))
        menu = "Main";
    
    switch(menu)
    {
        case "Main":
            self addMenu(menu, level.menuName);
            if(self getVerification() > 0)
            {
                self addOpt("Personal Menu", &newMenu, "Personal Menu");
                self addOpt("Weapons Menu", &newMenu, "Weapons Menu");
                self addOpt("Killstreaks Menu", &newMenu, "Killstreaks Menu");
                self addOpt("Specialists Menu", &newMenu, "Specialists Menu");
                self addOpt("Trickshot Menu", &newMenu, "Trickshot Menu");
                self addOpt("Aimbot Menu", &newMenu, "Aimbot Menu");
                self addOpt("Vision Menu", &newMenu, "Vision Menu");
                self addOpt("Lobby Menu", &newMenu, "Lobby Menu");
                self addOpt("Bot Menu", &newMenu, "Bot Menu");
                if(self getVerification() > 1)
                {
                    if(self getVerification() > 2)
                    {
                        if(self getVerification() > 3)
                        {
                            if(self IsHost() || self getVerification() > 3)
                                self addOpt("Player Menu", &newMenu, "Players");
                        }
                    }
                }
            }
            break;
        case "Weapons Menu":
            self addMenu(menu, "Weapons Menu");
                self addOpt("Take Current Weapon", &take_current_weapon);
                self addOpt("Drop Current Weapon", &drop_current_weapon);
                self addOpt("Refill Current Weapon", &refill_current_weapon);
                self addOpt("Refill All Weapons", &refill_all_weapons);
                self addOptIncSlider("Change Camo ", &give_new_camo, 0, 0, 666, 1);
                self addOptIncSlider("Get Random Attachments ", &get_random_attachments, 1, 1, 5, 1);
                self addOpt("Attachment Menu", &newMenu, "Attachments Menu");
                self addOpt("ICR-7", &give_new_weapon, "ar_accurate_t8");
                self addOpt("Rampart 17", &give_new_weapon, "ar_damage_t8");
                self addOpt("KN-57", &give_new_weapon, "ar_modular_t8");
                self addOpt("Vapr-XKG", &give_new_weapon, "ar_stealth_t8");
                self addOpt("Maddox RFB", &give_new_weapon, "ar_fastfire_t8");
                self addOpt("Swat RFT", &give_new_weapon, "ar_standard_t8");
                self addOpt("Grav", &give_new_weapon, "ar_galil_t8");
                self addOpt("Peacekeeper", &give_new_weapon, "ar_peacekeeper_t8");
                self addOpt("AN-94", &give_new_weapon, "ar_an94_t8 ");
                self addOpt("Doublecross", &give_new_weapon, "ar_doublebarrel_t8");
                self addOpt("MX9", &give_new_weapon, "smg_standard_t8");
                self addOpt("GKS", &give_new_weapon, "smg_accurate_t8");
                self addOpt("Spitfire", &give_new_weapon, "smg_fastfire_t8");
                self addOpt("Cordite", &give_new_weapon, "smg_capacity_t8");
                self addOpt("Saug 9mm", &give_new_weapon, "smg_handling_t8");
                self addOpt("Daemon 3XB", &give_new_weapon, "smg_fastburst_t8");
                self addOpt("Switchblade x9", &give_new_weapon, "smg_folding_t8");
                self addOpt("VMP", &give_new_weapon, "smg_vmp_t8");
                self addOpt("Micromg 9mm", &give_new_weapon, "smg_minigun_t8");
                self addOpt("Auger DMR", &give_new_weapon, "tr_powersemi_t8");
                self addOpt("ABR 223", &give_new_weapon, "tr_midburst_t8");
                self addOpt("Swordfish", &give_new_weapon, "tr_longburst_t8");
                self addOpt("S6 Stingray", &give_new_weapon, "tr_flechette_t8");
                self addOpt("M16", &give_new_weapon, "tr_damageburst_t8");
                self addOpt("Titan", &give_new_weapon, "lmg_standard_t8");
                self addOpt("Hades", &give_new_weapon, "lmg_spray_t8");
                self addOpt("VKM 750", &give_new_weapon, "lmg_heavy_t8");
                self addOpt("Tigershark", &give_new_weapon, "lmg_stealth_t8");
                self addOpt("Paladin HB50", &give_new_weapon, "sniper_powerbolt_t8");
                self addOpt("Outlaw", &give_new_weapon, "sniper_fastrechamber_t8");
                self addOpt("SDM", &give_new_weapon, "sniper_powersemi_t8");
                self addOpt("Koshka", &give_new_weapon, "sniper_quickscope_t8");
                self addOpt("Vendetta", &give_new_weapon, "sniper_mini14_t8");
                self addOpt("Locus", &give_new_weapon, "sniper_locus_t8");
                self addOpt("Havelina AA50", &give_new_weapon, "sniper_damagesemi_t8");
                self addOpt("Strife", &give_new_weapon, "pistol_standard_t8");
                self addOpt("RK 7 Garrison", &give_new_weapon, "pistol_burst_t8");
                self addOpt("Mozu", &give_new_weapon, "pistol_revolver_t8");
                self addOpt("KAP 45", &give_new_weapon, "pistol_fullauto_t8");
                self addOpt("Mog 12", &give_new_weapon, "shotgun_pump_t8");
                self addOpt("SG12", &give_new_weapon, "shotgun_semiauto_t8");
                self addOpt("Rampage", &give_new_weapon, "shotgun_trenchgun_t8");
                self addOpt("Argus", &give_new_weapon, "shotgun_precision_t8");
                self addOpt("Hellion Salvo", &give_new_weapon, "launcher_standard_t8");
                self addOpt("Bare hands", &give_new_weapon, "bare_hands");
                self addOpt("Combat Knife", &give_new_weapon, "knife_loadout");
                self addOpt("Secret Santa", &give_new_weapon, "melee_secretsanta_t8");
                self addOpt("Slay Bell", &give_new_weapon, "melee_slaybell_t8");
                self addOpt("Home Wrecker", &give_new_weapon, "melee_demohammer_t8");
                self addOpt("Cha-Ching", &give_new_weapon, "melee_coinbag_t8");
                self addOpt("Nifo'Oti", &give_new_weapon, "melee_club_t8");
                self addOpt("Rising Tide", &give_new_weapon, "melee_cutlass_t8");
                self addOpt("Full Stop", &give_new_weapon, "melee_stopsign_t8");
                self addOpt("Backhander", &give_new_weapon, "melee_zombiearm_t8");
                self addOpt("Series 6 Outrider", &give_new_weapon, #"hash_68a980198a51e72b");
                self addOpt("Eye of Apophis", &give_new_weapon, #"hash_20e5bae184643ee5");
                self addOpt("Ballistic Knife", &give_new_weapon, "special_ballisticknife_t8_dw_dw");
                self addOpt("Reaver C68", &give_new_weapon, "special_crossbow_t8");
                self addOpt("Dog Whistle", &give_new_weapon, "ability_dog");
                self addOpt("Default Weapon", &give_new_weapon, "defaultweapon");
                self addOpt("Satellite Ball", &give_new_weapon, "ball");
                self addOpt("Claymore", &glitchWeapon, "claymore");
                self addOpt("test 1", &glitchWeapon, "music_box");
                self addOpt("Repater Equipment", &s, "eq_tripwire", true);
                self addOpt("test 2", &s, "hind_ffar", true);
        break;
        case "Attachments Menu":
            self addMenu(menu, "Attachments Menu");
                self addOpt("Remove Attachments", &newMenu, "Remove Attachments Menu");
                foreach(a in self getcurrentweapon().supportedattachments)
                    self addOpt(a, &give_attachment, a);
        break;
        case "Remove Attachments Menu":
            self addMenu(menu, "Remove Attachments Menu");
                foreach(a in getweaponattachments(self getcurrentweapon()))
                    self addOpt(a, &remove_attachment, a);
        break;
        case "Specialists Menu":
            self addMenu(menu, "Specialists Menu");
                self addOpt("Ajax", &newMenu, "Ajax");
                self addOpt("Battery", &newMenu, "Battery");
                self addOpt("Crash", &newMenu, "Crash");
                self addOpt("Firebreak", &newMenu, "Firebreak");
                self addOpt("Nomad", &newMenu, "Nomad");
                self addOpt("Outrider", &newMenu, "Outrider");
                self addOpt("Prophet", &newMenu, "Prophet");
                self addOpt("Reaper", &newMenu, "Reaper");
                self addOpt("Recon", &newMenu, "Recon");
                self addOpt("Ruin", &newMenu, "Ruin");
                self addOpt("Seraph", &newMenu, "Seraph");
                self addOpt("Spectre", &newMenu, "Spectre");
                self addOpt("Torque", &newMenu, "Torque");
                self addOpt("Zero", &newMenu, "Zero");
        break;
        case "Ajax":
            self addMenu(menu, "Ajax");
                self addOpt("Ballistic Shield", &s, "sig_buckler_dw");
                self addOpt("9-Bang", &s, "eq_swat_grenade");
        break;
        case "Battery":
            self addMenu(menu, "Battery");
                self addOpt("War Machine", &s, "hero_pineapplegun");
                self addOpt("Cluster Grenade", &s, "eq_cluster_semtex_grenade");
        break;
        case "Crash":
            self addMenu(menu, "Crash");
                self addOpt("Tak-5", &s, "hash_f525ab9cc66c061");
                self addOpt("Assault Pack", &s, "gadget_supplypod");
        break;
        case "Firebreak":
            self addMenu(menu, "Firebreak");
                self addOpt("Purifier", &s, "hero_flamethrower");
                self addOpt("Reactor Core", &s, "gadget_radiation_field");
        break;
        case "Nomad":
            self addMenu(menu, "Nomad");
                self addOpt("K9-Unit", &s, "ability_dog");
                self addOpt("Mesh Mine", &s, "eq_tripwire");
        break;
        case "Outrider":
            self addMenu(menu, "Outrider");
                self addOpt("Sparrow", &s, "sig_bow_quickshot");
                self addOpt("Hawk", &s, "eq_hawk");
        break;
        case "Prophet":
            self addMenu(menu, "Prophet");
                self addOpt("BO3 Tempest", &s, "hero_lightninggun");
                self addOpt("Tempest", &s, "shock_rifle");
                self addOpt("Seeker", &s, "eq_seeker_mine");
        break;
        case "Reaper":
            self addMenu(menu, "Reaper");
                self addOpt("Scythe", &s, "sig_lmg");   
                self addOpt("Radar Shroud", &s, "hash_f525ab9cc66c061");
        break;
        case "Recon":
            self addMenu(menu, "Recon");
                self addOpt("Vision Pulse", &s, "gadget_vision_pulse");
                self addOpt("Sensor Dart", &s, "eq_sensor");
        break;
        case "Ruin":
            self addMenu(menu, "Ruin");
                self addOpt("Grav Slam", &s, "eq_gravityslam");
                self addOpt("Grapple Gun", &s, "eq_grapple");
        break;
        case "Seraph":
            self addMenu(menu, "Seraph");
                self addOpt("Annihilator", &s, "hero_annihilator");
                self addOpt("Tac-Deploy", &s, "gadget_spawnbeacon");
        break;
        case "Spectre":
            self addMenu(menu, "Spectre");
                self addOpt("Shadow Blade", &s, "sig_blade");
                self addOpt("Smoke", &s, "eq_smoke");
        break;
        case "Torque":
            self addMenu(menu, "Torque");
                self addOpt("Barricade", &s, "ability_smart_cover");
                self addOpt("Razor Wire", &s, "eq_concertina_wire");
        break;
        case "Zero":
            self addMenu(menu, "Zero");
                self addOpt("Ice Pick", &s, "gadget_icepick");
                self addOpt("Emp Disruptor", &s, "eq_emp_grenade");
        break;
        case "Killstreaks Menu":
            self addMenu(menu, "Killstreaks Menu");
                self addOpt("Refill Killstreaks", &refill_killstreaks);
                self addOpt("Dart", &give_killstreak, "dart");
                self addOpt("RC-XD", &give_killstreak, "recon_car");
                self addOpt("UAV", &give_killstreak, "uav");
                self addOpt("Carepackage", &give_killstreak, "supplydrop_marker"); 
                self addOpt("Counter UAV", &give_killstreak, "counteruav");
                self addOpt("Lightning Strike", &give_killstreak, "planemortar");
                self addOpt("Sentry", &give_killstreak, "ultimate_turret");
                self addOpt("Hellstorm", &give_killstreak, "remote_missile");
                self addOpt("Drone Squad", &give_killstreak, "drone_squadron");
                self addOpt("Sniper's Nest", &give_killstreak, "overwatch_helicopter");
                self addOpt("Mantis", &give_killstreak, "ai_tank_marker");
                self addOpt("Thresher", &give_killstreak, "straferun");
                self addOpt("Attack Helicopter", &give_killstreak, "helicopter_comlink");
                self addOpt("Strike Team", &give_killstreak, "swat_team");
                self addOpt("Gunship", &give_killstreak, "ac130");
        break;
        case "Trickshot Menu":
            self addMenu(menu, "Trickshot Menu");
                self addOpt("Binds Menu", &newMenu, "Binds Menu");
                self addOpt("Shax Menu", &newMenu, "Shax Menu");
                self addOpt("Killstreak Options Menu", &newMenu, "Killstreak Options");
                self addOpt("Fast Last", &fast_last);
                self addOpt("Spawn Crate", &spawn_crate);
                self addOpt("Delete Entity", &remove_crate);
            break;
        case "Binds Menu":
            self addMenu(menu, "Binds Menu");
                self addOpt("Nac Mod Menu", &newMenu, "Nac Mod");
                self addOptIncSlider("Fade To Black Bind ", &fade_to_black_bind, 1, 1, 4, 1);
                self addOptIncSlider("Fade To White Bind ", &fade_to_white_bind, 1, 1, 4, 1);
                self addOptIncSlider("Scavenger Bind ", &scavenger_bind, 1, 1, 4, 1);
                self addOptIncSlider("Hitmarker Bind ", &hitmarker_bind, 1, 1, 4, 1);
                self addOptIncSlider("Damage Bind ", &damage_bind, 1, 1, 4, 1);
                self addOptIncSlider("Set To One Bind ", &set_to_one_bind, 1, 1, 4, 1);
                self addOptIncSlider("Locational Teleport Bind ", &locational_bind, 1, 1, 4, 1);
                self addOptIncSlider("Canswap Bind ", &canswap_bind, 1, 1, 4, 1);
                self addOptIncSlider("Jammed Bind ", &jammed_bind, 1, 1, 4, 1);
                self addOptIncSlider("Hellstorm Bind ", &hellstorm_bind, 1, 1, 4, 1);
                self addOptIncSlider("Mid-Air Prone Bind ", &prone_bind, 1, 1, 4, 1);
                self addOptIncSlider("Give Bomb Bind ", &give_bomb_bind, 1, 1, 4, 1);
            break;
        case "Shax Menu":
            self addMenu(menu, "Shax Menu");
                self addOpt("Set Shax Weapon", &shax_weapon);
                self addOptIncSlider("Shax Reload Multiplier ", &shax_reload_multiplier, 0, 0, 5, .01);
                self addOptIncSlider("Shax Invisible Delay ", &shax_invisible, 0, 0, 5, .01);
                self addOptIncSlider("Shax Take Away Time ", &shax_take_away, 0, 0, 5, .01);
                self addOptBool(self.pers["canswap_after_shax"], "Canswap After Shax", &canswap_after_shax);
                self addOptIncSlider("Shax Bind ", &shax_bind, 1, 1, 4, 1);
            break;
        case "Nac Mod":
            self addMenu(menu, "Nac Mod");
                self addOpt("Set Nac Weapon 1", &set_nac_weapon, 1);
                self addOpt("Set Nac Weapon 2", &set_nac_weapon, 2);
                self addOptBool(self.pers["canswap_nac_mod"], "Canswap Nac Mod", &canswap_nac_mod);
                self addOptIncSlider("Nac Mod Bind ", &nac_mod_bind, 1, 1, 4, 1);
            break;
        case "Killstreak Options":
            self addMenu(menu, "Killstreak Options");
                self addOpt("Reset Kill Z Origin", &reset_kill_z_origin);
                self addOptIncSlider("Hellstorm Kill Z Origin ", &kill_z_origin, 0, 1000, 999999, 1000);
            break;
        case "Aimbot Menu":
            self addMenu(menu, "Aimbot Menu");
                self addOpt("Aimbot Weapon", &set_aimbot_weapon);
                self addOptIncSlider("Aimbot Range ", &set_aimbot_range, 50, 100, 1500, 50);
                self addOptIncSlider("Aimbot Delay ", &set_aimbot_delay, 0.0, 0.0, 2, .1);
                self addOptBool(self.pers["trickshot_aimbot"], "Trickshot Aimbot", &trickshot_aimbot);
                self addOptBool(self.pers["equipment_aimbot"], "Equipment Aimbot", &equipment_aimbot);
                self addOptBool(self.pers["unfair_aimbot"], "Unfair Aimbot", &unfair_aimbot);
            break;
        case "Bot Menu":
            self addMenu(menu, "Bot Menu");
                self addOpt("Spawn Enemy Bot", &spawn_bot, get_other_team());
                self addOpt("Spawn Friendly Bot", &spawn_bot, self.pers["team"]);
                self addOpt("Freeze Bots", &set_bot_flag, true);
                self addOpt("Unfreeze Bots", &set_bot_flag, false);
                self addOpt("Move Bots To Crosshair", &move_bots_to, "crosshair");
                self addOpt("Move Bots To Me", &move_bots_to);
                self addOpt("Bots Look At Me", &bots_look_at_me);
                self addOpt("Save Bot Spawn", &save_bot_spawns);
                self addOpt("Load Bot Spawn", &load_bot_spawns);
            break;
        case "Players":
            self addMenu(menu, "Players");
                foreach(player in level.players)
                {
                    if(!isDefined(player.playerSetting["verification"]))
                        player.playerSetting["verification"] = level.MenuStatus[level.AutoVerify];
                    
                    self addOpt("[" + player.playerSetting["verification"] + "]" + player getName(), &newMenu, "Options " + player GetEntityNumber());
                }
            break;
        case "Lobby Menu":
            self addMenu(menu, "Lobby Menu");
                self addOptBool(self.pers["sky_boxes"], "Toggle Sky Barriers", &remove_sky_barriers);
                self addOptBool(self.pers["death_barrier"], "Toggle Death Barriers", &remove_death_all_barriers);
                self addOptIncSlider("Change Gravity ", &change_gravity, 0, 800, 5000, 100);
                self addOptIncSlider("Change Timescale ", &change_timescale, 0, 1, 10, .25);
            break;
        case "Vision Menu":
            self addMenu(menu, "Vision Menu");
                self addOptBool(self.infrared, "Toggle Infrared Vision", &set_infrared_vision);
            break;
        default:
            foundplayer = false;
            for(a=0;a<level.players.size;a++)
            {
                sepmenu = StrTok(menu, " ");
                if(int(sepmenu[(sepmenu.size - 1)]) == level.players[a] GetEntityNumber())
                {
                    foundplayer = true;
                    self MenuOptionsPlayer(menu, level.players[a]);
                }
            }
            
            if(!foundplayer)
            {
                self addMenu(menu, "404 ERROR");
                    self addOpt("Page Not Found");
            }
            break;
    }
}

MenuOptionsPlayer(menu, player)
{
    self endon("disconnect");
    
    sepmenu = StrTok(menu, " " + player GetEntityNumber());
    newmenu = "";
    for(a=0;a<sepmenu.size;a++)
    {
        newmenu += sepmenu[a];
        if(a != (sepmenu.size - 1))
            newmenu += " ";
    }
    
    switch(newmenu)
    {
        case "Personal Menu":
            self addMenu(menu, "Personal Menu");
                self addOptBool(self.godmode, "Toggle God Mode", &Godmode);
                self addOptBool(self.UnlimitedAmmo, "Toggle Unlimited Ammo", &UnlimitedAmmo);
                self addOptBool(self.Noclip, "Toggle No Clip", &NoclipToggle1, self);
                self addOptBool(self.oobdisabled, "Toggle OOB", &disable_oob);
                self addOptBool(self.pers["hud"], "Toggle Hud", &toggle_hud);
                self addOptBool(self.pers["sprays_and_flourish"], "Toggle Disable Sprays and Callouts", &unbind_sprays_and_flourish);
                self addOptBool(self.pers["softland"], "Toggle Disable Fall Damage", &soft_land);
                self addOpt("Save Position", &save_position);
                self addOpt("Load Position", &load_position);
                self addOpt("Refill Gadget", &refill_gadget);
                self addOptIncSlider("stZ Tilt ", &stzTilt, 0, 0, 180, 10);
        break;
        case "Options":
            self addMenu(menu, "[" + player.playerSetting["verification"] + "]" + player getName());
                self addOpt("Verification", &newMenu, "Verification " + player GetEntityNumber());
                self addOptBool(player.oobdisabled, "Toggle OOB for Player", &disable_oob, player);
                self addOptBool(player.godmode, "Toggle God Mode for Player", &Godmode, player);
                self addOpt("Kill Player", &kill_player, player);
                self addOpt("Make Invisible", &make_invisible, player);
                self addOpt("Move Player To Me", &move_to, undefined, player);
                self addOpt("Move Player To Crosshair", &move_to, self.origin, player);
                self addOpt("Freeze Controls", &freeze_player_controls, player, true);
                self addOpt("Unfreeze Controls", &freeze_player_controls, player, false);
            break;
        case "Verification":
            self addMenu(menu, "Verification");
                for(a=0;a<(level.MenuStatus.size - 2);a++)
                    self addOptBool(player getVerification() == a, level.MenuStatus[a], &setVerification, a, player, true);
            break;
        default:
            self addMenu(menu, "404 ERROR");
                self addOpt("Page Not Found");
            break;
    }
}

menuMonitor()
{
    self endon("disconnect");
    
    while(true)
    {
        if(self getVerification() > 0)
        {
            if(!self isInMenu())
            {
                if(self gamepadusedlast() ? (self AdsButtonPressed() && self actionslotonebuttonpressed() && !isDefined(self.menu["DisableMenuControls"])) : (self AdsButtonPressed() && self MeleeButtonPressed() && !isDefined(self.menu["DisableMenuControls"])))
                {
                    if(isDefined(self.menu["currentMenu"]) && self.menu["currentMenu"] != "")
                        menu = self.menu["currentMenu"];
                    else
                        menu = "Main";
                    
                    self openMenu1(menu);
                    wait .25;
                }
            }
            else if(self isInMenu() && !isDefined(self.menu["DisableMenuControls"]))
            {
                if(self gamepadusedlast() ? (self actionslotonebuttonpressed() || self actionslottwobuttonpressed()) : (self AdsButtonPressed() || self AttackButtonPressed()))
                {
                    
                    if(self gamepadusedlast() ? (!self actionslotonebuttonpressed() || !self actionslottwobuttonpressed()) : (!self AdsButtonPressed() || !self AttackButtonPressed()))
                    {
                        curs = self getCursor();
                        menu = self getCurrent();
                        
                        self.menu["curs"][menu] += self gamepadusedlast() ? self actionslottwobuttonpressed() : self AttackButtonPressed();
                        self.menu["curs"][menu] -= self gamepadusedlast() ? self actionslotonebuttonpressed() : self AdsButtonPressed();
                        
                        arry = self.menu["items"][self getCurrent()].name;
                        curs = self getCursor();

                        if(curs < 0 || curs > (arry.size - 1))
                            self setCursor((curs < 0) ? (arry.size - 1) : 0);

                        self drawText();
                        wait .13;
                    }
                }
                else if(self UseButtonPressed())
                {
                    menu = self getCurrent();
                    curs = self getCursor();
                    
                    
                    if(isDefined(self.menu["items"][menu].func[curs]))
                    {
                        if(isDefined(self.menu["items"][menu].slider[curs]) || isDefined(self.menu["items"][menu].incslider[curs]))
                            self thread ExecuteFunction(self.menu["items"][menu].func[curs], isDefined(self.menu["items"][menu].slider[curs]) ? self.menu_S[menu][curs][self.menu_SS[menu][curs]] : self.menu_SS[menu][curs], self.menu["items"][menu].input1[curs], self.menu["items"][menu].input2[curs], self.menu["items"][menu].input3[curs], self.menu["items"][menu].input4[curs]);
                        else
                            self thread ExecuteFunction(self.menu["items"][menu].func[curs], self.menu["items"][menu].input1[curs], self.menu["items"][menu].input2[curs], self.menu["items"][menu].input3[curs], self.menu["items"][menu].input4[curs]);
                        if(isDefined(isDefined(self.menu["items"][menu].bool[curs])))
                            self RefreshMenu();
                        wait .3;
                    }
                }
                else if(self gamepadusedlast() ? (self actionslotthreebuttonpressed() || self actionslotfourbuttonpressed()) : (self SecondaryOffhandButtonPressed() || self FragButtonPressed()))
                {
                    if(self gamepadusedlast() ? (!self actionslotthreebuttonpressed() || !self actionslotfourbuttonpressed()) : (!self SecondaryOffhandButtonPressed() || !self FragButtonPressed()))
                    {
                        menu = self getCurrent();
                        curs = self getCursor();
                        
                        if(isDefined(self.menu["items"][menu].slider[curs]) || isDefined(self.menu["items"][menu].incslider[curs]))
                        {
                            inc = isDefined(self.menu["items"][menu].incslider[curs]) ? self.menu["items"][menu].intincrement[curs] : 1;
                            self.menu_SS[menu][curs] += (self gamepadusedlast() ? self actionslotfourbuttonpressed() : self FragButtonPressed()) ? inc : (inc * -1);
                            
                            if(isDefined(self.menu["items"][menu].slider[curs]))
                                self SetSlider(self.menu_SS[menu][curs]);
                            else
                                self SetIncSlider(self.menu_SS[menu][curs]);
                            self RefreshMenu();
                            wait .15;
                        }
                    }
                }
                else if(self MeleeButtonPressed())
                {

                    if(self getCurrent() == "Main")
                        self closeMenu1();
                    else
                    {
                        self newMenu();
                        
                    }
                    wait .2;
                }
            }
        }
        wait .05;
    }
}

ExecuteFunction(function, i1, i2, i3, i4, i5, i6)
{
    if(!isDefined(function))
        return;
    
    if(isDefined(i6))
        return self thread [[ function ]](i1, i2, i3, i4, i5, i6);
    if(isDefined(i5))
        return self thread [[ function ]](i1, i2, i3, i4, i5);
    if(isDefined(i4))
        return self thread [[ function ]](i1, i2, i3, i4);
    if(isDefined(i3))
        return self thread [[ function ]](i1, i2, i3);
    if(isDefined(i2))
        return self thread [[ function ]](i1, i2);
    if(isDefined(i1))
        return self thread [[ function ]](i1);
    
    return self thread [[ function ]]();
}

drawText()
{
    self endon("menuClosed");
    self endon("disconnect");
    
    if(!isDefined(self.menu["curs"][self getCurrent()]))
        self.menu["curs"][self getCurrent()] = 0;
    
    menu = self getCurrent();
    text = self.menu["items"][self getCurrent()].name;
    curs = self getCursor();
    start = 0;

    if(curs > 3 && curs < (text.size - 4) && text.size > 8)
        start = curs - 3;
    if(curs > (text.size - 5) && text.size > 8)
        start = text.size - 8;
    
    if(text.size > 0)
    {
        if(isDefined(self.menu["items"][menu].title))
            self iPrintln("^1[ " + self.menu["items"][menu].title + " ]");
        self.lastRefresh = getTime();

        numOpts = text.size;
        if(numOpts >= 8)
            numOpts = 8;
        
        for(a=0;a<numOpts;a++)
        {
            text = self.menu["items"][menu].name;
            str = text[(a + start)];
            if(isDefined(self.menu["items"][menu].bool[(a + start)]))
                str += (isDefined(self.menu_B[menu][(a + start)]) && self.menu_B[menu][(a + start)]) ? " ^1[ON]" : " ^1[OFF]";
            else if(isDefined(self.menu["items"][menu].incslider[(a + start)]))
                str += "^1 < " + self.menu_SS[menu][(a + start)] + " >";
            else if(isDefined(self.menu["items"][menu].slider[(a + start)]))
                str += " < " + self.menu_S[menu][(a + start)][self.menu_SS[menu][(a + start)]] + " >";
            
            if(curs == (a + start))
                self iPrintln("^1" + str + "");
            else
                self iPrintln("^." + str);
        }

        if(numOpts < 9)
        {
            printSize = 8 - numOpts;
            for(a=0;a<printSize;a++)
                self iPrintln(".");
        }
    }
}

RefreshMenu()
{
    if(self hasMenu() && self isInMenu())
    {
        self runMenuIndex(self getCurrent());
        self drawText();
    }
}

openMenu1(menu)
{
    if(!isDefined(menu))
        menu = "Main";
    if(!isDefined(self.menu["curs"][menu]))
        self.menu["curs"][menu] = 0;
    
    self.menu["currentMenu"] = menu;
    self runMenuIndex(menu);
    self.playerSetting["isInMenu"] = true;
    self thread MonitorMenuRefresh();
}

MonitorMenuRefresh()
{
    self endon("disconnect");
    self endon("menuClosed");

    if(self isInMenu())
    {
        self drawText();
        while(self isInMenu())
        {
            if(self.lastRefresh < GetTime() - 6000)
                self drawText();
            wait 1;
        }
    }
}

closeMenu1()
{
    self DestroyOpts();
    self notify("menuClosed");
    self.playerSetting["isInMenu"] = undefined;
}

DestroyOpts()
{
    for(a=0;a<9;a++)
        self iPrintln(".");
}
