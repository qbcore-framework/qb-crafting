local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("crafting_table", function(source, item)
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

RegisterNetEvent('crafting:removeCraftingTable')
AddEventHandler('crafting:removeCraftingTable', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem('crafting_table', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['crafting_table'], 'remove')
    TriggerClientEvent('QBCore:Notify', src, "You have placed the crafting table.", "success")
end)

RegisterNetEvent('crafting:addCraftingTable')
AddEventHandler('crafting:addCraftingTable', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('crafting_table', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['crafting_table'], 'add')
end)

RegisterNetEvent('crafting:receiveItem')
AddEventHandler('crafting:receiveItem', function(craftedItem, requiredItems)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem(craftedItem, 1)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[craftedItem], 'add')

    for i, requiredItem in ipairs(requiredItems) do
        Player.Functions.RemoveItem(requiredItem.item, requiredItem.amount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[requiredItem.item], 'remove')
    end

    TriggerClientEvent('QBCore:Notify', src, "You have crafted a " .. QBCore.Shared.Items[craftedItem].label, "success")
end)