local QBCore = exports['qb-core']:GetCoreObject({ 'Functions' })
local sharedItems = exports['qb-core']:GetShared('Items')

-- Functions

local function IncreasePlayerXP(source, xpGain, xpType)
    local Player = exports['qb-core']:GetPlayer(source)
    if Player then
        local currentXP = Player.GetRep(xpType)
        local newXP = currentXP + xpGain
        Player.AddRep(xpType, newXP)
        TriggerClientEvent('QBCore:Notify', source, string.format(Lang:t('notifications.xpGain'), xpGain, xpType), 'success')
    end
end

-- Callbacks

QBCore.Functions.CreateCallback('crafting:getPlayerInventory', function(source, cb)
    local player = exports['qb-core']:GetPlayer(source)
    if player then
        cb(player.PlayerData.items)
    else
        cb({})
    end
end)

-- Events
RegisterServerEvent('qb-crafting:server:removeMaterials', function(itemName, amount)
    local src = source
    local Player = exports['qb-core']:GetPlayer(src)
    if Player then
        exports['qb-inventory']:RemoveItem(src, itemName, amount, false, 'qb-crafting:server:removeMaterials')
        TriggerClientEvent('qb-inventory:client:ItemBox', src, sharedItems[itemName], 'remove')
    end
end)

RegisterNetEvent('qb-crafting:server:removeCraftingTable', function(benchType)
    local src = source
    local Player = exports['qb-core']:GetPlayer(src)
    if not Player then return end
    exports['qb-inventory']:RemoveItem(src, benchType, 1, false, 'qb-crafting:server:removeCraftingTable')
    TriggerClientEvent('qb-inventory:client:ItemBox', src, sharedItems[benchType], 'remove')
    TriggerClientEvent('QBCore:Notify', src, Lang:t('notifications.tablePlace'), 'success')
end)

RegisterNetEvent('qb-crafting:server:addCraftingTable', function(benchType)
    local src = source
    local Player = exports['qb-core']:GetPlayer(src)
    if not Player then return end
    if not exports['qb-inventory']:AddItem(src, benchType, 1, false, false, 'qb-crafting:server:addCraftingTable') then return end
    TriggerClientEvent('qb-inventory:client:ItemBox', src, sharedItems[benchType], 'add')
end)

RegisterNetEvent('qb-crafting:server:receiveItem', function(craftedItem, requiredItems, amountToCraft, xpGain, xpType)
    local src = source
    local Player = exports['qb-core']:GetPlayer(src)
    if not Player then return end
    local canGive = true
    for _, requiredItem in ipairs(requiredItems) do
        if not exports['qb-inventory']:RemoveItem(src, requiredItem.item, requiredItem.amount, false, 'qb-crafting:server:receiveItem') then
            canGive = false
            return
        end
        TriggerClientEvent('qb-inventory:client:ItemBox', src, sharedItems[requiredItem.item], 'remove')
    end
    if canGive then
        if not exports['qb-inventory']:AddItem(src, craftedItem, amountToCraft, false, false, 'qb-crafting:server:receiveItem') then return end
        TriggerClientEvent('qb-inventory:client:ItemBox', src, sharedItems[craftedItem], 'add')
        TriggerClientEvent('QBCore:Notify', src, string.format(Lang:t('notifications.craftMessage'), sharedItems[craftedItem].label), 'success')
        IncreasePlayerXP(src, xpGain, xpType)
    end
end)

-- Items

for benchType, v in pairs(Config) do
    if type(v) == 'table' then
        QBCore.Functions.CreateUseableItem(benchType, function(source)
            TriggerClientEvent('qb-crafting:client:useCraftingTable', source, benchType)
        end)
    end
end
