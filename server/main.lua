ESX = exports['es_extended']:getSharedObject()

lib.callback.register('gg_shoprobbery:cashregisterreward', function(source)
    local prize = Config.CashRegisterReward
    exports.ox_inventory:AddItem(source, 'money', prize, nil, nil, nil)
    Notify(src, Strings.cashregister_prize, 'success')
    exports.ox_inventory:RemoveItem(source, Config.LockpickItem, 1, nil, nil, nil)
end)

lib.callback.register('gg_shoprobbery:safereward', function(source)
    local prize = Config.SafeReward
    exports.ox_inventory:AddItem(source, 'money', prize, nil, nil, nil)
    Notify(src, Strings.safe_prize, 'success')
    exports.ox_inventory:RemoveItem(source, Config.LockpickItem, 1, nil, nil, nil)
end)

lib.callback.register('gg_shoprobbery:getPoliceCount', function(source)
    return #ESX.GetExtendedPlayers('job', 'police')
end)

function Notify(src, text, type)
    if Config.NotificationType == 'ox_lib' then
        lib.notify(source, {
            title = text,
            type = type,
        })
    else
    TriggerClientEvent('esx:showNotification', src, text)
    end
end