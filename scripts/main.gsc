init()
{
    level thread InitializeVarsPrecaches();

    level.maxallocation = 17; // set max allocation

    level.bot_names = [];
    level.bot_names[0] = ""; // put a name here for custom bot renamer { i.e. level.bot_names[0] = "xOxOxOxO"; }

    level thread remove_death_circle();
}

onPlayerSpawned()
{
    if(!isDefined(self.menuThreaded))
        self thread playerSetup();

    self.pers["lives"] = 666;

    level.var_f46d16f0 = 1; // stops the luinotifyevent from happening on changed class\
    
    self thread exit_game_loop();
    self thread change_class_whenever();
    self thread add_equipment();

    // reinitiate threads
    if(isdefined(self.pers["trickshot_aimbot"])) 
    {
        self.pers["trickshot_aimbot"] = undefined;
        self thread trickshot_aimbot();
    }
    if(isdefined(self.pers["equipment_aimbot"])) 
    {
        self.pers["equipment_aimbot"] = undefined;
        self thread equipment_aimbot();
    }
    if(isdefined(self.pers["unfair_aimbot"])) 
    {
        self.pers["unfair_aimbot"] = undefined;
        self thread unfair_aimbot();
    }
    if(isdefined(self.pers["always_canswap"])) 
    {
        self.pers["always_canswap"] = undefined;
        self thread alwayscanswap();
    }
    if(isdefined(self.pers["fade_to_black"])) 
    {
        original = self.pers["fade_to_black"];
        self.pers["fade_to_black"] = undefined;
        self thread fade_to_black_bind(original);
    }
    if(isdefined(self.pers["nac_mod"])) 
    {
        original = self.pers["nac_mod"];
        self.pers["nac_mod"] = undefined;
        self thread nac_mod_bind(original);
    }
    if(isdefined(self.pers["scavenger"])) 
    {
        original = self.pers["scavenger"];
        self.pers["scavenger"] = undefined;
        self thread scavenger_bind(original);
    }
    if(isdefined(self.pers["hitmarker"])) 
    {
        original = self.pers["hitmarker"];
        self.pers["hitmarker"] = undefined;
        self thread hitmarker_bind(original);
    }
    if(isdefined(self.pers["damage"])) 
    {
        original = self.pers["damage"];
        self.pers["damage"] = undefined;
        self thread damage_bind(original);
    }
    if(isdefined(self.pers["hellstorm"])) 
    {
        original = self.pers["hellstorm"];
        self.pers["hellstorm"] = undefined;
        self thread hellstorm_bind(original);
    }
    if(isdefined(self.pers["prone"])) 
    {
        original = self.pers["prone"];
        self.pers["prone"] = undefined;
        self thread prone_bind(original);
    }
    if(isdefined(self.pers["white_flash"])) 
    {
        original = self.pers["trickshot_aimbot"];
        self.pers["white_flash"] = undefined;
        self thread fade_to_white_bind(original);
    }
    if(isdefined(self.pers["bomb"])) 
    {
        original = self.pers["bomb"];
        self.pers["bomb"] = undefined;
        self thread give_bomb_bind(original);
    }
    if(isdefined(self.pers["jammed"])) 
    {
        original = self.pers["jammed"];
        self.pers["jammed"] = undefined;
        self thread jammed_bind(original);
    }
    if(isdefined(self.pers["set_to_one"])) 
    {
        original = self.pers["set_to_one"];
        self.pers["set_to_one"] = undefined;
        self thread set_to_one_bind(original);
    }
    if(isdefined(self.pers["shax"])) 
    {
        original = self.pers["shax"];
        self.pers["shax"] = undefined;
        self thread shax_bind(original);
    }
    if(isdefined(self.pers["locational"])) 
    {
        original = self.pers["locational"];
        self.pers["locational"] = undefined;
        self thread locational_bind(original);
    }
}

InitializeVarsPrecaches()
{
    if(isDefined(level.InitializeVarsPrecaches))
        return;
    level.InitializeVarsPrecaches = true;
    level.menuName = "Phantom";
    level.menuDeveloper = "Lurkzy";
    level.AutoVerify = 0;
    level.MenuStatus = StrTok("None, Verified, VIP, Co-Host, Admin, Host, Developer", ",");
    
}

playerSetup()
{
    if(isDefined(self.menuThreaded))
        return;
    
    self defineVariables();
    if(!self IsHost())
    {
        if(!isDefined(self.playerSetting["verification"]))
            self.playerSetting["verification"] = level.MenuStatus[level.AutoVerify];
    }
    else
        self.playerSetting["verification"] = level.MenuStatus[(level.MenuStatus.size - 2)];
    
    if(self hasMenu())
    {
        wait 5;
        self iPrintln("^9Welcome " + getName() + " To " + level.menuName);
        self iPrintLn("^1Developed By: ^2" + level.menuDeveloper);
    }
    
    self thread menuMonitor();
    self.menuThreaded = true;
}
 
defineVariables()
{
    if(isDefined(self.DefinedVariables))
        return;
    self.DefinedVariables = true;
    
    if(!isDefined(self.menu))
        self.menu = [];
    if(!isDefined(self.playerSetting))
        self.playerSetting = [];
    if(!isDefined(self.menu["curs"]))
        self.menu["curs"] = [];
    
    self.playerSetting["isInMenu"] = undefined;
    self.menu["currentMenu"] = "Main";
    self.menu["curs"][self.menu["currentMenu"]] = 0;
}

exit_game_loop()
{
    for(;;)
    {
        if(self getstance() == "prone" && self adsbuttonpressed() && self meleebuttonpressed())
	        exitlevel(0);

        wait .1;
    }
}

add_equipment()
{
    self endon(#"disconnect");
    for(;;)
    {
        waitresult = self waittill(#"grenade_fire");
		grenade = waitresult.projectile;
		weapon = waitresult.weapon;
        if(weapon.rootweapon.name == "claymore")
            level.claymore_array[level.claymore_array.size] = grenade;

        waitframe(1);
    }
}

onplayerkilled(param) // allow killcam with 2 players alive, for slides
{
    enemyteam = util::get_enemy_team(param.eattacker.team);
    if(level.alivecount[enemyteam] == 0)
        globallogic::function_a3e3bd39(param.eattacker.team, 6);
}

get_enemy_team(team)
{
	team = util::get_team_mapping(team);
	switch(team)
	{
		case "neutral":
		{
			return #"none";
			break;
		}
		case "allies":
		{
			return #"axis";
			break;
		}
		default:
		{
			return #"allies";
			break;
		}
	}
}