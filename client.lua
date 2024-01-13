local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('player:useCraftingTable', function()

    local playerPed = PlayerPedId()
    local coordsP = GetOffsetFromEntityInWorldCoords(playerPed,0.0,1.0,1.0)
    local playerHeading = GetEntityHeading(PlayerPedId())
    local itemHeading = playerHeading - 90
    local workbench = CreateObject(GetHashKey('prop_tool_bench02'), coordsP, true, true, true)

    if itemHeading < 0 then itemHeading = 360 + itemHeading end
    SetEntityHeading(workbench, itemHeading)
    PlaceObjectOnGroundProperly(workbench)
    TriggerServerEvent('crafting:removeCraftingTable')

    exports['qb-target']:AddTargetModel(GetHashKey('prop_tool_bench02'), {
        options = {
            {
                event = 'crafting:openMenu',
                icon = 'fas fa-tools',
                label = 'Crafting Menu'
            },
            {
                event = 'crafting:pickupWorkbench',
                icon = 'fas fa-hand-rock',
                label = 'Pick Up Workbench'
            }
        },
        distance = 2.5
    })
end)

RegisterNetEvent('crafting:pickupWorkbench', function()

    local playerPed = PlayerPedId()
    local propHash = GetHashKey('prop_tool_bench02')
    local entity = GetClosestObjectOfType(GetEntityCoords(playerPed), 3.0, propHash, false, false, false)

    if DoesEntityExist(entity) then
        DeleteEntity(entity)
        TriggerServerEvent('crafting:addCraftingTable')
        QBCore.Functions.Notify('You have picked up the workbench.', 'success')
    end
end)

RegisterNetEvent('crafting:openMenu', function()

    QBCore.Functions.TriggerCallback('crafting:getPlayerInventory', function(inventory)
        local craftableItems = {}
        local nonCraftableItems = {}

        for _, recipe in pairs(Config.Recipes) do
            local canCraft = true
            local itemsText = ''
            for _, reqItem in pairs(recipe.requiredItems) do
                local hasItem = false
                for _, invItem in pairs(inventory) do
                    if invItem.name == reqItem.item and invItem.amount >= reqItem.amount then
                        hasItem = true
                        break
                    end
                end
                local itemLabel = QBCore.Shared.Items[reqItem.item].label
                itemsText = itemsText .. ' x' .. tostring(reqItem.amount) .. ' ' .. itemLabel .. '<br>'
                if not hasItem then
                    canCraft = false
                end
            end
            itemsText = string.sub(itemsText, 1, -5)
            local menuItem = {
                header = QBCore.Shared.Items[recipe.item].label,
                txt = itemsText,
                icon = 'nui://qb-inventory/html/images/'..QBCore.Shared.Items[recipe.item].image,
                params = {
                    event = 'crafting:requestCraftAmount',
                    args = {
                        craftedItem = recipe.item,
                        requiredItems = recipe.requiredItems
                    }
                },
                disabled = not canCraft
            }
            if canCraft then
                table.insert(craftableItems, menuItem)
            else
                table.insert(nonCraftableItems, menuItem)
            end
        end

        local Craft = {
            {
                header = 'Crafting Menu',
                icon = 'fas fa-drafting-compass',
                isMenuHeader = true,
            }
        }
        for _, item in ipairs(craftableItems) do
            table.insert(Craft, item)
        end
        for _, item in ipairs(nonCraftableItems) do
            table.insert(Craft, item)
        end

        exports['qb-menu']:openMenu(Craft)
    end)
end)

RegisterNetEvent('crafting:requestCraftAmount', function(data)

    local dialog = exports['qb-input']:ShowInput({
        header = 'Enter Amount To Craft',
        submitText = 'Confirm',
        inputs = {
            {
                type = 'number',
                name = 'amount',
                label = 'Amount',
                text = 'Enter Amount',
                isRequired = true 
            },
        },
    })
    if dialog and tonumber(dialog.amount) then
        local amount = tonumber(dialog.amount)
        if amount > 0 then

            local multipliedItems = {}
            for _, reqItem in ipairs(data.requiredItems) do
                table.insert(multipliedItems, {
                    item = reqItem.item,
                    amount = reqItem.amount * amount
                })
            end
            TriggerEvent('crafting:craftItem', { craftedItem = data.craftedItem, requiredItems = multipliedItems, amountToCraft = amount })
        else
            QBCore.Functions.Notify('Invalid amount entered', 'error')
        end
    else
        QBCore.Functions.Notify('Invalid input', 'error')
    end
end)

RegisterNetEvent('crafting:craftItem', function(data)

    QBCore.Functions.TriggerCallback('crafting:getPlayerInventory', function(inventory)
        local craftedItem = data.craftedItem
        local requiredItems = data.requiredItems
        local amountToCraft = data.amountToCraft
        local hasAllMaterials = true

        for _, reqItem in pairs(requiredItems) do
            local itemAmount = 0
            for _, invItem in pairs(inventory) do
                if invItem.name == reqItem.item then
                    itemAmount = invItem.amount
                    break
                end
            end
            if itemAmount < reqItem.amount then
                hasAllMaterials = false
                QBCore.Functions.Notify('Not enough materials to craft ' .. amountToCraft .. 'x ' .. QBCore.Shared.Items[craftedItem].label, 'error')
                break
            end
        end

        if hasAllMaterials then
            local ped = PlayerPedId()
            QBCore.Functions.Progressbar('crafting_item', 'Crafting '..QBCore.Shared.Items[craftedItem].label, (math.random(2000, 5000) * amountToCraft), false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = 'mini@repair',
                anim = 'fixing_a_player',
                flags = 16,
            }, {}, {}, function() -- Done
                StopAnimTask(ped, 'mini@repair', 'fixing_a_player', 1.0)
                TriggerServerEvent('crafting:receiveItem', craftedItem, requiredItems, amountToCraft)
            end, function() -- Cancel
                StopAnimTask(ped, 'mini@repair', 'fixing_a_player', 1.0)
                QBCore.Functions.Notify('Crafting cancelled', 'error')
            end)
        else
            QBCore.Functions.Notify('Not enough materials', 'error')
        end
    end)
end)