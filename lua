-- ============================================================
-- Penablox HvH — Executor Detection
-- ============================================================
local function detectExecutor()
    local name = nil
    if type(identifyexecutor) == "function" then
        local ok, res = pcall(identifyexecutor)
        if ok and type(res) == "string" then name = res end
    end
    if not name and type(getexecutorname) == "function" then
        local ok, res = pcall(getexecutorname)
        if ok and type(res) == "string" then name = res end
    end
    if name then
        local lower = name:lower()
        if lower:find("xeno", 1, true)      then return "Xeno", name end
        if lower:find("solara", 1, true)    then return "Solara", name end
        if lower:find("real", 1, true)      then return "Real", name end
        if lower:find("wave", 1, true)      then return "Wave", name end
        if lower:find("jjsploit", 1, true)  then return "JJSploit", name end
        if lower:find("delta", 1, true)     then return "Delta", name end
        if lower:find("potassium", 1, true) then return "Potassium", name end
        return "Unknow", name
    end
    return "Unknow", "Unknown"
end

local COMPATIBILITY = {
    ["Real"]=100,["Xeno"]=60,["Solara"]=65,["Wave"]=99,
    ["JJSploit"]=55,["Delta"]=100,["Potassium"]=99,
    ["Unknow"]=55,["Not supported"]=0,
}

local function showDetectionUI()
    local parent = (type(gethui) == "function" and gethui()) or game:GetService("CoreGui")
    local gui = Instance.new("ScreenGui")
    gui.Name = "Penablox_Detection"; gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true; gui.DisplayOrder = 999; gui.Parent = parent
    local frame = Instance.new("Frame")
    frame.AnchorPoint = Vector2.new(0.5,0); frame.Position = UDim2.new(0.5,0,0,20)
    frame.Size = UDim2.new(0,440,0,95); frame.BackgroundColor3 = Color3.fromRGB(15,15,22)
    frame.BackgroundTransparency = 0.08; frame.BorderSizePixel = 0; frame.Parent = gui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,10)
    local stroke = Instance.new("UIStroke", frame)
    stroke.Color = Color3.fromRGB(80,130,255); stroke.Thickness = 2; stroke.Transparency = 0.1
    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1,0,0,28); title.Position = UDim2.new(0,0,0,6)
    title.BackgroundTransparency = 1; title.Text = "PENABLOX HVH — DETECTION"
    title.TextColor3 = Color3.fromRGB(150,180,255); title.Font = Enum.Font.GothamBold; title.TextSize = 15
    local mainLabel = Instance.new("TextLabel", frame)
    mainLabel.Name = "Main"; mainLabel.Size = UDim2.new(1,0,0,26); mainLabel.Position = UDim2.new(0,0,0,34)
    mainLabel.BackgroundTransparency = 1; mainLabel.Text = "Detecting executor..."
    mainLabel.TextColor3 = Color3.fromRGB(255,255,255); mainLabel.Font = Enum.Font.GothamMedium; mainLabel.TextSize = 15
    local subLabel = Instance.new("TextLabel", frame)
    subLabel.Name = "Sub"; subLabel.Size = UDim2.new(1,0,0,22); subLabel.Position = UDim2.new(0,0,0,62)
    subLabel.BackgroundTransparency = 1; subLabel.Text = ""
    subLabel.TextColor3 = Color3.fromRGB(150,150,160); subLabel.Font = Enum.Font.Gotham; subLabel.TextSize = 13
    return gui, mainLabel, subLabel
end

local detected, rawName = detectExecutor()
local compat = COMPATIBILITY[detected] or 0
local detGui, mainLabel, subLabel = showDetectionUI()
mainLabel.Text = "Executor: " .. detected
if rawName and rawName ~= detected and rawName ~= "Unknown" then
    subLabel.Text = "(raw: " .. rawName .. ")"
end
task.wait(7.5)
mainLabel.Text = "Compatibility: " .. compat .. "%"
if compat == 100 then mainLabel.TextColor3 = Color3.fromRGB(80,255,130); subLabel.Text = "Full support"
elseif compat >= 90 then mainLabel.TextColor3 = Color3.fromRGB(80,255,130); subLabel.Text = "Great work"
elseif compat >= 70 then mainLabel.TextColor3 = Color3.fromRGB(255,220,80); subLabel.Text = "Bad work"
elseif compat >= 50 then mainLabel.TextColor3 = Color3.fromRGB(255,160,80); subLabel.Text = "Super bad work"
else mainLabel.TextColor3 = Color3.fromRGB(255,80,80); subLabel.Text = "Not supported" end
task.wait(3); detGui:Destroy()
if compat == 0 then warn("[Penablox] Unsupported."); return end
warn("[Penablox] Detected: " .. detected .. " (" .. compat .. "%)")

-- ============================================================
-- MAIN
-- ============================================================
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local UserInputService  = game:GetService("UserInputService")
local RunService        = game:GetService("RunService")
local Players           = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedFirst   = game:GetService("ReplicatedFirst")

local LocalPlayer = Players.LocalPlayer
local Character   = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid    = Character:WaitForChild("Humanoid")
local RootPart    = Character:WaitForChild("HumanoidRootPart")

LocalPlayer.CharacterAdded:Connect(function(newChar)
    Character = newChar
    Humanoid  = newChar:WaitForChild("Humanoid")
    RootPart  = newChar:WaitForChild("HumanoidRootPart")
end)

getgenv().Penablox = getgenv().Penablox or {}
local G = getgenv().Penablox

G.Config = {
    BhopEnabled = true, BhopSpeed = 32, NoSpreadEnabled = false, DisableAC = true,
    DefPeekEnabled = false, DefPeekKey = Enum.KeyCode.Q, DefPeekRestoreVel = true,
    DefPeekDebug = true, DefPeekFreezeTime = 0.5,
    AntiMapKickEnabled = true, AntiMapKickOffset = 200,
    ResolverEnabled = false, ResolverLerp = false, ResolverLerpSpeed = 0.35,
    ResolverBiasAngle = 25, ResolverDisableIG = false, ResolverVelocity = true,
    ResolverLBYBreak = true, ResolverFlipPredict = true, ResolverConfidence = 0.3,
    ResolverBruteCount = 12, ResolverPerEnemy = false,
}
G.savedPeekCFrame = nil; G.pendingTeleport = false; G.lastTeleport = 0
G.freezeUntil = 0; G.cachedSpawn = nil; G.mapKickGraceEnd = 0
G.Hooks = G.Hooks or { resolvedYaw = {}, feedback = nil }

local Config = G.Config
local Hooks = G.Hooks

-- ============================================================
-- UI
-- ============================================================
local Window = Rayfield:CreateWindow({
    Name = "Magic | Penablox",
    LoadingTitle = "Penablox Lua",
    LoadingSubtitle = "by ExE",
    ConfigurationSaving = { Enabled = false },
    KeySystem = false,
    ToggleKey = Enum.KeyCode.RightControl,
})

local CombatTab = Window:CreateTab("Combat")
CombatTab:CreateSection("Weapon Modifications")
CombatTab:CreateToggle({ Name = "No Spread", CurrentValue = Config.NoSpreadEnabled, Flag = "NoSpreadToggle",
    Callback = function(v) Config.NoSpreadEnabled = v end })
CombatTab:CreateSection("Defensive Peek")
CombatTab:CreateToggle({ Name = "Defensive Peek (hold Q)", CurrentValue = Config.DefPeekEnabled, Flag = "DefPeekToggle",
    Callback = function(v) Config.DefPeekEnabled = v; if v then warn("[DefPeek] ON") else G.savedPeekCFrame = nil; warn("[DefPeek] OFF") end end })
CombatTab:CreateToggle({ Name = "DefPeek: reset velocity", CurrentValue = Config.DefPeekRestoreVel, Flag = "DefPeekVelToggle",
    Callback = function(v) Config.DefPeekRestoreVel = v end })
CombatTab:CreateSlider({ Name = "Freeze after peek (sec)", Range = {0,20}, Increment = 1, Suffix = " x0.1s",
    CurrentValue = 5, Flag = "DefPeekFreezeSlider",
    Callback = function(v) Config.DefPeekFreezeTime = tonumber(v) / 10 end })
CombatTab:CreateToggle({ Name = "Debug", CurrentValue = Config.DefPeekDebug, Flag = "DefPeekDebugToggle",
    Callback = function(v) Config.DefPeekDebug = v end })

-- ============================================================
-- RESOLVER TAB
-- ============================================================
local ResolverTab = Window:CreateTab("Resolver")
ResolverTab:CreateSection("Main")
ResolverTab:CreateToggle({ Name = "Custom Resolver", CurrentValue = Config.ResolverEnabled, Flag = "ResolverToggle",
    Callback = function(v) Config.ResolverEnabled = v; G.CustomResolverEnabled = v; warn("[Resolver]", v and "ON" or "OFF") end })
ResolverTab:CreateToggle({ Name = "Disable In-Game Resolver", CurrentValue = Config.ResolverDisableIG, Flag = "DisableInGameResolverToggle",
    Callback = function(v) Config.ResolverDisableIG = v
        local rv = LocalPlayer:FindFirstChild("ResolverEnabled")
        if rv then rv.Value = not v end end })
ResolverTab:CreateSection("Detection Modes")
ResolverTab:CreateToggle({ Name = "Velocity Desync Detect", CurrentValue = Config.ResolverVelocity, Flag = "ResolverVelocityToggle",
    Callback = function(v) Config.ResolverVelocity = v end })
ResolverTab:CreateToggle({ Name = "LBY Break Detect", CurrentValue = Config.ResolverLBYBreak, Flag = "ResolverLBYToggle",
    Callback = function(v) Config.ResolverLBYBreak = v end })
ResolverTab:CreateToggle({ Name = "Flip Phase Predict", CurrentValue = Config.ResolverFlipPredict, Flag = "ResolverFlipToggle",
    Callback = function(v) Config.ResolverFlipPredict = v end })
ResolverTab:CreateSection("Tuning")
ResolverTab:CreateSlider({ Name = "Confidence Threshold", Range = {0,100}, Increment = 5, Suffix = " %", CurrentValue = 30, Flag = "ResolverConfidenceSlider",
    Callback = function(v) Config.ResolverConfidence = tonumber(v) / 100 end })
ResolverTab:CreateSlider({ Name = "Brute Offset Count", Range = {4,12}, Increment = 1, Suffix = " offsets", CurrentValue = 12, Flag = "ResolverBruteSlider",
    Callback = function(v) Config.ResolverBruteCount = tonumber(v) end })
ResolverTab:CreateToggle({ Name = "Per-Enemy Mode", CurrentValue = Config.ResolverPerEnemy, Flag = "ResolverPerEnemyToggle",
    Callback = function(v) Config.ResolverPerEnemy = v end })
ResolverTab:CreateSection("Smoothing")
ResolverTab:CreateToggle({ Name = "Divine LERP", CurrentValue = Config.ResolverLerp, Flag = "ResolverLerpToggle",
    Callback = function(v) Config.ResolverLerp = v; G.DivineLuaLERPEnabled = v end })
ResolverTab:CreateSlider({ Name = "LERP Speed", Range = {0,100}, Increment = 5, Suffix = " %", CurrentValue = 35, Flag = "ResolverLerpSpeedSlider",
    Callback = function(v) Config.ResolverLerpSpeed = tonumber(v) / 100; G.DivineLuaLERPSpeed = Config.ResolverLerpSpeed end })
ResolverTab:CreateSlider({ Name = "Bias Angle", Range = {0,90}, Increment = 1, Suffix = " °", CurrentValue = 25, Flag = "ResolverBiasSlider",
    Callback = function(v) Config.ResolverBiasAngle = tonumber(v); G.DivineLuaBIASAngle = math.rad(Config.ResolverBiasAngle) end })

-- ============================================================
-- MISC TAB
-- ============================================================
local MiscTab = Window:CreateTab("Misc")
MiscTab:CreateSection("Movement Modifications")
MiscTab:CreateToggle({ Name = "Sub-Tick AutoBhop", CurrentValue = Config.BhopEnabled, Flag = "BhopToggle",
    Callback = function(v) Config.BhopEnabled = v end })
MiscTab:CreateSlider({ Name = "Bhop Target Speed", Range = {32,100}, Increment = 1, Suffix = " studs/s", CurrentValue = Config.BhopSpeed, Flag = "BhopSpeedSlider",
    Callback = function(v) Config.BhopSpeed = tonumber(v) end })
MiscTab:CreateSection("Anti Map Kick")
MiscTab:CreateToggle({ Name = "Anti Map Kick (auto-respawn)", CurrentValue = Config.AntiMapKickEnabled, Flag = "AntiMapKickToggle",
    Callback = function(v) Config.AntiMapKickEnabled = v; warn("[AntiMapKick]", v and "ON" or "OFF") end })
MiscTab:CreateSlider({ Name = "Detection Offset (above kill Y)", Range = {50,400}, Increment = 10, Suffix = " studs", CurrentValue = Config.AntiMapKickOffset, Flag = "AntiMapKickOffsetSlider",
    Callback = function(v) Config.AntiMapKickOffset = tonumber(v) end })
MiscTab:CreateSection("Anti-AntiCheat")
MiscTab:CreateToggle({ Name = "Disable Client AC", CurrentValue = Config.DisableAC, Flag = "DisableACToggle",
    Callback = function(v) Config.DisableAC = v end })

-- ============================================================
-- HELPERS
-- ============================================================
local function _getgc()
    if type(getgc) ~= "function" then return {} end
    local ok, res = pcall(function() return getgc(true) end)
    if ok and type(res) == "table" and #res > 0 then return res end
    ok, res = pcall(function() return getgc() end)
    if ok and type(res) == "table" then return res end
    return {}
end
local function dbg(...) if Config.DefPeekDebug then warn("[DefPeek]", ...) end end
local function isFrozen() return tick() < G.freezeUntil end

-- AC/SPREAD
local function isMainAC(t)
    if type(t) ~= "table" then return false end
    return rawget(t,"CFrameMonitor") ~= nil and rawget(t,"WalkspeedProtect") ~= nil and rawget(t,"HitboxProtect") ~= nil
end
local function isRangeAC(t)
    if type(t) ~= "table" then return false end
    return rawget(t,"RADIUS") ~= nil and rawget(t,"RADIUS_KICK") ~= nil and rawget(t,"POS_KICK") ~= nil
end
local function isSpreadConfig(t)
    if type(t) ~= "table" then return false end
    return rawget(t,"BaseSpread") ~= nil and rawget(t,"MoveSpread") ~= nil
        and rawget(t,"MaxSpread") ~= nil and rawget(t,"MinSpread") ~= nil and rawget(t,"VelocityInfluence") ~= nil
end

local AC_main_cache, AC_range_cache, Spread_cache = {}, {}, {}
local lastScanTime, SCAN_INTERVAL = 0, 15

local function scanGc()
    AC_main_cache, AC_range_cache, Spread_cache = {}, {}, {}
    for _, obj in ipairs(_getgc()) do
        if type(obj) == "table" then
            if isMainAC(obj) then table.insert(AC_main_cache, obj)
            elseif isRangeAC(obj) then table.insert(AC_range_cache, obj)
            elseif isSpreadConfig(obj) then table.insert(Spread_cache, obj) end
        end
    end
    lastScanTime = tick()
end
local function ensureScan() if tick() - lastScanTime > SCAN_INTERVAL then scanGc() end end

local function neutralizeMainAC(cfg)
    if cfg.CFrameMonitor then cfg.CFrameMonitor.enabled = false; cfg.CFrameMonitor.speedThreshold = 999999; cfg.CFrameMonitor.requiredSeconds = 999999 end
    if cfg.WalkspeedProtect then cfg.WalkspeedProtect.enabled = false; cfg.WalkspeedProtect.maxWalkSpeed = 999999 end
    for _, k in ipairs({"HipHeightProtect","PlatformStandProtect","FlyProtect","GravityProtect","NoClipProtect","TeleportDetect","HitboxProtect","PartRemoveProtect","PartRenameProtect"}) do
        if cfg[k] then cfg[k].enabled = false end
    end
end
local function neutralizeRangeAC(cfg)
    cfg.RADIUS=999999; cfg.DT_RADIUS=999999; cfg.DT_SPAM_RADIUS=999999
    if cfg.RADIUS_KICK then cfg.RADIUS_KICK.TIME=999999; cfg.RADIUS_KICK.DISTANCE=999999 end
    if cfg.POS_KICK then cfg.POS_KICK.TIME=999999 end
end
local function zeroSpread(cfg)
    cfg.BaseSpread=0; cfg.MoveSpread=0; cfg.MaxJumpSpread=0
    cfg.MinSpread=0; cfg.MaxSpread=0; cfg.VelocityInfluence=0
    cfg.HorizontalInfluence=0; cfg.CrouchMultiplier=0
end
local function applyCachedAC()
    for _, o in ipairs(AC_main_cache) do pcall(function() neutralizeMainAC(o) end) end
    for _, o in ipairs(AC_range_cache) do pcall(function() neutralizeRangeAC(o) end) end
end
local function applyCachedSpread()
    if not Config.NoSpreadEnabled then return end
    for _, o in ipairs(Spread_cache) do pcall(function() zeroSpread(o) end) end
end
scanGc()

-- DEFENSIVE PEEK
local function getHRP()
    local c = LocalPlayer.Character
    return c and c:FindFirstChild("HumanoidRootPart") or nil
end

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode ~= Config.DefPeekKey then return end
    if not Config.DefPeekEnabled then return end
    local hrp = getHRP()
    if hrp then G.savedPeekCFrame = hrp.CFrame; dbg("Q saved") end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode ~= Config.DefPeekKey then return end
    if G.savedPeekCFrame then G.savedPeekCFrame = nil; dbg("Q reset") end
end)
LocalPlayer.CharacterAdded:Connect(function()
    G.savedPeekCFrame=nil; G.pendingTeleport=false; G.freezeUntil=0; G.mapKickGraceEnd=tick()+2
end)

RunService.PreSimulation:Connect(function()
    if not G.pendingTeleport then return end
    G.pendingTeleport=false
    if not Config.DefPeekEnabled or not G.savedPeekCFrame then return end
    local now = tick()
    if now - G.lastTeleport < 0.05 then return end
    G.lastTeleport = now
    pcall(function()
        local hrp = getHRP()
        if hrp and hrp.Parent then
            hrp.CFrame = G.savedPeekCFrame
            if Config.DefPeekRestoreVel then
                hrp.AssemblyLinearVelocity = Vector3.zero
                hrp.AssemblyAngularVelocity = Vector3.zero
            end
            G.freezeUntil = Config.DefPeekFreezeTime > 0 and (tick() + Config.DefPeekFreezeTime) or 0
        end
    end)
end)
RunService.PreSimulation:Connect(function()
    if not isFrozen() then return end
    if not G.savedPeekCFrame then return end
    local hrp = getHRP()
    if not hrp or not hrp.Parent then return end
    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.AssemblyAngularVelocity = Vector3.zero
end)

-- SHOT DETECTOR
local function watchTool(tool)
    if not tool or not tool:IsA("Tool") then return end
    if tool.Name ~= "SSG-08" then return end
    tool.ChildAdded:Connect(function(child)
        if child.Name == "Shoot" and child:IsA("Configuration") then
            if Config.DefPeekEnabled and G.savedPeekCFrame then G.pendingTeleport = true end
        end
    end)
end
local function watchCharacter(char)
    if not char then return end
    local e = char:FindFirstChild("SSG-08")
    if e then watchTool(e) end
    char.ChildAdded:Connect(function(c) if c:IsA("Tool") then watchTool(c) end end)
end
if LocalPlayer.Character then watchCharacter(LocalPlayer.Character) end
LocalPlayer.CharacterAdded:Connect(watchCharacter)

-- ============================================================
-- RESOLVER V2
-- ============================================================
do
    local STACK, CLASSIFY_MIN, FLUSH_TIME = 16, 6, 3
    local yawBuf, velBuf, velDirBuf = {}, {}, {}
    local resolvedYaw = Hooks.resolvedYaw
    local lockedYaw, missCounter, lastMissed, confidence, modeCache = {}, {}, {}, {}, {}
    local lastFlush = os.clock()
    Hooks.feedback = nil

    local function norm(a) return math.atan2(math.sin(a), math.cos(a)) end
    local function diff(a, b) return math.abs(norm(a - b)) end
    local function lerpAngle(a, b, t) return a + norm(b - a) * t end

    local BRUTE_OFFSETS = {
        0, math.pi, math.rad(137), -math.rad(137),
        math.rad(157), -math.rad(157), math.rad(67), -math.rad(67),
        math.rad(90), -math.rad(90), math.rad(45), -math.rad(45),
    }

    local function flushAll()
        for k in pairs(yawBuf) do yawBuf[k]=nil end
        for k in pairs(velBuf) do velBuf[k]=nil end
        for k in pairs(velDirBuf) do velDirBuf[k]=nil end
        for k in pairs(resolvedYaw) do resolvedYaw[k]=nil end
        for k in pairs(lockedYaw) do lockedYaw[k]=nil end
        for k in pairs(confidence) do confidence[k]=nil end
        for k in pairs(modeCache) do modeCache[k]=nil end
        lastFlush = os.clock()
    end

    local function getHRPYaw(hrp) local l=hrp.CFrame.LookVector; return math.atan2(l.X, l.Z) end
    local function getHeadYaw(h) local l=h.CFrame.LookVector; return math.atan2(l.X, l.Z) end
    local function getVelYaw(hrp)
        local v = hrp.AssemblyLinearVelocity
        if v.Magnitude < 0.5 then return nil end
        local f = Vector3.new(v.X, 0, v.Z); return math.atan2(f.X, f.Z)
    end
    local function pushRing(buf, val)
        buf.values[buf.head] = val
        buf.head = (buf.head % STACK) + 1
        if buf.count < STACK then buf.count = buf.count + 1 end
    end
    local function getOrdered(buf)
        local v,h,n2 = buf.values, buf.head, buf.count
        local out = {}
        if n2 < STACK then for i=1,n2 do out[i]=v[i] end
        else
            local base = h - 1
            for i=0,n2-1 do out[i+1]=v[(base+i)%STACK+1] end
        end
        return out
    end
    local function getLatest(buf)
        if buf.count == 0 then return nil end
        if buf.count < STACK then return buf.values[buf.count] end
        return buf.values[((buf.head - 2) % STACK) + 1]
    end
    local function ensureBuf(tbl, plr)
        if not tbl[plr] then tbl[plr] = { values={}, head=1, count=0 } end
        return tbl[plr]
    end
    local function getClosest()
        local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not myRoot then return nil end
        local best, bestDist = nil, math.huge
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                local hum = plr.Character:FindFirstChildOfClass("Humanoid")
                if hrp and hum and hum.Health > 0 then
                    local d = (hrp.Position - myRoot.Position).Magnitude
                    if d < bestDist then best = plr; bestDist = d end
                end
            end
        end
        return best
    end
    local function pushSample(plr)
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        pushRing(ensureBuf(yawBuf, plr), getHRPYaw(hrp))
        local vy = getVelYaw(hrp)
        if vy then pushRing(ensureBuf(velDirBuf, plr), vy) end
        pushRing(ensureBuf(velBuf, plr), hrp.AssemblyLinearVelocity.Magnitude)
    end

    local function classifyAA(plr)
        local buf = yawBuf[plr]
        if not buf or buf.count < CLASSIFY_MIN then return "UNKNOWN" end
        local pile = getOrdered(buf)
        local totalDelta, flips = 0, 0
        for i=2,#pile do
            local d = diff(pile[i], pile[i-1]); totalDelta = totalDelta + d
            if math.sign(math.sin(pile[i])) ~= math.sign(math.sin(pile[i-1])) then flips = flips + 1 end
        end
        local avg = totalDelta / (#pile - 1)
        local vbuf = velBuf[plr]; local avgSpeed = 0
        if vbuf and vbuf.count > 0 then
            local vp = getOrdered(vbuf); local sum=0
            for _, s in ipairs(vp) do sum = sum + s end
            avgSpeed = sum / #vp
        end
        local headYaw, hrpYaw
        local char = plr.Character
        if char then
            local head = char:FindFirstChild("Head")
            local hrp  = char:FindFirstChild("HumanoidRootPart")
            if head and hrp then headYaw = getHeadYaw(head); hrpYaw = getHRPYaw(hrp) end
        end
        if avg < math.rad(3) and flips < 2 then
            if Config.ResolverLBYBreak and headYaw and hrpYaw and diff(headYaw, hrpYaw) > math.rad(20) then
                return "LBY_BREAK"
            end
            return "LEGIT"
        end
        if Config.ResolverVelocity and avgSpeed > 8 then
            local vdirBuf = velDirBuf[plr]
            if vdirBuf and vdirBuf.count >= 3 then
                local vpile = getOrdered(vdirBuf); local vDelta=0
                for i=2,#vpile do vDelta = vDelta + diff(vpile[i], vpile[i-1]) end
                if (vDelta / math.max(#vpile-1,1)) < math.rad(5) and avg > math.rad(10) then
                    return "VELOCITY_DESYNC"
                end
            end
        end
        if avg < math.rad(16) and flips < 3 then return "STATIC_AA" end
        if flips >= math.floor(#pile * 0.35) then return "FLIP_AA" end
        return "JITTER_AA"
    end

    local function findClusters(pile)
        if #pile < 2 then return pile[1] or 0, pile[1] or 0 end
        local base = pile[1]; local unwrapped = {}
        for i, y in ipairs(pile) do unwrapped[i] = base + norm(y - base) end
        table.sort(unwrapped)
        local bestSplit, bestScore = 1, math.huge
        for i=2,#unwrapped-1 do
            local lSum, rSum, lN, rN = 0,0,0,0
            for j=1,i do lSum=lSum+unwrapped[j]; lN=lN+1 end
            for j=i+1,#unwrapped do rSum=rSum+unwrapped[j]; rN=rN+1 end
            local lMean, rMean = lSum/lN, rSum/rN
            local score = 0
            for j=1,i do score = score + (unwrapped[j]-lMean)^2 end
            for j=i+1,#unwrapped do score = score + (unwrapped[j]-rMean)^2 end
            if score < bestScore then bestScore = score; bestSplit = i end
        end
        local aSum,aN,bSum,bN = 0,0,0,0
        for i=1,bestSplit do aSum=aSum+unwrapped[i]; aN=aN+1 end
        for i=bestSplit+1,#unwrapped do bSum=bSum+unwrapped[i]; bN=bN+1 end
        return norm(aN>0 and aSum/aN or unwrapped[1]),
               norm(bN>0 and bSum/bN or unwrapped[#unwrapped])
    end

    local function predictFlipPhase(pile)
        if #pile < 4 then return 0 end
        local transitions = 0
        for i=2,#pile do
            if math.sign(math.sin(pile[i])) ~= math.sign(math.sin(pile[i-1])) then
                transitions = transitions + 1
            end
        end
        return transitions / (#pile - 1)
    end

    local miss_timeout = 0.6
    local lastAutoAdvance = {}

    local function resolveYaw(plr)
        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then return 0 end
        local realYaw = getHRPYaw(hrp)
        local mode = classifyAA(plr)
        modeCache[plr] = mode
        if mode == "LEGIT" or mode == "UNKNOWN" then confidence[plr]=1; return realYaw end
        local count = math.clamp(Config.ResolverBruteCount or 12, 4, #BRUTE_OFFSETS)
        local offsets = {}
        for i=1,count do offsets[i]=BRUTE_OFFSETS[i] end
        local now = os.clock()
        if not lastAutoAdvance[plr] then lastAutoAdvance[plr]=now
        elseif now - lastAutoAdvance[plr] > miss_timeout then
            lastAutoAdvance[plr]=now
            missCounter[plr]=(missCounter[plr] or 0)+1
        end
        if mode == "STATIC_AA" then
            if not lockedYaw[plr] then lockedYaw[plr]=realYaw end
            if lastMissed[plr] then
                local step = missCounter[plr] or 0
                lockedYaw[plr] = norm(realYaw + offsets[(step % #offsets) + 1])
                lastMissed[plr]=nil
            end
            return lockedYaw[plr]
        end
        if mode == "LBY_BREAK" then
            local head = plr.Character and plr.Character:FindFirstChild("Head")
            if head then
                local headYaw = getHeadYaw(head)
                if lastMissed[plr] then headYaw = norm(headYaw + math.pi); lastMissed[plr]=nil end
                return headYaw
            end
            return realYaw
        end
        if mode == "VELOCITY_DESYNC" then
            local vdirBuf = velDirBuf[plr]
            if vdirBuf and vdirBuf.count > 0 then
                local velYaw = getLatest(vdirBuf)
                if velYaw then
                    if lastMissed[plr] then velYaw = norm(velYaw + math.pi); lastMissed[plr]=nil end
                    return velYaw
                end
            end
            return realYaw
        end
        if mode == "FLIP_AA" or mode == "JITTER_AA" then
            local buf = yawBuf[plr]
            if buf and buf.count >= CLASSIFY_MIN then
                local pile = getOrdered(buf)
                local ca, cb = findClusters(pile)
                local latest = getLatest(buf) or realYaw
                local dA, dB = diff(latest, ca), diff(latest, cb)
                local chosen = dA < dB and ca or cb
                if lastMissed[plr] then chosen = dA < dB and cb or ca; lastMissed[plr]=nil end
                local flipRate = predictFlipPhase(pile)
                if Config.ResolverFlipPredict and flipRate > 0.4 and mode == "FLIP_AA" then
                    local distA, distB = diff(realYaw, ca), diff(realYaw, cb)
                    if distA > distB then chosen = ca else chosen = cb end
                end
                chosen = norm(chosen + (G.DivineLuaBIASAngle or 0))
                confidence[plr] = math.clamp(0.5 + flipRate * 0.5, 0.3, 1)
                if Config.ResolverLerp then
                    local last = resolvedYaw[plr] or chosen
                    return lerpAngle(last, chosen, Config.ResolverLerpSpeed or 0.35)
                end
                return chosen
            end
        end
        return realYaw
    end

    local lastAppliedYaw = {}
    local function applyYaw(plr, yaw)
        local char = plr.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end
        local last = lastAppliedYaw[plr]
        local d = last and math.abs((yaw - last + math.pi) % (2*math.pi) - math.pi) or math.rad(360)
        if d < math.rad(1) then return end
        local rj = hrp:FindFirstChild("RootJoint")
        if not rj or not rj:IsA("Motor6D") then return end
        pcall(function()
            if not rj:GetAttribute("BaseC0") then rj:SetAttribute("BaseC0", rj.C0) end
            rj.C0 = rj:GetAttribute("BaseC0") * CFrame.Angles(0, yaw, 0)
            lastAppliedYaw[plr] = yaw
        end)
    end

    local resolverLastTick = 0
    RunService.Heartbeat:Connect(function()
        local ok, err = pcall(function()
            if not Config.ResolverEnabled then return end
            if os.clock() - lastFlush > FLUSH_TIME then flushAll() end
            local now = os.clock()
            if now - resolverLastTick < 0.1 then return end
            resolverLastTick = now
            local tgt = getClosest()
            if tgt then
                pushSample(tgt)
                local yaw = resolveYaw(tgt)
                resolvedYaw[tgt] = yaw
                applyYaw(tgt, yaw)
            end
        end)
        if not ok then warn("[Resolver] error: " .. tostring(err)) end
    end)
end

-- ============================================================
-- ANTI MAP KICK
-- ============================================================
local function findSpawnLocations()
    local result = {}
    local knownFolders = {"Spawns","Spawn","SpawnPoints","SpawnLocations","spawns","spawn","MapSpawns","MapSpawn","TeamSpawns","TeamSpawn"}
    for _, name in ipairs(knownFolders) do
        local f = workspace:FindFirstChild(name)
        if f then
            for _, child in ipairs(f:GetDescendants()) do
                if child:IsA("SpawnLocation") or child:IsA("BasePart") then table.insert(result, child) end
            end
        end
    end
    if #result == 0 then
        for _, child in ipairs(workspace:GetDescendants()) do
            if child:IsA("SpawnLocation") then table.insert(result, child) end
        end
    end
    return result
end

local function getTeamColorFromName(name)
    if type(name) ~= "string" then return nil end
    local lower = name:lower()
    if lower == "ct" or lower:find("counter") then return BrickColor.new("Bright blue")
    elseif lower == "t" or lower:find("terror") then return BrickColor.new("Bright red") end
    return nil
end

local function getTeamSpawn()
    if G.cachedSpawn and G.cachedSpawn.Parent then return G.cachedSpawn end
    G.cachedSpawn = nil
    local spawns = findSpawnLocations()
    if #spawns == 0 then return nil end
    local teamName, teamColor
    local t = LocalPlayer.Team
    if t then teamName = t.Name; teamColor = t.TeamColor end
    if not teamName then
        local attr = LocalPlayer:GetAttribute("Team")
        if type(attr) == "string" then teamName = attr end
    end
    if teamName then
        local search = teamName:lower()
        for _, s in ipairs(spawns) do
            local path = ""
            if s.Parent then path = s.Parent.Name end
            path = (s.Name .. " " .. path):lower()
            if path:find(search, 1, true) then G.cachedSpawn = s; return s end
        end
    end
    if teamColor and typeof(teamColor) == "BrickColor" then
        for _, s in ipairs(spawns) do
            if s:IsA("SpawnLocation") and s.TeamColor == teamColor and not s.Neutral then
                G.cachedSpawn = s; return s
            end
        end
    end
    if teamName then
        local color = getTeamColorFromName(teamName)
        if color then
            for _, s in ipairs(spawns) do
                if s:IsA("SpawnLocation") and s.TeamColor == color then G.cachedSpawn = s; return s end
            end
        end
    end
    G.cachedSpawn = spawns[1]
    return spawns[1]
end

LocalPlayer.CharacterAdded:Connect(function() G.cachedSpawn = nil end)
LocalPlayer:GetPropertyChangedSignal("Team"):Connect(function() G.cachedSpawn = nil end)

RunService.Stepped:Connect(function()
    if not Config.AntiMapKickEnabled then return end
    if tick() < G.mapKickGraceEnd then return end
    local char = LocalPlayer.Character
    if not char or not char.Parent then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hum or hum.Health <= 0 then return end
    if hum:GetState() == Enum.HumanoidStateType.Dead then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local limitY = (workspace.FallenPartsDestroyHeight or -500) + Config.AntiMapKickOffset
    if hrp.Position.Y < limitY then
        local spawnPart = getTeamSpawn()
        if spawnPart and spawnPart.Parent then
            pcall(function()
                hrp.CFrame = CFrame.new(spawnPart.Position + Vector3.new(0, 5, 0))
                hrp.AssemblyLinearVelocity = Vector3.zero
                hrp.AssemblyAngularVelocity = Vector3.zero
            end)
        end
    end
end)

-- ============================================================
-- REFRESH + BHOP
-- ============================================================
task.spawn(function()
    while task.wait(1) do
        ensureScan()
        if Config.DisableAC then applyCachedAC() end
        if Config.NoSpreadEnabled then applyCachedSpread() end
    end
end)

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    scanGc()
    if Config.DisableAC then applyCachedAC() end
    if Config.NoSpreadEnabled then applyCachedSpread() end
end)

if Config.DisableAC then applyCachedAC() end
if Config.NoSpreadEnabled then applyCachedSpread() end

RunService.PreSimulation:Connect(function()
    if not Config.BhopEnabled then return end
    if isFrozen() then return end
    if not Character or not RootPart or not Humanoid or Humanoid.Health <= 0 then return end
    local currentState = Humanoid:GetState()
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        if currentState == Enum.HumanoidStateType.Landed or Humanoid.FloorMaterial ~= Enum.Material.Air then
            Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
    if currentState == Enum.HumanoidStateType.Jumping
    or currentState == Enum.HumanoidStateType.Freefall
    or Humanoid.FloorMaterial == Enum.Material.Air then
        local moveDir = Humanoid.MoveDirection
        if moveDir.Magnitude > 0 then
            local currentY = RootPart.AssemblyLinearVelocity.Y
            local targetSpeed = Config.BhopSpeed
            RootPart.AssemblyLinearVelocity = Vector3.new(
                moveDir.X * targetSpeed, currentY, moveDir.Z * targetSpeed
            )
        end
    end
end)

warn("[Penablox] Loaded")
