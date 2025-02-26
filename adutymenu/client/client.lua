local QBCore = exports['qb-core']:GetCoreObject()
Config = Config or {} -- Stelle sicher, dass Config existiert

local isAdminDuty = false
local previousOutfit = {}
local isNoclip = false -- Beispielvariable für Noclip

-- Check if a player is whitelisted and return their role
local function checkWhitelist(callback)
    QBCore.Functions.TriggerCallback("aduty:checkWhitelist", function(role)
        callback(role)
    end)
end

RegisterCommand(Config.CommandName, function()
    checkWhitelist(function(role)
        if not role or not Config.Outfits[role] then
            TriggerEvent("chat:addMessage", {
                args = { "Du bist nicht berechtigt, diesen Befehl zu verwenden." },
                color = { 255, 0, 0 }
            })
            return
        end

        local playerPed = PlayerPedId()
        local model = GetEntityModel(playerPed)
        local gender = model == GetHashKey("mp_m_freemode_01") and "male" or "female"

        if not isAdminDuty then
            -- Speichere das aktuelle Outfit
            previousOutfit = {
                torso = {id = GetPedDrawableVariation(playerPed, 11), texture = GetPedTextureVariation(playerPed, 11)},
                arms = {id = GetPedDrawableVariation(playerPed, 3), texture = 0},
                legs = {id = GetPedDrawableVariation(playerPed, 4), texture = GetPedTextureVariation(playerPed, 4)},
                shoes = {id = GetPedDrawableVariation(playerPed, 6), texture = GetPedTextureVariation(playerPed, 6)},
                undershirt = {id = GetPedDrawableVariation(playerPed, 8), texture = GetPedTextureVariation(playerPed, 8)},
                armor = {id = GetPedDrawableVariation(playerPed, 9), texture = GetPedTextureVariation(playerPed, 9)},
                mask = {id = GetPedDrawableVariation(playerPed, 1), texture = GetPedTextureVariation(playerPed, 1)},
                hat = {id = GetPedPropIndex(playerPed, 0), texture = GetPedPropTextureIndex(playerPed, 0)}
            }

            -- Wende das Dienst-Outfit an
            local outfit = Config.Outfits[role][gender]
            SetPedComponentVariation(playerPed, 11, outfit.torso[1], outfit.torso[2], 2)
            SetPedComponentVariation(playerPed, 3, outfit.arms[1], outfit.arms[2], 2)
            SetPedComponentVariation(playerPed, 4, outfit.legs[1], outfit.legs[2], 2)
            SetPedComponentVariation(playerPed, 6, outfit.shoes[1], outfit.shoes[2], 2)
            SetPedComponentVariation(playerPed, 8, outfit.undershirt[1], outfit.undershirt[2], 2)
            SetPedComponentVariation(playerPed, 9, outfit.armor[1], outfit.armor[2], 2)
            SetPedComponentVariation(playerPed, 1, outfit.mask[1], outfit.mask[2], 2)
            if outfit.hat[1] and outfit.hat[1] ~= -1 then
                SetPedPropIndex(playerPed, 0, outfit.hat[1], outfit.hat[2], true)
            else
                ClearPedProp(playerPed, 0)
            end

            isAdminDuty = true
            Citizen.CreateThread(function()
                while isAdminDuty do
                    local playerPed = PlayerPedId()
                    local vehicle = GetVehiclePedIsIn(playerPed, false)
            
                    -- Spieler unsterblich machen
                    SetEntityInvincible(playerPed, true)
                    SetPlayerInvincible(PlayerId(), true)
                    SetPedCanRagdoll(playerPed, false)
                    SetEntityProofs(playerPed, true, true, true, true, true, true, true, true)
                    SetPedConfigFlag(playerPed, 32, true) -- Kein Schleudern nach Crash
                    SetPedConfigFlag(playerPed, 33, true) -- Kein Fallschaden
                    ResetPedVisibleDamage(playerPed) -- Entfernt visuelle Schäden
                    ClearPedLastWeaponDamage(playerPed) -- Entfernt evtl. letzte Schadensquelle
                    SetEntityHealth(playerPed, 200) -- Setzt Leben immer wieder auf max (standard: 200)
            
                    -- Falls im Fahrzeug
                    if vehicle ~= 0 then
                        SetEntityInvincible(vehicle, true)
                        SetVehicleEngineCanDegrade(vehicle, false)
                        SetVehicleCanBreak(vehicle, false)
                        SetVehicleTyresCanBurst(vehicle, false)
                        SetVehicleExplodesOnHighExplosionDamage(vehicle, false)
                        SetEntityProofs(vehicle, true, true, true, true, true, true, true, true)
            
                        -- Schutz vor Crash-Schaden
                        SetPedCanBeKnockedOffVehicle(playerPed, 1) -- Spieler bleibt im Fahrzeug
                        SetEntityHealth(vehicle, GetEntityMaxHealth(vehicle)) -- Fahrzeug bleibt auf Max-Gesundheit
                    end
            
                    Citizen.Wait(100) -- Kürzere Wartezeit für bessere Absicherung
                end
            end)
                       
            TriggerEvent("qb-admin:client:toggleNames", true)
            TriggerEvent("chat:addMessage", {
                args = { "Du bist jetzt im " .. role .. "-Dienst." },
                color = { 255, 255, 0 }
            })

            lib.showMenu('aduty_menu')
        else
            lib.showMenu('aduty_menu')
        end
    end)
end)

lib.registerMenu({
    id = 'aduty_menu',
    title = Config.MenuTitle,
    position = 'top-left',
    options = {
        { label = 'Noclip', description = 'Klicke hier, um Noclip umzuschalten', disabled = not Config.EnableNoclip },
        { label = 'TP to Marker', description = 'Klicke hier, um zum Marker zu teleporieren', disabled = not Config.EnableTPToMarker },
        { label = 'TP to Player', description = 'Klicke hier, um zu einem Spieler zu teleporieren', disabled = not Config.EnableTPToPlayer },
        { label = 'Bring Player', description = 'Klicke hier, um einen Spieler zu bringen', disabled = not Config.EnableBringPlayer },
        { label = 'Revive Player', description = 'Klicke hier, um einen Spieler zu reviven', disabled = not Config.EnableRevivePlayer },
        { label = 'Dienst beenden', description = 'Klicke hier, um Aduty zu verlassen' },
    }
}, function(selected, scrollIndex, args)
    -- Hier unterscheidest du anhand des Indexes, welcher Button gedrückt wurde:
    if selected == 1 and Config.EnableNoclip then
        TriggerEvent("aduty:toggleNoclip")
    elseif selected == 2 and Config.EnableTPToMarker then
        TriggerEvent("aduty:tpToMarker")
    elseif selected == 3 and Config.EnableTPToPlayer then
        TriggerEvent("aduty:inputPlayerId", "tpToPlayer")
    elseif selected == 4 and Config.EnableBringPlayer then
        TriggerEvent("aduty:inputPlayerId", "bringPlayer")
    elseif selected == 5 and Config.EnableRevivePlayer then
        TriggerEvent("aduty:inputPlayerId", "revivePlayer")
    elseif selected == 6 then
        TriggerEvent("aduty:exit")
    end
end)


RegisterNetEvent('aduty:exit', function()
    local playerPed = PlayerPedId()

    if previousOutfit and previousOutfit.torso then
        SetPedComponentVariation(playerPed, 11, previousOutfit.torso.id, previousOutfit.torso.texture, 2)
        SetPedComponentVariation(playerPed, 3, previousOutfit.arms.id, previousOutfit.arms.texture, 2)
        SetPedComponentVariation(playerPed, 4, previousOutfit.legs.id, previousOutfit.legs.texture, 2)
        SetPedComponentVariation(playerPed, 6, previousOutfit.shoes.id, previousOutfit.shoes.texture, 2)
        SetPedComponentVariation(playerPed, 8, previousOutfit.undershirt.id, previousOutfit.undershirt.texture, 2)
        SetPedComponentVariation(playerPed, 9, previousOutfit.armor.id, previousOutfit.armor.texture, 2)
        SetPedComponentVariation(playerPed, 1, previousOutfit.mask.id, previousOutfit.mask.texture, 2)
        if previousOutfit.hat and previousOutfit.hat.id and previousOutfit.hat.id ~= -1 then
            SetPedPropIndex(playerPed, 0, previousOutfit.hat.id, previousOutfit.hat.texture, true)
        else
            ClearPedProp(playerPed, 0)
        end
    else
    end

    TriggerEvent("qb-admin:client:toggleNames", false)
    TriggerEvent("chat:addMessage", {
        args = { "Du bist jetzt nicht mehr im Dienst." },
        color = { 255, 0, 0 }
    })

    isAdminDuty = false
    SetEntityInvincible(playerPed, false)
    lib.hideMenu("aduty_menu")
end)

RegisterNetEvent('aduty:toggleNoclip', function()
    -- Toggle den Noclip-Zustand
    isNoclip = not isNoclip

    TriggerEvent("qb-admin:client:ToggleNoClip", isNoclip) -- Übergibt den richtigen Zustand
    TriggerEvent("chat:addMessage", {
        args = { isNoclip and "Du bist jetzt im Noclip" or "Du bist nicht mehr im Noclip" },
        color = { 255, 0, 0 }
    })
end)

RegisterNetEvent("aduty:tpToMarker", function()
    local playerPed = PlayerPedId()
    local waypoint = GetFirstBlipInfoId(8) -- 8 = Waypoint
    if DoesBlipExist(waypoint) then
        local coords = GetBlipCoords(waypoint)
        SetPedCoordsKeepVehicle(playerPed, coords.x, coords.y, coords.z + 1.0)
        QBCore.Functions.Notify("Du wurdest zum Marker teleportiert!", "success")
    else
        QBCore.Functions.Notify("Kein Marker gefunden!", "error")
    end
end)

RegisterNetEvent("aduty:inputPlayerId", function(action)
    local input = lib.inputDialog('Spieler auswählen', {
        {type = 'number', label = 'Spieler ID', required = true}
    })

    if input and input[1] then
        local targetId = tonumber(input[1])
        TriggerEvent("aduty:" .. action, targetId)
    else
        QBCore.Functions.Notify("Ungültige Spieler ID!", "error")
    end
end)

RegisterNetEvent("aduty:tpToPlayer", function(targetId)
    local targetPed = GetPlayerPed(GetPlayerFromServerId(targetId))
    if DoesEntityExist(targetPed) then
        local coords = GetEntityCoords(targetPed)
        SetPedCoordsKeepVehicle(PlayerPedId(), coords.x, coords.y, coords.z + 1.0)
        QBCore.Functions.Notify("Du wurdest zu Spieler " .. targetId .. " teleportiert!", "success")
    else
        QBCore.Functions.Notify("Spieler nicht gefunden!", "error")
    end
end)

RegisterNetEvent("aduty:bringPlayer", function(targetId)
    TriggerServerEvent('aduty:server:bringPlayer', targetId)
end)

-- 📌 Bringe Spieler zu den Admin-Koordinaten
RegisterNetEvent("aduty:tpToCoords", function(coords)
    local ped = PlayerPedId()
    SetPedCoordsKeepVehicle(ped, coords.x, coords.y, coords.z + 1.0)
    QBCore.Functions.Notify("Du wurdest teleportiert!", "success")
end)

RegisterNetEvent("aduty:revivePlayer", function(targetId)
    TriggerServerEvent('aduty:server:revivePlayer', targetId)
end)









