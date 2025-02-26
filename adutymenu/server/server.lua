local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('aduty:checkWhitelist', function(source, cb)
    local identifiers = GetPlayerIdentifiers(source)
    for _, identifier in ipairs(identifiers) do
        if Config.Whitelist[identifier] then
            cb(Config.Whitelist[identifier])
            return
        end
    end
    cb(nil)
end)

RegisterNetEvent('aduty:server:bringPlayer', function(targetId)
    local src = source
    local adminPlayer = QBCore.Functions.GetPlayer(src)
    local targetPlayer = QBCore.Functions.GetPlayer(targetId)

    if adminPlayer and targetPlayer then
        local adminPed = GetPlayerPed(src)
        local adminCoords = GetEntityCoords(adminPed)

        -- Sende die Admin-Koordinaten an den Spieler, der gebracht wird
        TriggerClientEvent('aduty:tpToCoords', targetId, adminCoords)
        TriggerClientEvent('QBCore:Notify', src, "Spieler " .. targetId .. " wurde zu dir gebracht!", "success")
        TriggerClientEvent('QBCore:Notify', targetId, "Du wurdest zu Admin " .. src .. " teleportiert!", "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "Spieler nicht gefunden!", "error")
    end
end)

-- Spieler reviven
RegisterNetEvent('aduty:server:revivePlayer', function(targetId)
    local targetPlayer = QBCore.Functions.GetPlayer(targetId)
    if targetPlayer then
        TriggerClientEvent('hospital:client:Revive', targetId)
        TriggerClientEvent('QBCore:Notify', targetId, "Du wurdest revived!", "success")
    end
end)