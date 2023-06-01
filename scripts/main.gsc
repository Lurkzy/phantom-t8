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

    level.var_f46d16f0 = 1; // stops the luinotifyevent from happening on changed class

    self thread exit_game_loop();
    self thread change_class_whenever();
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