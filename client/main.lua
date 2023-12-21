ESX = exports['es_extended']:getSharedObject()
PlayerData = {}

Citizen.CreateThread(function()
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(5000)
	end
    PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('gg_shoprobbery:notifyPolice')
AddEventHandler('gg_shoprobbery:notifyPolice', function(coords)	
    if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		street = GetEntityCoords(PlayerPedId())
		street2 = GetStreetNameFromHashKey(street)
		Notify(Strings.police_notify, 'warning')
		PlaySoundFrontend(-1, "Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset", 0)

		blip = AddBlipForCoord(street)
		SetBlipSprite(blip,  403)
		SetBlipColour(blip,  1)
		SetBlipAlpha(blip, 250)
		SetBlipScale(blip, 1.2)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Strings.shoprob_blip)
		EndTextCommandSetBlipName(blip)
		table.insert(blips, blip)
		Wait(50000)
		for i in pairs(blips) do
			RemoveBlip(blips[i])
			blips[i] = nil
		end
	end
end)

local cashregisters = { `prop_till_01` }
local initialCooldownSeconds = Config.RobCooldownCH
local cooldownSecondsRemaining = 0
exports.ox_target:addModel(cashregisters, {
    {
        name = 'cashregister',
        label = 'Rob Cash Register',
        icon = 'fa-solid fa-cash-register',
        items = Config.LockpickItem,
        onSelect = function()
            local policeCount = lib.callback.await('gg_shoprobbery:getPoliceCount', false)
            if policeCount < Config.PoliceCount then
                Notify(Strings.no_polices, 'warning')
            return 
            end
            FreezeEntityPosition(PlayerPedId(), true)
            TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_PARKING_METER', 0, true)
            local success = lib.skillCheck({'easy', 'easy', {areaSize = 60, speedMultiplier = 2}, 'easy'}, {'w', 'a', 's', 'd'})
            if not success then
                TriggerEvent("gg_shoprobbery:notifyPolice")
                ClearPedTasks(PlayerPedId())
                FreezeEntityPosition(PlayerPedId(), false)
                Notify(Strings.you_failed, 'error')
            else
            if success and cooldownSecondsRemaining <= 0 then
                Notify(Strings.you_success, 'success')
                if lib.progressBar({
                    duration = Config.OxProgressTime,
                    label = 'Robbing cash register',
                    useWhileDead = false,
                    canCancel = true,
                    disable = {
                        car = true,
                    },
                }) then
                    lib.callback.await('gg_shoprobbery:cashregisterreward', source)
                    Citizen.Wait(10)
                    ClearPedTasks(PlayerPedId())
                    FreezeEntityPosition(PlayerPedId(), false)
                    cashregisterCooldown()
                    Notify(Strings.cashregister_cooldown, 'success')
                end
            end
        end
    end
    }
})
function cashregisterCooldown()
    cooldownSecondsRemaining = initialCooldownSeconds
    Citizen.CreateThread(function()
        while cooldownSecondsRemaining > 0 do
            Citizen.Wait(1000)
            cooldownSecondsRemaining = cooldownSecondsRemaining - 1
            ClearPedTasks(PlayerPedId())
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end)
end

local kokoAika = Config.RobCooldownSafe
local sekuntejaJaljella = 0
for k, v in pairs(Config.Safecoords) do 
    exports.ox_target:addSphereZone({
        coords = vector3(v.x, v.y, v.z),
        radius = 2,         
        options = {
            {
                name = 'safe',
                icon = 'fa-solid fa-key',
                label = 'Rob safe',
                debug = true ,
                drawSprite = true,
                items = Config.LockpickItem,
                onSelect = function()
                    local policeCount = lib.callback.await('gg_shoprobbery:getPoliceCount', false)
                    if policeCount < Config.PoliceCount then
                        Notify(Strings.no_polices, 'warning')
                        return 
                    end
                    FreezeEntityPosition(PlayerPedId(), true)
                    TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_PARKING_METER', 0, true)
                    local success = lib.skillCheck({'easy', 'easy', {areaSize = 60, speedMultiplier = 2}, 'easy'}, {'w', 'a', 's', 'd'})
                    if not success then
                        TriggerEvent("gg_shoprobbery:notifyPolice")
                        ClearPedTasks(PlayerPedId())
                        FreezeEntityPosition(PlayerPedId(), false)
                        Notify(Strings.you_failed, 'error')
                    else
                        if success and sekuntejaJaljella <= 0 then
                        Notify(Strings.you_success, 'success')
                        if lib.progressBar({
                            duration = Config.OxProgressTimeSafe,
                            label = 'Robbing safe',
                            useWhileDead = false,
                            canCancel = true,
                            disable = {
                                car = true,
                            },
                        }) then
                            lib.callback.await('gg_shoprobbery:safereward', source)
                            Citizen.Wait(10)
                            ClearPedTasks(PlayerPedId())
                            FreezeEntityPosition(PlayerPedId(), false)
                            SafeCooldown()
                            Notify(Strings.safe_cooldown, 'warning')
                        end
                    end
                end
                end
            }
        }
    })
end

function SafeCooldown()
    sekuntejaJaljella = kokoAika
    Citizen.CreateThread(function()
        while sekuntejaJaljella > 0 do
            Citizen.Wait(1000)
            sekuntejaJaljella = sekuntejaJaljella - 1
            ClearPedTasks(PlayerPedId())
            FreezeEntityPosition(PlayerPedId(), false)
        end
    end)
end

function Notify(text, type)
    if Config.NotificationType == 'ox_lib' then
        lib.notify({
            title = text,
            type = type
        })
    else
        ESX.ShowNotification(text)
    end
end