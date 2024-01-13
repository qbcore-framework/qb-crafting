local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem('crafting_table', function(source, item)
    TriggerClientEvent('player:useCraftingTable', source)
end)

QBCore.Functions.CreateCallback('crafting:getPlayerInventory', function(source, cb)
    local player = QBCore.Functions.GetPlayer(source)
    if player then
        cb(player.PlayerData.items)
    else
        cb({})
    end
end)

RegisterNetEvent('crafting:removeCraftingTable', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.RemoveItem('crafting_table', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['crafting_table'], 'remove')
    TriggerClientEvent('QBCore:Notify', src, 'You have placed the crafting table.', 'success')
end)

RegisterNetEvent('crafting:addCraftingTable', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end
    Player.Functions.AddItem('crafting_table', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['crafting_table'], 'add')
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
        TriggerClientEvent('QBCore:Notify', src, 'You have crafted a ' .. QBCore.Shared.Items[craftedItem].label, 'success')
    end
end)