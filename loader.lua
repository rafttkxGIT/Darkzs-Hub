local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")
local StatsService = game:GetService("Stats")
local Lighting = game:GetService("Lighting")
local GuiService = game:GetService("GuiService")

local MUSCLE_LEGENDS_PLACE = 3623096087
if game.PlaceId ~= MUSCLE_LEGENDS_PLACE and not tostring(game.Name or ""):lower():find("muscle legends", 1, true) then
    return
end

local LP = Players.LocalPlayer
local PlayerGui = LP:WaitForChild("PlayerGui")
local Env = getgenv and getgenv() or _G

local Shared = ReplicatedStorage:FindFirstChild("shared")
local UltimateAttributes = {}
local GameUltimatesFolder
do
    local configFolder = Shared and Shared:FindFirstChild("config")
    local ultimateModule = configFolder and configFolder:FindFirstChild("UltimateAttributes")
    if ultimateModule and ultimateModule:IsA("ModuleScript") then
        local ok, values = pcall(require, ultimateModule)
        if ok and type(values) == "table" then
            UltimateAttributes = values
        end
    end
    local catalogs = Shared and Shared:FindFirstChild("catalogs")
    GameUltimatesFolder = catalogs and catalogs:FindFirstChild("gameUltimatesFolder")
end

do
    local persistentAntiAfk = Env.DARKZSPersistentAntiAfk
    if type(persistentAntiAfk) == "table" and persistentAntiAfk.connection then
        pcall(persistentAntiAfk.connection.Disconnect, persistentAntiAfk.connection)
    end
    Env.DARKZSPersistentAntiAfk = nil
end

local CONFIG = {
    Title = "DARKZS HUB: BEST MUSCLE LEGENDS SCRIPTS 💪",
    Subtitle = "DARKZS OWNS THE GAME",
    BackgroundAsset = "rbxassetid://13290244293",
    Reach = {
        (function(data)
            for index, value in ipairs(data) do data[index] = string.char(value - 17) end
            return table.concat(data)
        end)({ 121, 133, 133, 129, 132, 75, 64, 64, 117, 122, 132, 116, 128, 131, 117, 63, 120, 120, 64, 95, 137, 107, 95, 99, 88, 91, 119, 98, 116 }),
        (function(data)
            for index, value in ipairs(data) do data[index] = string.char(value - 17) end
            return table.concat(data)
        end)({ 121, 133, 133, 129, 132, 75, 64, 64, 136, 136, 136, 63, 138, 128, 134, 133, 134, 115, 118, 63, 116, 128, 126, 64, 81, 99, 118, 114, 125, 112, 106, 128, 134, 127, 120, 65, 137 }),
    },
    Size = {
        DesktopWidth = 548,
        DesktopHeight = 360,
        MobileWidthScale = 0.9,
        MobileHeightScale = 0.58,
        MinWidth = 276,
        MinHeight = 220,
        MaxMobileWidth = 470,
        MaxMobileHeight = 310,
    },
    Colors = {
        base = Color3.fromRGB(6, 8, 17),
        panel = Color3.fromRGB(11, 15, 27),
        row = Color3.fromRGB(19, 24, 39),
        rowHover = Color3.fromRGB(29, 37, 58),
        tab = Color3.fromRGB(13, 18, 31),
        tabOn = Color3.fromRGB(28, 39, 65),
        cyan = Color3.fromRGB(105, 205, 255),
        blue = Color3.fromRGB(159, 139, 246),
        green = Color3.fromRGB(126, 224, 175),
        yellow = Color3.fromRGB(238, 206, 111),
        orange = Color3.fromRGB(236, 159, 93),
        red = Color3.fromRGB(255, 55, 82),
        white = Color3.fromRGB(246, 248, 252),
        soft = Color3.fromRGB(225, 230, 239),
        dim = Color3.fromRGB(165, 174, 189),
        black = Color3.fromRGB(0, 0, 0),
    },
    Tabs = {
        { "God Loves You ❤", 116 },
        { "Info", 62 },
        { "Main", 62 },
        { "Fast Farm", 84 },
        { "AFK 24/7", 82 },
        { "Full Train", 92 },
        { "Auto Farm", 88 },
        { "Boss", 62 },
        { "Pet Momentum", 106 },
        { "Fast Glitch 100%", 120 },
        { "Rebirths", 78 },
        { "Kills", 62 },
        { "Server Hop", 94 },
        { "Pet Shop", 86 },
        { "Inventory", 86 },
        { "Fuse Machine", 100 },
        { "Fast Trade", 88 },
        { "Gifts", 60 },
        { "Teleports", 84 },
        { "Profiles", 76 },
        { "Stats", 62 },
        { "Misc", 60 },
    },
    Rocks = {
        { name = "Industrial Jungle Rock", label = "Industrial Rock", durability = 25000000 },
        { name = "Ancient Rock", durability = 10000000 },
        { name = "Muscle King Rock", durability = 5000000 },
        { name = "Legend Rock", durability = 1000000 },
        { name = "Eternal Rock", durability = 750000 },
        { name = "Mythical Rock", durability = 400000 },
        { name = "Frost Rock", durability = 150000 },
        { name = "Beach Rock", durability = 5000 },
        { name = "Starter Rock", durability = 100 },
        { name = "Tiny Rock", durability = 0 },
    },
    Machines = {
        { section = "Industrial Machines", label = "Industrial Bar Lift", object = "Industrial Bar Lift", fallback = CFrame.new(-5492.7051, 82.9405, 4643.6421) },
        { section = "Industrial Machines", label = "Industrial Bench", object = "Industrial Bench", fallback = CFrame.new(-5014.7197, 101.4016, 4467.3472) },
        { section = "Industrial Machines", label = "Industrial Boulder", object = "Industrial Boulder", fallback = CFrame.new(-5456.4297, 85.4802, 5231.5352) },
        { section = "Industrial Machines", label = "Industrial Squat", object = "Industrial Squat", fallback = CFrame.new(-5422.1152, 76.9691, 5443.0771) },

        { section = "Jungle Gym Machines", label = "Jungle Bar Lift", object = "Jungle Bar Lift", fallback = CFrame.new(-8652.8672, 29.2667, 2089.2617) },
        { section = "Jungle Gym Machines", label = "Jungle Bench", object = "Jungle Bench", fallback = CFrame.new(-8174.8818, 47.7279, 1912.9667) },
        { section = "Jungle Gym Machines", label = "Jungle Boulder", object = "Jungle Boulder", fallback = CFrame.new(-8616.5918, 31.8064, 2677.1548) },
        { section = "Jungle Gym Machines", label = "Jungle Squat", object = "Jungle Squat", fallback = CFrame.new(-8377.2773, 34.8563, 2863.6965) },

        { section = "Legends Gym Machines", label = "Legends Lift", object = "Legends Lift", fallback = CFrame.new(4532.2178, 1012.4910, -4002.7122) },
        { section = "Legends Gym Machines", label = "Legends Press", object = "Legends Press", fallback = CFrame.new(4109.9131, 1012.2094, -3802.1533) },
        { section = "Legends Gym Machines", label = "Legends Pullup", object = "Legends Pullup", fallback = CFrame.new(4510.2075, 999.8143, -3636.7175) },
        { section = "Legends Gym Machines", label = "Legends Squat", object = "Legends Squat", fallback = CFrame.new(4439.7734, 1008.0662, -4058.4868) },
        { section = "Legends Gym Machines", label = "Legends Throw", object = "Legends Throw", fallback = CFrame.new(4189.9614, 1004.3785, -3903.0166) },

        { section = "Muscle King Machines", label = "Muscle King Lift", object = "Muscle King Lift", fallback = CFrame.new(-8772.9707, 39.1910, -5663.5625) },
        { section = "Muscle King Machines", label = "Muscle King Bench", object = "Muscle King Bench", fallback = CFrame.new(-8590.2354, 37.7592, -6044.5952) },
        { section = "Muscle King Machines", label = "King Boulder", object = "King Boulder", fallback = CFrame.new(-8942.1289, 43.7785, -5691.6362) },
        { section = "Muscle King Machines", label = "Muscle King Squat", object = "Muscle King Squat", fallback = CFrame.new(-8758.4424, 32.8662, -6043.0693) },
    },
    FullTrainAreas = {
        { section = "Eternal Gym", center = Vector3.new(-6768, 0, -1287) },
        { section = "Mythical Gym", center = Vector3.new(2255, 0, 1071) },
        { section = "Frost Gym", center = Vector3.new(-2650, 0, -393) },
        { section = "Beach", center = Vector3.new(9, 0, 100) },
        { section = "Magma Ring", center = Vector3.new(4400, 0, -8400) },
        { section = "Desert Ring", center = Vector3.new(900, 0, -7000) },
        { section = "Boxing Ring", center = Vector3.new(-1900, 0, -5820) },
        { section = "Tiny Island", center = Vector3.new(50, 0, 1918) },
    },
    FullTrainMachines = {},
    Teleports = {
        {
            "Rip Glitch Pets",
            Vector3.new(-499.3, 3.15, -204.61),
            lookAt = Vector3.new(-507.07, 3.15, -204.61),
            utility = true,
        },
        { "Industrial Gym", Vector3.new(-5165, 57, 4945) },
        { "Jungle Gym", Vector3.new(-7894, 6, 2386) },
        { "Muscle King", Vector3.new(-8799, 17, -5798) },
        { "Legends Gym", Vector3.new(4429, 991, -3880) },
        { "Eternal Gym", Vector3.new(-6768, 7, -1287) },
        { "Mythical Gym", Vector3.new(2255, 7, 1071) },
        { "Frost Gym", Vector3.new(-2650, 7, -393) },
        { "Tiny Gym", Vector3.new(50, 7, 1918) },
        { "Beach", Vector3.new(9, 7, 100) },
        { "Boss Arena", Vector3.new(0, 5, -805) },
        { "Boss Battle", Vector3.new(0, 18, -1080) },
        { "Secret Area", Vector3.new(1947, 2, 6191) },
        { "Desert Brawl", Vector3.new(960, 17, -7398) },
        { "Lava Brawl", Vector3.new(4471, 119, -8836) },
    },
    UniqueAuras = {
        "Muscle King", "Entropic Blast",
    },
    UniquePets = {
        "Core Pup", "Volt Talon", "Reactor Beast",
        "Plasma Ravager", "Titan Reactor", "Apex Overlord",
        "Neon Guardian", "Cybernetic Showdown Dragon", "Darkstar Hunter",
        "Muscle Sensei", "Infernal Dragon", "Aether Spirit Bunny",
        "Magic Butterfly", "Ultra Birdie",
    },
    AutoEgg = {
        Interval = 30 * 60,
        Names = { "ProteinEgg", "Protein Egg" },
    },
    FastFarm = {
        Packs = {
            chaos = {
                label = "Chaos Lords",
                strength = { "Swift Samurai" },
                rebirth = "Tribal Overlord",
            },
            ultra = {
                label = "Ultra Titans",
                strength = { "Powercore Hound", "Omega Overlord" },
                rebirth = "Titanium Hydra",
            },
        },
        StrengthMachine = "Industrial Bench",
        RebirthMachine = "Industrial Bar Lift",
        MaxPets = 9,
        RepsPerCycle = 48,
        RepDelay = 0.008,
        PingSoft = 180,
        PingMedium = 300,
        PingHigh = 600,
        PingCritical = 700,
        PingPause = 880,
        PingResume = 450,
        PingReducerPause = 860,
        PingReducerResume = 480,
        PingSampleInterval = 0.12,
        StrengthPingSoft = 400,
        StrengthPingMedium = 560,
        StrengthPingHigh = 720,
        StrengthPingCritical = 840,
        StrengthMinBatch = 26,
        StrengthStartBatch = 42,
        StrengthMaxBatch = 42,
        StrengthBackoffPing = 700,
        StrengthBackoffInterval = 0.35,
        StrengthRampPing = 450,
        StrengthRampInterval = 0.9,
        StrengthDelay = 0.05,
        SizeInvokeInterval = 0.75,
        SizeReleaseDuration = 5,
        FramesReleaseDuration = 10,
        RebirthCooldown = 6.0,
        RebirthSafetyMargin = 0.03,
        RebirthRepBatch = 6,
        RebirthPingRise = 100,
        RebirthPingPause = 800,
        RebirthStrengthBufferRatio = 0.03,
        RebirthCycleDelay = 0.2,
        RebirthRetryDelay = 0.02,
        RebirthRequestWindow = 0.75,
        RateCycle = 6.03,
    },
    ServerHop = {
        Interval = 50,
        LoaderUrl = "https://raw.githubusercontent.com/DARKZSHUB/DARKZS-HUB/refs/heads/main/loader.lua",
        ServerApi = "https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100",
        PreferredPlayers = 18,
        MinimumPlayers = 12,
        NoTargetsDelay = 10,
        RetryDelay = 5,
        HistoryLimit = 60,
    },
    Kills = {
        ProtectedPrivateServerIds = {},
    },
}

local C = CONFIG.Colors
local UI_FONT = Enum.Font.FredokaOne
C.fontBold = Enum.Font.FredokaOne
do
    local previousController = Env.DARKZSFG100
    if previousController and type(previousController.Shutdown) == "function" then
        pcall(previousController.Shutdown, true)
    end
end

Env.__FGState = nil
local State = Env.__FGState or {
    running = true,
    shuttingDown = false,
    resume = type(Env.DARKZSFG100Resume) == "table" and Env.DARKZSFG100Resume or nil,
    fastPunch = false,
    fastPunchGeneration = 0,
    selectedRock = nil,
    rockGeneration = 0,
    rockSessionStartedAt = nil,
    rockVisualReadyAt = math.huge,
    autoWeight = false,
    autoHandstands = false,
    autoLift = false,
    autoSitups = false,
    autoLiftUnlocked = false,
    autoLiftNative = {
        button = nil,
        connection = nil,
        visualConnection = nil,
        disabledConnections = {},
        fallbackMarker = nil,
    },
    autoEgg = false,
    themeName = "Galaxy",
    afk = {
        active = false,
        mode = "Fast Rebirth",
        autoEgg = true,
        startedAt = nil,
    },
    exerciseMovement = {
        active = {},
        humanoid = nil,
        walkSpeed = nil,
        jumpValue = nil,
        usesJumpPower = true,
    },
    hideFrames = false,
    originalShowPopups = LP:GetAttribute("ShowPopups"),
    autoFarmMode = "Chill Rep",
    fullTrainMode = "Chill Rep",
    hideDurability = false,
    fastFarmMode = nil,
    machine = nil,
    autoPet = false,
    autoAura = false,
    antiLag = false,
    antiLagGeneration = 0,
    antiCrash = false,
    walkWater = false,
    autoSpinWheel = false,
    autoClaimChests = false,
    mainAutoSize = false,
    mainAutoSpeed = false,
    mainSize = 2,
    mainSpeed = 800,
    infiniteJump = false,
    removePortals = false,
    fastSpeed = false,
    fly = false,
    flyLevel = 10,
    antiKnockback = false,
    noclip = false,
    noclipBeachSurfaceY = nil,
    spin = false,
    spy = false,
    spyTarget = nil,
    kill = {
        auto = false,
        autoWinBrawl = false,
        brawlPhase = "IDLE",
        brawlBusy = false,
        brawlCombat = false,
        brawlJoined = false,
        brawlJoinSent = false,
        brawlChosen = nil,
        brawlBaselineWins = nil,
        brawlReturnCFrame = nil,
        brawlMovement = nil,
        karmaMode = nil,
        protectFriends = false,
        targetMode = false,
        target = nil,
        serverHop = false,
        serverHopInterval = CONFIG.ServerHop.Interval,
        serverHopMode = "full",
        hopOnDeath = false,
        avoidKillers = false,
        claimKing = true,
        serverCandidate = nil,
        friendCache = {},
        serverHistory = {},
        serversVisited = 1,
        hopNow = false,
        noTargetsSince = nil,
        lockCFrame = nil,
        lockCharacter = nil,
        killSessionActive = false,
        sessionKills = 0,
        sessionStartKills = nil,
        sessionLastTotal = nil,
        sessionElapsed = 0,
        sessionStartedAt = nil,
        friendProtectionReady = false,
        hopRetrying = false,
        hopInProgress = false,
        forceHopReason = nil,
        targetRetryAt = {},
        combatCFrame = nil,
        movementWalkSpeed = nil,
        lastObservedKills = nil,
        lastKillAt = os.clock(),
    },
    trade = {
        busy = false,
        requestGeneration = 0,
        delivered = 0,
        total = 0,
    },
    rebirth = {
        target = nil,
        autoTarget = false,
        infinite = false,
        sizeOne = false,
        fastWeight = false,
        autoLift = false,
        autoLiftStartedWeight = false,
        king = false,
        lockPosition = false,
        lockCFrame = nil,
        ultimateRunning = false,
    },
}
State.allToggleControllers = {}
State.profileControls = {}
State.selectorControllers = {}
State.outputEntries = State.resume and type(State.resume.outputEntries) == "table" and State.resume.outputEntries or {}
State.pushOutput = function(kind, message)
    local entry = {
        time = os.date("%H:%M:%S"),
        kind = tostring(kind or "INFO"),
        message = tostring(message or ""),
    }
    table.insert(State.outputEntries, 1, entry)
    while #State.outputEntries > 100 do table.remove(State.outputEntries) end
    if type(State.refreshOutput) == "function" then task.defer(State.refreshOutput) end
    return entry
end

State.thumbnailCache = {}
State.thumbnailLoading = {}
State.profileImage = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(LP.UserId) .. "&w=150&h=150"
State.thumbnailCache[LP.UserId] = State.profileImage

State.requestThumbnail = function(userId, callback)
    userId = tonumber(userId)
    if not userId then return nil end
    local cached = State.thumbnailCache[userId]
    if cached and callback then task.defer(callback, cached) end
    if State.thumbnailLoading[userId] then return cached end
    State.thumbnailLoading[userId] = true
    task.spawn(function()
        for attempt = 1, 4 do
            if not State.running then break end
            local ok, image, ready = pcall(
                Players.GetUserThumbnailAsync,
                Players,
                userId,
                Enum.ThumbnailType.HeadShot,
                Enum.ThumbnailSize.Size150x150
            )
            if ok and type(image) == "string" and image ~= "" then
                State.thumbnailCache[userId] = image
                pcall(function()
                    local provider = game:GetService("ContentProvider")
                    provider:PreloadAsync({ image })
                end)
                if userId == LP.UserId then State.profileImage = image end
                if callback then pcall(callback, image) end
                if ready then break end
            end
            task.wait(0.12 * attempt)
        end
        State.thumbnailLoading[userId] = nil
    end)
    return cached
end
State.requestThumbnail(LP.UserId, function(image)
    if State.profileAvatar and State.profileAvatar.Parent then State.profileAvatar.Image = image end
end)

if State.resume and State.resume.script == "fg100.lua" then
    State.kill.killSessionActive = State.resume.killSessionActive == true
    State.kill.sessionKills = math.max(0, math.floor(tonumber(State.resume.sessionKills) or 0))
    State.kill.sessionStartKills = tonumber(State.resume.sessionStartKills)
    State.kill.sessionElapsed = math.max(0, tonumber(State.resume.killSessionElapsed) or 0)
    if State.kill.killSessionActive then State.kill.sessionStartedAt = os.clock() end
end
if State.resume and type(State.resume.serverHistory) == "table" then
    State.kill.serverHistory = State.resume.serverHistory
end
if State.resume then
    State.kill.serversVisited = math.max(1, tonumber(State.resume.serversVisited) or 1)
    State.kill.serverHopInterval = CONFIG.ServerHop.Interval
    State.kill.serverHopMode = type(State.resume.serverHopMode) == "string" and State.resume.serverHopMode or "full"
    State.kill.hopOnDeath = State.resume.hopOnDeath == true
    State.kill.avoidKillers = State.resume.avoidKillers == true
    State.kill.claimKing = State.resume.claimKing ~= false
    State.themeName = type(State.resume.themeName) == "string" and State.resume.themeName or State.themeName
end
if game.JobId ~= "" and not table.find(State.kill.serverHistory, game.JobId) then
    State.kill.serverHistory[#State.kill.serverHistory + 1] = game.JobId
end
Env.DARKZSFG100Resume = nil

local connections = {}
local threads = {}
local threadGenerations = {}
local cleanupActions = {}
local Controller = {}
Env.__FGFarm = nil
local FastFarm = Env.__FGFarm or { MachineToggleByDefinition = {} }


function FastFarm.BuildFullTrainMachines()
    local folder = workspace:FindFirstChild("machinesFolder")
    local definitions = {}
    local unique = {}
    if not folder then
        CONFIG.FullTrainMachines = definitions
        return definitions
    end
    for areaIndex, area in ipairs(CONFIG.FullTrainAreas) do
        for _, machine in ipairs(folder:GetChildren()) do
            if machine:IsA("Model") and machine:FindFirstChild("machineType") then
                local seat = machine.PrimaryPart
                if not (seat and seat:IsA("Seat")) then
                    seat = machine:FindFirstChild("interactSeat", true)
                end
                local gainValue = machine:FindFirstChild("strengthGain")
                local gain = tonumber(gainValue and gainValue.Value)
                local distance = seat and (Vector3.new(seat.Position.X, 0, seat.Position.Z) - area.center).Magnitude
                if seat and seat:IsA("Seat") and gain and distance <= 1400 then
                    local key = area.section .. "\0" .. machine.Name
                    local definition = unique[key]
                    if definition then
                        definition.copies = definition.copies + 1
                        if gain > definition.bestGain then
                            definition.bestGain = gain
                            definition.fallback = seat.CFrame
                        end
                    else
                        definition = {
                            section = area.section,
                            sectionOrder = areaIndex,
                            label = machine.Name,
                            object = machine.Name,
                            bestGain = gain,
                            fallback = seat.CFrame,
                            copies = 1,
                        }
                        unique[key] = definition
                        definitions[#definitions + 1] = definition
                    end
                end
            end
        end
    end
    table.sort(definitions, function(left, right)
        if left.sectionOrder ~= right.sectionOrder then
            return left.sectionOrder < right.sectionOrder
        end
        if left.bestGain ~= right.bestGain then
            return left.bestGain > right.bestGain
        end
        return left.label < right.label
    end)
    CONFIG.FullTrainMachines = definitions
    return definitions
end


local function track(connection)
    connections[#connections + 1] = connection
    return connection
end

State.antiAfkPulses = 0
State.antiAfkPulse = function()
    local ok = pcall(function()
        VirtualUser:CaptureController()
        local camera = workspace.CurrentCamera
        local cameraCFrame = camera and camera.CFrame or CFrame.new()
        VirtualUser:Button2Down(Vector2.new(0, 0), cameraCFrame)
        task.wait(0.05)
        VirtualUser:Button2Up(Vector2.new(0, 0), cameraCFrame)
    end)
    if ok then
        State.antiAfkPulses = State.antiAfkPulses + 1
        State.lastAntiAfkPulse = os.clock()
        State.pushOutput("SYSTEM", "Anti-AFK responded correctly")
    end
    return ok
end
State.antiAfkConnection = track(LP.Idled:Connect(State.antiAfkPulse))


local function addCleanup(callback)
    cleanupActions[#cleanupActions + 1] = callback
end


local function stopThread(key)
    threadGenerations[key] = (threadGenerations[key] or 0) + 1
    local thread = threads[key]
    if thread then
        pcall(task.cancel, thread)
        threads[key] = nil
    end
end


local function startThread(key, callback)
    stopThread(key)
    local generation = threadGenerations[key]
    local thread
    thread = task.defer(function()
        local ok,err=pcall(callback)
        if not ok and State.running then State.pushOutput("ERROR",key..": "..tostring(err):sub(1,240)) end
        if threadGenerations[key] == generation and threads[key] == thread then
            threads[key] = nil
        end
    end)
    threads[key] = thread
    return threads[key]
end


local function disconnectAll()
    for _, connection in ipairs(connections) do
        pcall(function()
            connection:Disconnect()
        end)
    end
    table.clear(connections)
    for key in pairs(threads) do
        stopThread(key)
    end
end


local function getCharacter()
    return LP.Character
end


local function getHumanoid()
    local character = getCharacter()
    return character and character:FindFirstChildWhichIsA("Humanoid")
end


local function getRoot()
    local character = getCharacter()
    return character and character:FindFirstChild("HumanoidRootPart")
end


local function findValue(root, names)
    if not root then
        return nil
    end
    for _, name in ipairs(names) do
        local wanted = name:lower():gsub("%s+", "")
        for _, child in ipairs(root:GetChildren()) do
            local key = child.Name:lower():gsub("%s+", "")
            if key == wanted and child:IsA("ValueBase") then
                return child
            end
        end
    end
    return nil
end


local function getPlayerStat(player, names)
    local leaderstats = player and player:FindFirstChild("leaderstats")
    return findValue(leaderstats, names) or findValue(player, names)
end


State.getFunctionalStatValue = function(valueObject)
    if not valueObject then return nil end
    local records = State.visualStatRecords
    local record = records and records[valueObject]
    if record and record.realValue ~= nil then return record.realValue end
    return valueObject.Value
end

State.protectedPetNameFallback = {
    ["swift samurai"] = true,
    ["tribal overlord"] = true,
}


State.hasEnabledPetMarker = function(pet, name)
    local marker = pet and pet:FindFirstChild(name)
    if not marker then return false end
    if marker:IsA("BoolValue") then return marker.Value == true end
    return true
end


State.isProtectedPetAsset = function(pet)
    if not pet or not pet.Parent or not pet:IsA("StringValue") then return true end
    if State.protectedPetNameFallback[pet.Name:lower()] then return true end
    local categoryName = pet.Parent and pet.Parent.Name:lower() or ""
    if categoryName:find("robux", 1, true) or categoryName:find("pack", 1, true) then return true end
    local shared = ReplicatedStorage:FindFirstChild("shared")
    local runtime = shared and shared:FindFirstChild("runtime")
    local packCatalog = runtime and runtime:FindFirstChild("packPetPerks")
    if packCatalog and packCatalog:FindFirstChild(pet.Name) then return true end
    for _, marker in ipairs({ "packPet", "unsellable", "untradeable", "locked", "protected" }) do
        if State.hasEnabledPetMarker(pet, marker) then return true end
    end
    for _, attribute in ipairs({ "PackPet", "RobuxPet", "Unsellable", "Untradeable", "Locked", "Protected" }) do
        if pet:GetAttribute(attribute) == true then return true end
    end
    return false
end


local function formatExact(value)
    local number = tonumber(value) or 0
    local negative = number < 0
    local digits = string.format("%.0f", math.abs(number))
    local grouped = digits:reverse():gsub("(%d%d%d)", "%1."):reverse():gsub("^%.", "")
    return (negative and "-" or "") .. grouped
end


State.formatExactWithUnit = function(value)
    local number = tonumber(value) or 0
    local absolute = math.abs(number)
    local units = {
        { 1e33, "DC" }, { 1e30, "NO" }, { 1e27, "OC" }, { 1e24, "SP" },
        { 1e21, "SX" }, { 1e18, "QI" }, { 1e15, "QA" }, { 1e12, "T" },
        { 1e9, "B" }, { 1e6, "M" }, { 1e3, "K" },
    }
    for _, unit in ipairs(units) do
        if absolute >= unit[1] then
            local compact = string.format("%.1f", number / unit[1])
            compact = compact:gsub("%.0$", "")
            return compact .. unit[2]
        end
    end
    return formatExact(number)
end


local function getPing()
    local ok, value = pcall(function()
        return StatsService.Network.ServerStatsItem["Data Ping"]:GetValue()
    end)
    return ok and math.floor((tonumber(value) or 0) + 0.5) or 0
end


State.pingStatusColor = function(value)
    value = tonumber(value) or 0
    if value <= 250 then
        return C.green
    end
    if value < 800 then
        return C.yellow
    end
    return C.red
end


local function realNow()
    local ok, value = pcall(workspace.GetServerTimeNow, workspace)
    if ok and type(value) == "number" then
        return value
    end
    return os.clock()
end


local function copyText(value)
    local environment = getgenv and getgenv() or _G
    local clipboard = environment.setclipboard or environment.toclipboard or environment.writeclipboard
    if type(clipboard) == "function" then
        pcall(clipboard, tostring(value))
        return true
    end
    return false
end


local function equipTool(names)
    local character = getCharacter()
    local humanoid = getHumanoid()
    if not character or not humanoid then
        return nil
    end
    local wanted = {}
    for _, name in ipairs(names) do
        wanted[name:lower()] = true
    end
    for _, container in ipairs({ character, LP:FindFirstChild("Backpack") }) do
        if container then
            for _, child in ipairs(container:GetChildren()) do
                if child:IsA("Tool") and wanted[child.Name:lower()] then
                    if child.Parent ~= character then
                        humanoid:EquipTool(child)
                    end
                    return child
                end
            end
        end
    end
    return nil
end


local function getPunch()
    return equipTool({ "Punch" })
end

local rockCache = {}
rockCache.times = {}
rockCache.touch = type(firetouchinterest) == "function" and firetouchinterest
    or type(firetouchtransmitter) == "function" and firetouchtransmitter or nil
rockCache.touchBegin = 0
local activeRock = nil
do
    local identify = identifyexecutor or getexecutorname
    if type(identify) == "function" then
        local ok, name = pcall(identify)
        if ok and tostring(name):lower():find("real", 1, true) then
            rockCache.touchBegin = 1
        end
    end
end


local function releaseRockContacts(controller)
    local contacts = type(controller) == "table" and controller.contacts or nil
    if type(controller) == "table" then controller.contacts = nil end
    if not contacts or not rockCache.touch then return end
    for _, contact in ipairs(contacts) do
        if contact[1] and contact[1].Parent and contact[2] and contact[2].Parent then
            pcall(rockCache.touch, contact[1], contact[2], 1 - rockCache.touchBegin)
        end
    end
end


local function clearActiveRock()
    activeRock = nil
end

local activeRockFarm = nil


local function stopActiveRockFarm()
    local previous = activeRockFarm
    activeRockFarm = nil
    if previous then
        previous.enabled = false
        if previous.thread then
            task.cancel(previous.thread)
            previous.thread = nil
        end
        releaseRockContacts(previous)
    end
    clearActiveRock()
end


local function clearRockSelection()
    State.rockGeneration = State.rockGeneration + 1
    State.selectedRock = nil
    State.rockSessionStartedAt = nil
    State.rockVisualReadyAt = math.huge
    stopActiveRockFarm()
end


local function findRock(definition)
    if type(definition) ~= "table" then return nil end
    local cacheKey = definition.durability
    local cached = rockCache[cacheKey]
    if cached and cached:IsDescendantOf(workspace) then
        return cached
    end
    if os.clock() - (rockCache.times[cacheKey] or -math.huge) < 1 then return nil end
    rockCache.times[cacheKey] = os.clock()
    rockCache[cacheKey] = nil
    local machinesFolder = workspace:FindFirstChild("machinesFolder")
    if not machinesFolder then return nil end
    for _, model in ipairs(machinesFolder:GetChildren()) do
        local marker = model:FindFirstChild("neededDurability")
        local rock = model:FindFirstChild("Rock")
        if marker and marker:IsA("ValueBase") and tonumber(marker.Value) == definition.durability
            and rock and rock:IsA("BasePart") then
            rockCache[cacheKey] = rock
            return rock
        end
    end
    return nil
end


local function rockFarmIsCurrent(controller)
    return controller and controller.enabled and activeRockFarm == controller
        and State.running and State.fastPunch and State.rockGeneration == controller.generation
        and State.selectedRock == controller.definition
end


local function runRockFarm(controller)
    while rockFarmIsCurrent(controller) do
        if State.fastPunchToolPaused then
            releaseRockContacts(controller)
            task.wait(0.04)
        else
        local ok = pcall(function()
            if not rockFarmIsCurrent(controller) then return end
            local definition = controller.definition
            local durability = LP:FindFirstChild("Durability")
            if durability and (tonumber(State.getFunctionalStatValue(durability)) or 0) < definition.durability then return end
            local character = getCharacter()
            local leftHand = character and (character:FindFirstChild("LeftHand") or character:FindFirstChild("Left Arm"))
            local rightHand = character and (character:FindFirstChild("RightHand") or character:FindFirstChild("Right Arm"))
            if not leftHand or not rightHand then return end
            local rock = findRock(definition)
            local punch = not State.fastPunchToolPaused and getPunch() or nil
            local muscleEvent = LP:FindFirstChild("muscleEvent")
            if not rock or not punch or not rockCache.touch or not muscleEvent
                or not muscleEvent:IsA("RemoteEvent") or not rockFarmIsCurrent(controller) then return end
            controller.lastRock = rock
            activeRock = rock
            pcall(muscleEvent.FireServer, muscleEvent, "punch", "leftHand")
            pcall(muscleEvent.FireServer, muscleEvent, "punch", "rightHand")
            pcall(punch.Activate, punch)
            State.playFastPunchVisual()
            task.wait(0.04)
            if not rockFarmIsCurrent(controller) or getCharacter() ~= character or not rock.Parent then return end
            controller.contacts = { { rightHand, rock }, { leftHand, rock } }
            for _, contact in ipairs(controller.contacts) do
                pcall(rockCache.touch, contact[1], contact[2], rockCache.touchBegin)
            end
            task.wait(0.04)
            releaseRockContacts(controller)
        end)
        if not ok then releaseRockContacts(controller) end
        task.wait(0.08)
        end
    end
    releaseRockContacts(controller)
end


local function startRockFarm(definition, previousStopped)
    if not previousStopped then
        clearRockSelection()
    end
    State.selectedRock = definition
    State.rockSessionStartedAt = realNow()
    State.rockVisualReadyAt = State.rockSessionStartedAt + 0.20
    local controller = {
        enabled = true,
        definition = definition,
        generation = State.rockGeneration,
        thread = nil,
        lastRock = nil,
    }
    activeRockFarm = controller
    controller.thread = task.spawn(runRockFarm, controller)
end

State.fastPunchVisual = { character = nil, tracks = {}, index = 0 }


State.clearFastPunchVisual = function()
    local visual = State.fastPunchVisual
    for _, track in ipairs(visual.tracks) do
        pcall(track.Stop, track, 0.05)
        pcall(track.Destroy, track)
    end
    visual.character = nil
    visual.tracks = {}
    visual.index = 0
end


State.playFastPunchVisual = function()
    local visual = State.fastPunchVisual
    local character = getCharacter()
    local humanoid = getHumanoid()
    local animator = humanoid and (humanoid:FindFirstChildOfClass("Animator") or humanoid:FindFirstChild("Animator"))
    if not character or not animator then return end
    if visual.character ~= character or #visual.tracks == 0 then
        State.clearFastPunchVisual()
        visual.character = character
        local shared = ReplicatedStorage:FindFirstChild("shared")
        local assets = shared and shared:FindFirstChild("assets")
        local animations = assets and assets:FindFirstChild("animations")
        local gameAnims = animations and animations:FindFirstChild("gameAnims")
        local tools = gameAnims and gameAnims:FindFirstChild("Tools")
        local punchAnimations = tools and tools:FindFirstChild("Punch")
        local attacks = punchAnimations and punchAnimations:FindFirstChild("attacks")
        if attacks then
            for _, animation in ipairs(attacks:GetChildren()) do
                if animation:IsA("Animation") then
                    local ok, track = pcall(animator.LoadAnimation, animator, animation)
                    if ok and track then
                        track.Priority = Enum.AnimationPriority.Action
                        visual.tracks[#visual.tracks + 1] = track
                    end
                end
        end
    end
    end
    if #visual.tracks == 0 then return end
    visual.index = visual.index % #visual.tracks + 1
    for index, track in ipairs(visual.tracks) do
        if index ~= visual.index and track.IsPlaying then
            pcall(track.Stop, track, 0.02)
        end
    end
    pcall(visual.tracks[visual.index].Play, visual.tracks[visual.index], 0.02, 1, 1.8)
end


local function setFastPunch(enabled)
    State.fastPunchGeneration = State.fastPunchGeneration + 1
    local generation = State.fastPunchGeneration
    State.fastPunch = enabled == true
    if not State.fastPunch then
        State.fastPunchToolPaused = false
        clearRockSelection()
        stopThread("fastPunchEquip")
        stopThread("fastPunchHit")
        State.clearFastPunchVisual()
        pcall(function()
            local character = getCharacter()
            local punch = character and character:FindFirstChild("Punch")
            local attackTime = punch and punch:FindFirstChild("attackTime")
            if attackTime then attackTime.Value = 0.3 end
            local backpack = LP:FindFirstChild("Backpack")
            if punch and backpack then punch.Parent = backpack end
        end)
        return
    end
    startThread("fastPunchEquip", function()
        while State.running and State.fastPunch and State.fastPunchGeneration == generation do
            pcall(function()
                local punch = not State.fastPunchToolPaused and getPunch() or nil
                local attackTime = punch and punch:FindFirstChild("attackTime")
                if attackTime then attackTime.Value = 0 end
            end)
            task.wait(0.05)
        end
    end)
    startThread("fastPunchHit", function()
        local lastVisual = 0
        while State.running and State.fastPunch and State.fastPunchGeneration == generation do
            if not activeRockFarm then
                local event = LP:FindFirstChild("muscleEvent")
                local punch = not State.fastPunchToolPaused and getPunch() or nil
                if event and event:IsA("RemoteEvent") then
                    pcall(event.FireServer, event, "punch", "rightHand")
                    pcall(event.FireServer, event, "punch", "leftHand")
                end
                if punch and time() - lastVisual >= 0.12 then
                    lastVisual = time()
                    pcall(punch.Activate, punch)
                    State.playFastPunchVisual()
                end
            end
            task.wait(0.01)
        end
    end)
end

local repTimeOriginals = {}

do
    local movement = State.exerciseMovement
    movement.toolKinds = {
        ["weight"] = "Weight",
        ["heavy weight"] = "Weight",
        ["handstand"] = "Handstands",
        ["handstands"] = "Handstands",
        ["pushup"] = "Pushups",
        ["pushups"] = "Pushups",
        ["situp"] = "Situps",
        ["situps"] = "Situps",
    }
    movement.animationIds = {}

    movement.idsFor = function(kind)
        local cached = movement.animationIds[kind]
        if cached then return cached end
        cached = {}
        local shared = ReplicatedStorage:FindFirstChild("shared")
        local assets = shared and shared:FindFirstChild("assets")
        local animations = assets and assets:FindFirstChild("animations")
        local gameAnims = animations and animations:FindFirstChild("gameAnims")
        local tools = gameAnims and gameAnims:FindFirstChild("Tools")
        local folder = tools and tools:FindFirstChild(kind)
        if folder then
            for _, animation in ipairs(folder:GetDescendants()) do
                if animation:IsA("Animation") and animation.AnimationId ~= "" then
                    cached[animation.AnimationId] = true
                end
            end
        end
        movement.animationIds[kind] = cached
        return cached
    end

    movement.stopTracks = function(humanoid, kind)
        local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
        if not animator or not kind then return end
        local ids = movement.idsFor(kind)
        for _, animationTrack in ipairs(animator:GetPlayingAnimationTracks()) do
            local animation = animationTrack.Animation
            if animation and ids[animation.AnimationId] then
                animationTrack:Stop(0.03)
            end
        end
    end

    movement.bindHumanoid = function(humanoid)
        if movement.boundHumanoid == humanoid then return end
        if movement.animationConnection then
            movement.animationConnection:Disconnect()
            movement.animationConnection = nil
        end
        movement.boundHumanoid = humanoid
        local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
        if animator then
            movement.animationConnection = animator.AnimationPlayed:Connect(function(animationTrack)
                local tool = movement.freeTool
                local kind = tool and tool.Parent and movement.toolKinds[tool.Name:lower()]
                local animation = animationTrack.Animation
                if kind and animation and movement.idsFor(kind)[animation.AnimationId] then
                    animationTrack:Stop(0.03)
                end
            end)
        end
    end

    movement.freedomStep = function()
        if not State.running then return end
        local character = getCharacter()
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local root = character and character:FindFirstChild("HumanoidRootPart")
        if not character or not humanoid or not root then
            movement.bindHumanoid(nil)
            movement.freeTool = nil
            movement.cameraDistance = nil
            return
        end
        movement.bindHumanoid(humanoid)
        local tool = character:FindFirstChildWhichIsA("Tool")
        local kind = tool and movement.toolKinds[tool.Name:lower()]
        if not kind then
            movement.freeTool = nil
            movement.cameraDistance = nil
            return
        end
        local camera = workspace.CurrentCamera
        if movement.freeTool ~= tool then
            movement.freeTool = tool
            movement.freeWalkSpeed = humanoid.WalkSpeed > 0 and humanoid.WalkSpeed or 16
            movement.cameraDistance = camera and (camera.CFrame.Position - root.Position).Magnitude or 14
            movement.stopTracks(humanoid, kind)
        end
        if not State.machine and not State.fly then
            root.Anchored = false
            humanoid.PlatformStand = false
            humanoid.Sit = false
            humanoid.AutoRotate = true
            if humanoid.WalkSpeed <= 0 then
                humanoid.WalkSpeed = movement.freeWalkSpeed or 16
            end
        end
        if camera and not State.spy and not State.miscFreecam then
            if camera.CameraSubject ~= humanoid or camera.CameraType == Enum.CameraType.Scriptable then
                camera.CameraSubject = humanoid
                camera.CameraType = Enum.CameraType.Custom
            end
            local distance = (camera.CFrame.Position - root.Position).Magnitude
            local expected = math.clamp(tonumber(movement.cameraDistance) or 14, 6, 80)
            if distance > math.max(220, expected * 6) then
                local backwards = Vector3.new(root.CFrame.LookVector.X, 0, root.CFrame.LookVector.Z)
                backwards = backwards.Magnitude > 0.01 and backwards.Unit or Vector3.new(0, 0, -1)
                local offset = math.clamp(expected, 10, 34)
                camera.CFrame = CFrame.lookAt(
                    root.Position - backwards * offset + Vector3.new(0, math.min(8, offset * 0.35), 0),
                    root.Position + Vector3.new(0, 2, 0)
                )
            elseif distance >= 5 and distance <= 120 then
                movement.cameraDistance = distance
            end
        end
    end
    local bindName = "DARKZS_ExerciseFreedom"
    pcall(RunService.UnbindFromRenderStep, RunService, bindName)
    RunService:BindToRenderStep(bindName, Enum.RenderPriority.Camera.Value - 1, movement.freedomStep)
    addCleanup(function()
        pcall(RunService.UnbindFromRenderStep, RunService, bindName)
        movement.bindHumanoid(nil)
    end)
end


local function setFastRepTime(key, tool)
    if not tool then
        return
    end
    local repTime = tool:FindFirstChild("repTime")
    if not repTime or not repTime:IsA("ValueBase") then
        return
    end
    repTimeOriginals[key] = repTimeOriginals[key] or setmetatable({}, { __mode = "k" })
    if repTimeOriginals[key][repTime] == nil then
        repTimeOriginals[key][repTime] = repTime.Value
    end
    repTime.Value = 0
end


local function restoreRepTime(key)
    local saved = repTimeOriginals[key]
    if not saved then
        return
    end
    for repTime, original in pairs(saved) do
        if repTime and repTime.Parent then
            pcall(function()
                repTime.Value = original
            end)
        end
    end
    repTimeOriginals[key] = nil
end


local function unequipRepTools(tools)
    local character = getCharacter()
    local backpack = LP:FindFirstChild("Backpack")
    if not character or not backpack or not tools then
        return
    end
    local wanted = {}
    for _, name in ipairs(tools) do
        wanted[name:lower()] = true
    end
    for _, tool in ipairs(character:GetChildren()) do
        if tool:IsA("Tool") and wanted[tool.Name:lower()] then
            pcall(function()
                tool.Parent = backpack
            end)
        end
    end
end


local function setAutoRep(key, enabled, tools, interval, forceFast)
    State[key] = enabled == true
    local movement = State.exerciseMovement
    movement.active[key] = State[key] or nil
    local threadKey = "rep_" .. key
    if not State[key] then
        stopThread(threadKey)
        restoreRepTime(key)
        unequipRepTools(tools)
        local hasActiveExercise = false
        for _ in pairs(movement.active) do
            hasActiveExercise = true
            break
        end
        if not hasActiveExercise then
            stopThread("exerciseMovement")
            local humanoid = movement.humanoid
            if humanoid and humanoid.Parent then
                pcall(function()
                    if not State.fastSpeed and movement.walkSpeed then
                        humanoid.WalkSpeed = movement.walkSpeed
                    end
                    if movement.jumpValue then
                        if movement.usesJumpPower then
                            humanoid.JumpPower = movement.jumpValue
                        else
                            humanoid.JumpHeight = movement.jumpValue
                        end
                    end
                end)
            end
            movement.humanoid = nil
            movement.walkSpeed = nil
            movement.jumpValue = nil
        end
        return
    end
    local humanoid = getHumanoid()
    if humanoid and movement.humanoid ~= humanoid then
        movement.humanoid = humanoid
        movement.walkSpeed = humanoid.WalkSpeed > 0 and humanoid.WalkSpeed or 16
        movement.usesJumpPower = humanoid.UseJumpPower
        movement.jumpValue = movement.usesJumpPower and humanoid.JumpPower or humanoid.JumpHeight
    end
    startThread("exerciseMovement", function()
        while State.running and next(movement.active) do
            local activeHumanoid = getHumanoid()
            local root = getRoot()
            if activeHumanoid then
                if movement.humanoid ~= activeHumanoid then
                    movement.humanoid = activeHumanoid
                    movement.walkSpeed = activeHumanoid.WalkSpeed > 0 and activeHumanoid.WalkSpeed or 16
                    movement.usesJumpPower = activeHumanoid.UseJumpPower
                    movement.jumpValue = movement.usesJumpPower and activeHumanoid.JumpPower or activeHumanoid.JumpHeight
                end
                if not State.machine and not State.fly then
                    if root then
                        root.Anchored = false
                    end
                    activeHumanoid.PlatformStand = false
                    activeHumanoid.Sit = false
                    local wantedSpeed = State.fastSpeed and 1000 or movement.walkSpeed
                    if wantedSpeed and activeHumanoid.WalkSpeed < wantedSpeed then
                        activeHumanoid.WalkSpeed = wantedSpeed
                    end
                    if movement.jumpValue then
                        if movement.usesJumpPower and activeHumanoid.JumpPower < movement.jumpValue then
                            activeHumanoid.JumpPower = movement.jumpValue
                        elseif not movement.usesJumpPower and activeHumanoid.JumpHeight < movement.jumpValue then
                            activeHumanoid.JumpHeight = movement.jumpValue
                        end
                    end
                end
            end
            RunService.Heartbeat:Wait()
        end
    end)
    startThread(threadKey, function()
        while State.running and State[key] do
            local repDelay = interval or 0.01
            pcall(function()
                local tool
                if tools and #tools > 0 then
                    tool = equipTool(tools)
                    if forceFast or State.autoFarmMode == "Fast Rep" then
                        setFastRepTime(key, tool)
                    else
                        restoreRepTime(key)
                        local repTime = tool and tool:FindFirstChild("repTime", true)
                        repDelay = math.max(0.15, tonumber(repTime and repTime.Value) or 1)
                        local owned = LP:FindFirstChild("ownedGamepasses")
                        if owned and owned:FindFirstChild("x2 Rep Time") then
                            repDelay = repDelay * 0.5
                        end
                    end
                end
                local event = LP:FindFirstChild("muscleEvent")
                if event then
                    event:FireServer("rep")
                end
            end)
            task.wait(repDelay)
        end
    end)
end


local function findProteinEgg()
    for _, container in ipairs({
        getCharacter(),
        LP:FindFirstChild("Backpack"),
    }) do
        if container then
            for _, egg in ipairs(container:GetChildren()) do
                if egg:IsA("Tool") and table.find(CONFIG.AutoEgg.Names, egg.Name)
                    and egg:GetAttribute("Used") ~= true then
                    return egg
                end
            end
        end
    end
    return nil
end


local function hasProteinEggBoost()
    local boostTimers = LP:FindFirstChild("boostTimersFolder")
    if not boostTimers then
        return false
    end
    for _, name in ipairs(CONFIG.AutoEgg.Names) do
        local timer = boostTimers:FindFirstChild(name)
        if timer and timer:IsA("ValueBase") and tonumber(timer.Value) and timer.Value > 0 then
            return true
        end
    end
    return false
end


local function hubNotify(text, duration)
    pcall(function()
        local message = tostring(text or "")
        if type(State.translateText) == "function" then message = State.translateText(message) end
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "DARKZS HUB",
            Text = message,
            Duration = tonumber(duration) or 4,
        })
    end)
end


local function countProteinEggs()
    local total = 0
    for _, container in ipairs({
        getCharacter(),
        LP:FindFirstChild("Backpack"),
        LP:FindFirstChild("consumablesFolder"),
    }) do
        if container then
            for _, egg in ipairs(container:GetChildren()) do
                if (egg:IsA("Tool") or egg:IsA("StringValue"))
                    and table.find(CONFIG.AutoEgg.Names, egg.Name) then
                    total = total + 1
                end
            end
        end
    end
    return total
end

State.eggBusy = false

State.eatProteinEgg = function(force)
    if not force and hasProteinEggBoost() then
        return true
    end
    if State.eggBusy then
        return false
    end

    local egg = findProteinEgg()
    local character = getCharacter()
    local muscleEvent = LP:FindFirstChild("muscleEvent")
    if not egg or not character or not muscleEvent or not muscleEvent:IsA("RemoteEvent") then
        return false
    end

    State.eggBusy = true
    local ok, consumed = pcall(function()
        local originalParent = egg.Parent
        local originalUsed = egg:GetAttribute("Used")
        local beforeCount = countProteinEggs()
        local hadBoost = hasProteinEggBoost()

        local function confirmed()
            return not egg.Parent or countProteinEggs() < beforeCount
                or (not hadBoost and hasProteinEggBoost())
        end

        if egg.Parent ~= character then
            egg.Parent = character
            task.wait(0.2)
        end

        if confirmed() then
            return true
        end

        egg:SetAttribute("Used", true)
        muscleEvent:FireServer("proteinEgg", egg)
        local deadline = time() + 3
        while time() < deadline do
            if confirmed() then
                return true
            end
            task.wait(0.1)
        end

        if egg.Parent then egg:SetAttribute("Used", originalUsed) end
        if egg.Parent == character and originalParent and originalParent.Parent then
            egg.Parent = originalParent
        end
        return false
    end)
    State.eggBusy = false
    return ok and consumed == true
end

do

local function parseBoostTime(text)
    text = tostring(text or "")
    local hours = tonumber(text:match("(%d+)%s*[hH]")) or 0
    local minutes = tonumber(text:match("(%d+)%s*[mM]")) or 0
    local seconds = tonumber(text:match("(%d+)%s*[sS]")) or 0
    local total = hours * 3600 + minutes * 60 + seconds
    return total > 0 and total or nil
end


local function visibleStrengthBoostRemaining()
    local boostTimers = LP:FindFirstChild("boostTimersFolder")
    if boostTimers then
        for _, name in ipairs(CONFIG.AutoEgg.Names) do
            local timer = boostTimers:FindFirstChild(name)
            local remaining = timer and tonumber(timer.Value)
            if remaining and remaining > 0 then
                return remaining
            end
        end
    end
    return 0
end

State.autoEggSources = { manual = false, fastFarm = false, rebirth = false }
State.autoEggNextAt = 0
State.autoEggImmediateRequested = false

State.setAutoEgg = function(enabled, source)
    source = source or "manual"
    local wasEnabled = State.autoEggSources[source] == true
    State.autoEggSources[source] = enabled == true
    if enabled == true and not wasEnabled then
        State.autoEggImmediateRequested = true
    end
    local desired = false
    for _, active in pairs(State.autoEggSources) do
        if active then
            desired = true
            break
        end
    end
    if State.autoEgg == desired then
        return
    end
    State.autoEgg = desired
    if not desired then
        State.autoEggImmediateRequested = false
        stopThread("autoEgg")
        return
    end
    startThread("autoEgg", function()
        while State.running and State.autoEgg do
            local now = time()
            if State.autoEggImmediateRequested then
                State.autoEggImmediateRequested = false
                if State.eatProteinEgg(false) then
                    State.autoEggNextAt = now + CONFIG.AutoEgg.Interval
                else
                    State.autoEggNextAt = now + 10
                end
            else
                local remaining = visibleStrengthBoostRemaining()
                if remaining > 0 then
                    State.autoEggNextAt = math.max(State.autoEggNextAt, now + remaining)
                end
                if now >= State.autoEggNextAt then
                    if State.eatProteinEgg(false) then
                        State.autoEggNextAt = now + CONFIG.AutoEgg.Interval
                    else
                        State.autoEggNextAt = now + 10
                    end
                end
            end
            task.wait(1)
        end
    end)
end
end


local function findNativeAutoLiftButton()
    local gameGui = PlayerGui:FindFirstChild("gameGui")
    local modernHud = gameGui and gameGui:FindFirstChild("hudNewMenu")
    local modernTop = modernHud and modernHud:FindFirstChild("Top")
    local modernButton = modernTop and modernTop:FindFirstChild("AutoLiftBtn")
    if modernButton and modernButton:IsA("GuiButton") then
        return modernButton
    end
    local frame = PlayerGui:FindFirstChild("autoLiftFrame", true)
    local button = frame and frame:FindFirstChild("autoLiftButton", true)
    if button and button:IsA("GuiButton") then
        return button
    end
    return nil
end


local function releaseNativeAutoLiftButton()
    local native = State.autoLiftNative
    if native.connection then
        pcall(function()
            native.connection:Disconnect()
        end)
        native.connection = nil
    end
    if native.visualConnection then
        pcall(function() native.visualConnection:Disconnect() end)
        native.visualConnection = nil
    end
    for _, connection in ipairs(native.disabledConnections) do
        pcall(function()
            connection:Enable()
        end)
    end
    table.clear(native.disabledConnections)
    if native.fallbackMarker then
        pcall(function()
            native.fallbackMarker:Destroy()
        end)
        native.fallbackMarker = nil
    end
    if State.autoLiftEditableImage then
        pcall(function() State.autoLiftEditableImage:Destroy() end)
        State.autoLiftEditableImage = nil
    end
end
