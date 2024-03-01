local QBCore = exports[Config.Core]:GetCoreObject()
local SendNUI = false
local Drag = false

RegisterCommand("glist", function()
    for k, v in pairs(Config.Gang) do
        if QBCore.Functions.GetPlayerData().gang.name == k then
            if SendNUI == false then
                SetNuiFocus(false, false)
                SendNUIMessage({
                    CheckUi = "OpenUi"
                })
                SendNUI = true
            elseif SendNUI == true then
                SetNuiFocus(false, false)
                SendNUIMessage({
                    CheckUi = "CloseUi"
                })
                SendNUI = false
            end
            TriggerServerEvent("hubtest")
        end
    end
end, false)

RegisterCommand("glistc", function()
    if SendNUI == true then
        if Drag == false then     
            SetNuiFocus(true, true)
            Drag = true
        else
            SetNuiFocus(false, false)
            Drag = false
        end
    else
        QBCore.Functions.Notify("You should open the gang list first!", "error", 4000)
    end
end, false)

CreateThread(function()
    while true do
        Wait(3000)
        TriggerServerEvent("hubtest")
    end
end)

RegisterNetEvent("V7:Hub:RefreshGanginfo", function(data)
    Wait(50)
    SendNUIMessage({
        CheckUi = "Refresh",
        Ganginfo = data,
    })
end)

RegisterNuiCallback("closeMenu", function()
    if Drag == true then
        SetNuiFocus(false, false)
        Drag = false
    end
end)
