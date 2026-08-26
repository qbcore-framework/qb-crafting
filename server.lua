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

RegisterNetEvent('qb-crafting:server:receiveItem', function(benchType, craftedItem, amountToCraft)
    local src = source
    local Player = exports['qb-core']:GetPlayer(src)
    if not Player then return end

    local benchConfig = Config[benchType]
    if not benchConfig or type(benchConfig.recipes) ~= 'table' then return end

    amountToCraft = tonumber(amountToCraft)
    if not amountToCraft or amountToCraft <= 0 then return end

    local recipe
    for _, configuredRecipe in pairs(benchConfig.recipes) do
        if configuredRecipe.item == craftedItem then
            recipe = configuredRecipe
            break
        end
    end
    if not recipe then return end

    local xpType = benchConfig.xpType or 'craftingrep'
    local currentXP = Player.PlayerData and Player.PlayerData.metadata and Player.PlayerData.metadata[xpType] or 0
    if (recipe.xpRequired or 0) > currentXP then return end

    for _, requiredItem in ipairs(recipe.requiredItems or {}) do
        local totalRequiredAmount = requiredItem.amount * amountToCraft
        if not exports['qb-inventory']:RemoveItem(src, requiredItem.item, totalRequiredAmount, false, 'qb-crafting:server:receiveItem') then
            return
        end
        TriggerClientEvent('qb-inventory:client:ItemBox', src, sharedItems[requiredItem.item], 'remove')
    end

    if not exports['qb-inventory']:AddItem(src, craftedItem, amountToCraft, false, false, 'qb-crafting:server:receiveItem') then return end

    TriggerClientEvent('qb-inventory:client:ItemBox', src, sharedItems[craftedItem], 'add')
    TriggerClientEvent('QBCore:Notify', src, string.format(Lang:t('notifications.craftMessage'), sharedItems[craftedItem].label), 'success')
    IncreasePlayerXP(src, (recipe.xpGain or 0) * amountToCraft, xpType)
end)

-- Items

for benchType, v in pairs(Config) do
    if type(v) == 'table' then
        QBCore.Functions.CreateUseableItem(benchType, function(source)
            TriggerClientEvent('qb-crafting:client:useCraftingTable', source, benchType)
        end)
    end
end
