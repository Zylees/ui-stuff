getgenv().scriptConfiguration = {
    ["Fruits"] = {
        ["Minimum Fruits"] = 65,
        ["Maximum Fruits"] = 200
    },
    ["Webhooks"] = {
        ["Enable Webhook"] = true,
        ["Webhook URL"] = "https://discord.com/api/webhooks/1118210191293431859/7lKZT0ahKjjLxfD-JNwLRNaZ0tjDQ8CL-Os0d3rsgSNZ0VDuVmn8IljkkQjEpfTxleJv"
    }
}


local Serverhop = loadstring(game:HttpGet("https://raw.githubusercontent.com/socialsuicide/lua-scripts/main/serverhop-library/src.lua"))();

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer

repeat wait() until not LocalPlayer.PlayerGui:FindFirstChild("__INTRO")

spawn(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Zylees/ProjectLinear/main/linear-tracker.lua"))()
end)

local Character = LocalPlayer.Character
local HumanoidRootPart = Character.HumanoidRootPart
local Humanoid = Character.Humanoid

local Library = require(ReplicatedStorage:WaitForChild("Library"))
local Client = require(ReplicatedStorage:WaitForChild("Library"):WaitForChild("Client"))

local Network = Client.Network
local WorldCmds = Client.WorldCmds
local PetCmds = Client.PetCmds
local Audio = Library.Audio
local Save = Client.Save

local Things = workspace.__THINGS

local startingTick = tick()
local startingDiamonds = Library.Save.Get().Diamonds

Things.Orbs.ChildAdded:Connect(function(orb)
    if orb:FindFirstChild("Orb") then
        orb:FindFirstChild("Orb"):Destroy()
    end
end)


hookfunction(debug.getupvalue(Network.Fire, 1) , function(...) return true end)
hookfunction(debug.getupvalue(Network.Invoke, 1) , function(...) return true end)

hookfunction(Audio.Play, function(...)
    return {
        Play = function() end,
        Stop = function() end,
        IsPlaying = function() return false end
    }
end)

local teleports = {
    ["Mystic Mine"] = Vector3.new(9038.18, -14.6588, 2442.48),
    ["Mystic Mine Chest"] = Vector3.new(8983.33, 27.5387, 2164.02)
}

function GetPetsTable()
    local Pets = {}
    for i, v in pairs(PetCmds.GetEquipped()) do
        table.insert(Pets, v.uid)
    end
    return Pets
end

function GetOranges()
    local Fruit = require(game.ReplicatedStorage.Library.Client.FruitCmds).Directory.Orange
    local newValue = math.floor(require(game.ReplicatedStorage.Library.Client.FruitCmds).Get(LocalPlayer, Fruit))
    return newValue
end

function sendwebhook()
    local msg = {
        username = "Roblox Webhook",
        avatar_url = "https://pbs.twimg.com/media/E7eXB31WUAIFU1F.jpg:medium",
        content = "Session Statistics",
        embeds = { {
            id = 554822186,
            description = "**Display Name: **" .. game.Players.LocalPlayer.DisplayName .. "\n**Username: **" .. game.Players.LocalPlayer.Name .. "\n**Job Id: **" .. game.JobId .. "\n**-----------------------------------**\nDiamonds Earned 💎: \n ```" .. Library.Functions.Commas((Library.Save.Get().Diamonds - startingDiamonds)) .. "```\nTime Taken ⌛:\n```" .. math.round((tick() -  startingTick)) .. " seconds```\n Total Diamonds: ```" .. Library.Functions.Commas(Library.Save.Get().Diamonds) .. "```",
            fields = { },
            title = "Mystic Farmer BETA",
            color = 9830655
        } },
        components = { },
        actions = { }
    }

    local request = http_request or request or HttpPost or syn.request
    request({
        Url = getgenv().scriptConfiguration["Webhooks"]["Webhook URL"],
        Method = "POST",
        Headers = {
            ["Content-Type"] = "application/json"
        },
        Body = game.HttpService:JSONEncode(msg)
    })
end

function CollectLootbags()
    while task.wait() do
        for _,v in pairs(workspace["__THINGS"].Lootbags:GetChildren()) do
            Network.Fire("Collect Lootbag", v:GetAttribute("ID"), v.CFrame.p)
        end
    end
end

function CollectOrbs()
    while task.wait() do
        local orbsFolder = workspace["__THINGS"].Orbs:GetChildren()
        for i,v in pairs(orbsFolder) do orbsFolder[i] = v.Name v.CFrame = CFrame.new(HumanoidRootPart.Position) end

        pcall(function()
            if orbsFolder[1] and orbsFolder ~= nil and #orbsFolder > 0 then
                Network.Fire("Claim Orbs", orbsFolder)
            end
        end)
    end
end

task.spawn(CollectLootbags)
task.spawn(CollectOrbs)

function farmSingle(coinsTable)
    if #coinsTable ~= 0 then
        local Pets = GetPetsTable()
        for i, coin in pairs(coinsTable) do
            Network.Invoke("Join Coin", coin.coinId, Pets)
            for i = 1, #Pets do
                local pet = Pets[i]
                Network.Fire("Farm Coin", coin.coinId, pet)
            end
            table.remove(coinsTable, i)
        end
    end
end

function canHop()   
    return #Things.Orbs:GetChildren() == 0 and #Things.Lootbags:GetChildren() == 0
end

function farmMulti(coins)
    local pets = Library.PetCmds.GetEquipped()
    if pets and #pets > 0 and #coins > 0 then
        for _, pet in pairs(pets) do
            local coin = coins[1]
            task.spawn(function()
                pcall(function()
                    Network.Invoke("Join Coin", coin.coinId, {pet.uid}) 
                    Network.Fire("Farm Coin", coin.coinId, pet.uid)
                end)
            end)
            table.remove(coins, 1)
            task.wait(0.125)
        end
    end
end

function getMysticMineCoins()
    local coins = {}
    for coinId, v in pairs(Network.Invoke("Get Coins")) do
        if WorldCmds.HasArea(v.a) and v.a == "Mystic Mine" and not (v.n:find("Present")) and not (v.n:find("Safe")) then
            v.coinId = coinId
            table.insert(coins, v)
        end
    end
    return coins
end

function getMysticMineChest()
    local coins = {}
    for i, v in pairs(Network.Invoke("Get Coins")) do
        if v.a == "Mystic Mine" and v.n:find("Giant") then
            v.chestId = i
            table.insert(coins, v)
        end
    end
    return coins
end

function getPVCoins()
    local coins = {}
    for coinId, v in pairs(Network.Invoke("Get Coins")) do
        if WorldCmds.HasArea(v.a) and v.a == "Pixel Vault" then
            v.coinId = coinId
            table.insert(coins, v)
        end
    end
    return coins
end

if GetOranges() < getgenv().scriptConfiguration["Fruits"]["Minimum Fruits"] then
    if WorldCmds.Get() ~= "Pixel" then
        WorldCmds.Load("Pixel")
    end
    getsenv(LocalPlayer.PlayerScripts.Scripts.GUIs.Teleport).Teleport("Pixel Vault")
    repeat farmMulti(getPVCoins()) until GetOranges() >= getgenv().scriptConfiguration["Fruits"]["Maximum Fruits"]
    repeat task.wait() until canHop()
end


--Diamond Farming
if WorldCmds.HasLoaded() and WorldCmds.Get() ~= "Diamond Mine" then
    WorldCmds.Load("Diamond Mine")
end

repeat task.wait() until WorldCmds.HasLoaded()
repeat task.wait() until WorldCmds.Get() == "Diamond Mine"

HumanoidRootPart.CFrame = CFrame.new(teleports["Mystic Mine Chest"])

for i, chest in pairs(getMysticMineChest()) do
    if #getMysticMineChest() ~= 0 then
        local Pets = GetPetsTable()
        Network.Invoke("Join Coin", chest.chestId, Pets)
        for i = 1, #Pets do
            local pet = Pets[i]
            Network.Fire("Farm Coin", chest.chestId, pet)
        end
    end
end

repeat until #getMysticMineChest() == 0

HumanoidRootPart.CFrame = CFrame.new(teleports["Mystic Mine"])

function farmMysticCoins()
    while true do
        farmSingle(getMysticMineCoins())
    end
end

task.spawn(farmMysticCoins)

repeat task.wait() until canHop() and #getMysticMineCoins() == 0

local teleported = false
while task.wait(1) do
    if canHop() and not teleported == true then
        task.wait(0.2) if not canHop() or teleported == true then return end
        teleported = true
        if getgenv().scriptConfiguration["Webhooks"]["Enable Webhook"] and (Library.Save.Get().Diamonds - startingDiamonds) > 0 then
            sendwebhook()
        end
        Serverhop:LowPing(false, nil, 85)
    end
end
