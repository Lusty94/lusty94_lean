Config = {}


--
--██╗░░░░░██╗░░░██╗░██████╗████████╗██╗░░░██╗░█████╗░░░██╗██╗
--██║░░░░░██║░░░██║██╔════╝╚══██╔══╝╚██╗░██╔╝██╔══██╗░██╔╝██║
--██║░░░░░██║░░░██║╚█████╗░░░░██║░░░░╚████╔╝░╚██████║██╔╝░██║
--██║░░░░░██║░░░██║░╚═══██╗░░░██║░░░░░╚██╔╝░░░╚═══██║███████║
--███████╗╚██████╔╝██████╔╝░░░██║░░░░░░██║░░░░█████╔╝╚════██║
--╚══════╝░╚═════╝░╚═════╝░░░░╚═╝░░░░░░╚═╝░░░░╚════╝░░░░░░╚═╝


--Thank you for downloading this script!

--Below you can change multiple options to suit your server needs.


Config.CoreSettings = {
    EventNames = {
        Stress = 'hud:server:RelieveStress', -- name of stress event
    },
    Target = {
        Type = 'qb', -- support for qb-target and ox_target    
        --use 'qb' for qb-target
        --use 'ox' for ox_target
    },
    Notify = {
        Type = 'qb', -- notification type, support for qb-core notify, okokNotify, mythic_notify, boii_ui notify and ox_lib notify
        --use 'qb' for default qb-core notify
        --use 'okok' for okokNotify
        --use 'mythic' for myhthic_notify
        --use 'boii' for boii_ui notify
        --use 'ox' for ox_lib notify
    },
    Inventory = { -- support for qb-inventory and ox_inventory
        Type = 'qb',
        --use 'qb' for qb-inventory
        --use 'ox' for ox_inventory
    },
    Phone = {
        Type = 'qb', -- support for qb-phone and qs-smartphone    
        --use 'qb' for qb-phone
        --use 'qs' for qs-smartphone
        --use 'custom' for another phone system - add email support at line 335 in lean_client.lua
    },
    Police = { -- support for qb-policejob and ps-dispatch
        MinCops = 1, -- minimum amount of cops required on duty to request mission
        Type = 'qb',
        --use 'qb' for qb-policejob
        --use 'ps' for ps-dispatch
    },
    Timers = {
        SearchBody = 5000, -- time it takes to search body
        MixLean = 5000, -- time it takes to mix lean
        DrinkLean = 5000, -- time it takes to drink lean
        RequestMission = 10 * 1000 * 60, -- time to wait before requesting another mission default is 10 minutes
        LeanEffect = 30 * 1000, --effects timer for drinking lean default is 30 seconds
    },
    Chances = {
        SearchBody = 100, -- chance to successfully search body
        CallPolice = 100, -- chance to call police
    }, 
}


-- XP settings
Config.XP = { -- use xp 
    Enabled = false, -- Toggles xp system on or off; true = on, false = off
    Command = false, -- Toggles commands on or off use /leanxp or whatever you have named the metadata
    MetaDataName = 'leanxp', -- The name of your xp if you edit this make sure to also edit the line you added into qb-core/server/player.lua - new core goes into config - you might also need to change how metadata is assigned
    XPChance = 75, -- chance to earn xp when delivering packages
    Levels = { -- Change your xp requirements here to suit your server set these as high as you want preset xp increase = (xp / 0.8) if changing amounts dont forget to edit server file also where items are given to match new xp amounts
        150, -- level 2 
        250, -- level 3 
        500, -- level 4
        750, -- level 5
        1000, -- level 6
        1250, -- level 6
        1500, -- level 7
        1750, -- level 8
        2200, -- level 9
        2500, -- level 10 
    }
}

Config.InteractionLocations = {
    StartPedLocations = { -- locations for the mission start ped to spawn at - must be vector4
        vector4(-83.04, -1399.58, 27.32, 187.07),
        vector4(-138.91, -1626.32, 31.75, 232.49),
        vector4(-693.45, -1015.37, 15.42, 300.08),
        vector4(-1093.6, -1608.35, 7.46, 308.06),
        vector4(-1311.08, -1307.51, 3.87, 216.97),
        vector4(-1286.77, -833.71, 16.1, 323.52),
        vector4(-496.86, 79.84, 54.87, 89.68),
    },
    StartLocations = { -- locations for the van to spawn at - must be vector4
        vector4(-1471.0, -682.72, 26.61, 123.0),
        vector4(-1319.66, -1217.99, 4.81, 17.33),
        vector4(-522.41, -874.0, 28.5, 268.81),
        vector4(-282.93, -1029.92, 30.38, 337.89),
        vector4(-174.25, -1366.58, 30.38, 214.85),
        vector4(-97.44, -1585.17, 31.41, 318.08),
        vector4(473.64, -1582.05, 29.11, 328.34),
    },
    DestinationLocations = { -- locations for the van to drive to - must be vector3
        vector3(346.57, -1101.39, 29.42),
        vector3(-174.98, 6.39, 57.0),
        vector3(122.31, -116.49, 54.84),
        vector3(693.22, -1004.51, 22.94),
        vector3(879.69, -1657.76, 30.27),
        vector3(1025.37, -2198.03, 30.6),
        vector3(437.12, -1837.61, 27.96),
        vector3(-196.65, -1695.32, 33.37),
        vector3(-95.95, -1465.69, 33.15),
        vector3(329.83, -1280.96, 31.72),
        vector3(1369.81, -1537.0, 55.99),
        vector3(203.96, 778.94, 205.72),
    },
    Vehicle = { -- vehicle settings
        { 
            model = 'gburrito2',
            driverweapon = 'weapon_combatshotgun',
            drivermodel = 'g_m_y_lost_02',
            passengerweapon = 'weapon_microsmg',
            passengermodel = 'g_m_y_salvaboss_01',
            targeticon = 'fa-solid fa-users',
            targetlabel = 'Search Body',
            targetdistance = 2.0,
        },
    }, 
}

Config.Animations = {
    SearchBody = {
        anim = 'fixing_a_ped',
        dict = 'mini@repair',
        flag = 49,
    },
    MixLean = {
        anim = 'fixing_a_ped',
        dict = 'mini@repair',
        flag = 49,
        prop1 = 'prop_plastic_cup_02',
        bone1 = 57005,
        pos1 = vec3(0.14, 0.04, -0.04),
        rot1 = vec3(-60.0, 100.0, 0.0),
        prop2 = 'prop_choc_pq',
        bone2 = 18905,
        pos2 = vec3(0.14, 0.04, 0.0),
        rot2 = vec3(-60.0, 100.0, 0.0),
    },
    DrinkLean = {
        anim = 'loop_bottle',
        dict = 'mp_player_intdrink',
        flag = 49,
        prop = 'bzzz_prop_drugs_lean_cup',
        bone = 60309,
        pos = vec3(0.00, 0.01, 0.08),
        rot = vec3(0.0, 0.0, 0.0),
    },
}

Config.Language = {
    ProgressBar = {
        SearchBody = 'Searching Body',
        MixLean = 'Mixing lean',
        DrinkLean = 'Drinking lean',
    },
    Notifications = {
        Busy = 'You are already doing something!',
        Cancelled = 'Action cancelled!',
        Failed = 'Action failed!',
        CantCarry = 'You cant carry anymore!',
        NothingFound = 'you found nothing of use!',
        VehicleAlreadySpawned = 'A vehicle has already been spawned!',
        CheckGPS = 'check your GPS for a marked vehicle!',
        Wait = 'You must wait a while before doing that!',
        TextMessage = 'You will be sent text message with more information shortly!',
        WrongPhone = 'You dont have the correct phone to do that!',
        MissingItems = 'You are missing items. check the requirements!',
        NoPolice = 'Not enough cops on duty!',
        EarnedXP = 'You earned some XP!',
        NoCup = 'Missing plastic cup!',
        NoDrink = 'Missing fizzy drink!',
        NoSweets = 'Missing sweets!',
        NoCodeine = 'Missing codeine promethazine!',
    },
}