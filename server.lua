local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('crafting:getPlayerInventory', function(source, cb)
    local player = QBCore.Functions.GetPlayer(source)
    if player then
        cb(player.PlayerData.items)
    else
        cb({})
    end
end)

for benchType, _ in pairs(Config) do
    QBCore.Functions.CreateUseableItem(benchType, function(source)
        TriggerClientEvent('player:useCraftingTable', source, benchType)
    end)
end

RegisterNetEvent('crafting:removeCraftingTable', function(benchType)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.RemoveItem(benchType, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[benchType], 'remove')
    TriggerClientEvent('QBCore:Notify', src, Lang:t('notifications.tablePlace'), 'success')
end)

RegisterNetEvent('crafting:addCraftingTable', function(benchType)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.AddItem(benchType, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[benchType], 'add')
end)

RegisterNetEvent('crafting:receiveItem', function(craftedItem, requiredItems, amountToCraft)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    local canGive = true
    for _, requiredItem in ipairs(requiredItems) do
        if not Player.Functions.RemoveItem(requiredItem.item, requiredItem.amount) then
            canGive = false
            return
        end
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[requiredItem.item], 'remove')
    end
    if canGive then
        Player.Functions.AddItem(craftedItem, amountToCraft)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[craftedItem], 'add')
        TriggerClientEvent('QBCore:Notify', src, string.format(Lang:t('notifications.craftMessage'), QBCore.Shared.Items[craftedItem].label), 'success')
    end
end)

RegisterNetEvent('crafting:increaseXP', function(xpGain, xpType)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        local currentXP = Player.PlayerData.metadata[xpType] or 0
        local newXP = currentXP + xpGain
        Player.Functions.SetMetaData(xpType, newXP)
        TriggerClientEvent('QBCore:Notify', src, string.format(Lang:t('notifications.xpGain'), xpGain, xpType), 'success')
    end
end)