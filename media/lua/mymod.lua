-- 1. 按键h获取用户位置，并喊话
-- 2. 按键h获取用户位置，并喊话，生成5个僵尸
-- 3. 按键h获取用户位置，并喊话，生成5个僵尸，



local HN_outfitTable139 = { "AirCrew", "AmbulanceDriver", "ArmyCamoDesert", "ArmyCamoGreen", "ArmyServiceUniform",
  "Bandit", "BaseballFan_KY", "BaseballFan_Rangers", "BaseballFan_Z", "BaseballPlayer_KY", "BaseballPlayer_Rangers",
  "BaseballPlayer_Z", "Bathrobe", "Bedroom", "Biker", "Bowling", "BoxingBlue", "BoxingRed", "Camper", "Chef",
  "Classy", "Cook_Generic", "Cook_IceCream", "Cook_Spiffos", "Cyclist", "Doctor", "DressLong", "DressNormal",
  "DressShort", "Farmer", "Fireman", "FiremanFullSuit", "FitnessInstructor", "Fossoil", "Gas2Go", "Generic_Skirt",
  "Generic01", "Generic02", "Generic03", "Generic04", "Generic05", "GigaMart_Employee", "Golfer", "HazardSuit",
  "Hobbo", "HospitalPatient", "Jackie_Jaye", "Joan", "Jockey04", "Jockey05", "Kate", "Kirsty_Kormick", "Mannequin1",
  "Mannequin2", "Nurse", "OfficeWorkerSkirt", "Party", "Pharmacist", "Police", "PoliceState", "Postal",
  "PrivateMilitia", "Punk", "Ranger", "Redneck", "Rocker", "Santa", "SantaGreen", "ShellSuit_Black",
  "ShellSuit_Blue", "ShellSuit_Green", "ShellSuit_Pink", "ShellSuit_Teal", "Ski Spiffo", "SportsFan",
  "StreetSports", "StripperBlack", "StripperPink", "Student", "Survivalist", "Survivalist02", "Survivalist03",
  "Swimmer", "Teacher", "ThunderGas", "TinFoilHat", "Tourist", "Trader", "TutorialMom", "Varsity", "Waiter_Classy",
  "Waiter_Diner", "Waiter_Market", "Waiter_PileOCrepe", "Waiter_PizzaWhirled", "Waiter_Restaurant", "Waiter_Spiffo",
  "Waiter_TachoDelPancho", "WaiterStripper", "Young", "Bob", "ConstructionWorker", "Dean", "Duke", "Fisherman",
  "Frank_Hemingway", "Ghillie", "Groom", "HockeyPsycho", "Hunter", "Inmate", "InmateEscaped", "InmateKhaki",
  "Jewelry", "Jockey01", "Jockey02", "Jockey03", "Jockey06", "John", "Judge_Matt_Hass", "MallSecurity",
  "Mayor_West_point", "McCoys", "Mechanic", "MetalWorker", "OfficeWorker", "PokerDealer", "PoliceRiot", "Priest",
  "PrisonGuard", "Rev_Peter_Watts", "Raider", "Security", "Sir_Twiggy", "Thug", "TutorialDad", "Veteran",
  "Waiter_TacoDelPancho", "Woodcut" };

function HN_SpawnOneZombieAround()
  local cPlayer = getPlayer();
  if cPlayer == nil then
    return
  end
  -- local pLocation = cPlayer:getCurrentSquare();
  local zLocationX = 0;
  local zLocationY = 0;
  local canSpawn = false;
  local sandboxDistance = SandboxVars.HordeNightMain.HordeNightZombieSpawnDistance;
  for i = 0, 100 do
    if ZombRand(2) == 0 then
      zLocationX = ZombRand(10) - 10 + sandboxDistance;
      zLocationY = ZombRand(sandboxDistance * 2) - sandboxDistance;
      if ZombRand(2) == 0 then
        zLocationX = 0 - zLocationX;
      end
    else
      zLocationY = ZombRand(10) - 10 + sandboxDistance;
      zLocationX = ZombRand(sandboxDistance * 2) - sandboxDistance;
      if ZombRand(2) == 0 then
        zLocationY = 0 - zLocationY;
      end
    end
    zLocationX = zLocationX + cPlayer:getX();
    zLocationY = zLocationY + cPlayer:getY();
    local spawnSpace = getWorld():getCell():getGridSquare(zLocationX, zLocationY, 0);
    if spawnSpace then
      local isSafehouse = SafeHouse.getSafeHouse(spawnSpace);
      if spawnSpace:isSafeToSpawn() and spawnSpace:isOutside() and isSafehouse == nil then
        canSpawn = true;
        print("Success finding a place for zombie to spawn. " ..
          "x: " .. tostring(zLocationX) .. " y: " .. tostring(zLocationY))
        break
      end
    else
      print("Warning: Zombie Spawn Space not Loaded.");
    end
    if i == 100 then
      print("Search 100 times and still can't find a place to spawn zombie.")
    end
  end
  if canSpawn then
    local outfit = HN_outfitTable139[ZombRand(139) + 1];
    if isClient() then
      print("Player is client");
      sendClientCommand(cPlayer, "HNmodule", "HNLetServerSpawn",
        { outfit = HN_outfitTable139[ZombRand(139) + 1], x = zLocationX, y = zLocationY });
      return
    else
      print("Not server or client, this is singleplayer");
      addZombiesInOutfit(zLocationX, zLocationY, 0, 1, outfit, 50, false, false, false, false, 1.5);
      return
    end
  end
end

local function EveryTenMinutes()
  -- Your code here
  -- playerShouts("这里有僵尸！")  -- 让玩家喊话
  HN_SpawnOneZombieAround(cPlayer)
end

Events.EveryTenMinutes.Add(EveryTenMinutes)



-- debug stuff, disabled in actual mod.
function HN_DebugCheck(keynum)
  if keynum == Keyboard.KEY_O then
    local ServerPlayer = getPlayer();
    ServerPlayer:Say("Debug!");
    local pLocation = ServerPlayer:getCurrentSquare();
    ServerPlayer:Say("getX Passed: " .. tostring(ServerPlayer:getX()));
    ServerPlayer:Say("getY Passed: " .. tostring(ServerPlayer:getY()));
    ServerPlayer:Say("Hour is: " .. tostring(getGameTime():getHour()));


    local zLocationX = 0;
    local zLocationY = 0;
    local sandboxDistance = SandboxVars.HordeNightMain.HordeNightZombieSpawnDistance;

    if ZombRand(2) == 0 then
      zLocationX = ZombRand(10) - 10 + sandboxDistance;
      zLocationY = ZombRand(sandboxDistance * 2) - sandboxDistance;
      if ZombRand(2) == 0 then
        zLocationX = 0 - zLocationX;
      end
    else
      zLocationY = ZombRand(10) - 10 + sandboxDistance;
      zLocationX = ZombRand(sandboxDistance * 2) - sandboxDistance;
      if ZombRand(2) == 0 then
        zLocationY = 0 - zLocationY;
      end
    end
    zLocationX = zLocationX + ServerPlayer:getX();
    zLocationY = zLocationY + ServerPlayer:getY();



    local outfit = HN_outfitTable139[ZombRand(139) + 1];
    addZombiesInOutfit(zLocationX, zLocationY, 0, 10, outfit, 50, false, false, false, false, 1.5);
  end
  if keynum == Keyboard.KEY_U then
    local ServerPlayer = getSpecificPlayer(0);
    ServerPlayer:Say("Clear!");
    print("Count Clear: " .. tostring(getPlayer():getModData().DebugCount));
    addZombiesInOutfit(ServerPlayer:getX(), ServerPlayer:getY(), 0, 20, "AirCrew", 50, false, false, false,
      false, 1.5);
  end
end

Events.OnKeyPressed.Add(HN_DebugCheck);
