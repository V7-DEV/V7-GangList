local QBCore = exports[Config.Core]:GetCoreObject()

RegisterNetEvent("hubtest", function()
    GangCount = {}
    local GangArray = {}
    local GangPlayerCount = 0
    local PlayerRank = "( " .. QBCore.Functions.GetPlayer(source).PlayerData.gang.grade.name .. " )"

    for _, a in pairs(QBCore.Functions.GetQBPlayers()) do
        if a then
            local PlayerRadio = GetRadioChannel(a.PlayerData.source)
            local playerPed = GetPlayerPed(a.PlayerData.source)
            local playerVehicle = GetVehiclePedIsIn(playerPed, false)
            local PlayerRadio2 = ""
            local Icon = ""

            if Config.Gang[QBCore.Functions.GetPlayer(source).PlayerData.gang.name].ShowRadio == true then
                if PlayerRadio == 0 then
                    PlayerRadio2 = ("(!)")
                else
                    PlayerRadio2 = "(" .. PlayerRadio .. ")"
                end
            else
                PlayerRadio2 = ("(!)")
            end

            if Config.Gang[QBCore.Functions.GetPlayer(source).PlayerData.gang.name].ShowVehicleState == true then
                if playerVehicle ~= 0 then
                    Icon = '<i class="fa-solid fa-car" style="color: #ffffff;"></i>'
                else
                    Icon = '<i class="fa-solid fa-person fa-lg" style="color: #ffffff;"></i>'
                end
            else
                Icon = '<i class="fa-solid fa-person fa-lg" style="color: #ffffff;"></i>'
            end

            if QBCore.Functions.GetPlayer(source).PlayerData.gang.name == a.PlayerData.gang.name then
                GangPlayerCount = GangPlayerCount + 1
                GangCount[#GangCount + 1] = {
                    UserIcon = Icon,
                    UserName = a.PlayerData.charinfo.firstname .. ' ' .. a.PlayerData.charinfo.lastname,
                    UserGangRank = PlayerRank,
                    Radio = PlayerRadio2,
                    backgroundColor = Config.Gang[a.PlayerData.gang.name].GangColor,
                    GangName = QBCore.Functions.GetPlayer(source).PlayerData.gang.name,
                    GangTut = GangPlayerCount,
                }
            end
        end
    end

    table.insert(GangArray, GangCount)
    TriggerClientEvent("V7:Hub:RefreshGanginfo", source, GangCount)
end)

function GetRadioChannel(source)
    if Player(source).state['radioChannel'] ~= nil then
        return Player(source).state['radioChannel']
    end
    return 0
end

AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == "V7-GangList" then
        Wait(100)
        print("\27[33m" .. "[" .. resourceName .. "]" .. "\27[0m" .. " " .. "\27[32m" .. "Thanks for download this script," .. " " .. "have fun! :)" .. "\27[0m")
    end
end)