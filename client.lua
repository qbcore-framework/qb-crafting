local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('player:useCraftingTable')
AddEventHandler('player:useCraftingTable', function()
    local playerPed = PlayerPedId()
    local coordsP = GetOffsetFromEntityInWorldCoords(playerPed,0.0,1.0,1.0)
    local playerHeading = GetEntityHeading(PlayerPedId())
    local itemHeading = playerHeading - 90
    local workbench = CreateObject(GetHashKey("prop_tool_bench02"), coordsP, true, true, true)

    if itemHeading < 0 then itemHeading = 360 + itemHeading end
    SetEntityHeading(workbench, itemHeading)
    PlaceObjectOnGroundProperly(workbench)
    TriggerServerEvent('crafting:removeCraftingTable')

    exports['qb-target']:AddTargetModel(GetHashKey("prop_tool_bench02"), {
        options = {
            {
                event = "crafting:openMenu",
                icon = "fas fa-tools",
                label = "Crafting Menu"
            },
            {
                event = "crafting:pickupWorkbench",
                icon = "fas fa-hand-rock",
                label = "Pick Up Workbench"
            }
        },
        distance = 2.5
    })
end)

RegisterNetEvent('crafting:pickupWorkbench')
AddEventHandler('crafting:pickupWorkbench', function()
    local playerPed = PlayerPedId()
    local propHash = GetHashKey("prop_tool_bench02")
    local entity = GetClosestObjectOfType(GetEntityCoords(playerPed), 3.0, propHash, false, false, false)

    if DoesEntityExist(entity) then
        DeleteEntity(entity)
        TriggerServerEvent('crafting:addCraftingTable')
        QBCore.Functions.Notify("You have picked up the workbench.", "success")
    else
        QBCore.Functions.Notify("No workbench nearby to pick up.", "error")
    end
end)

RegisterNetEvent('crafting:openMenu')
AddEventHandler('crafting:openMenu', function()
    QBCore.Functions.TriggerCallback('crafting:getPlayerInventory', function(inventory)
        local Craft = {
            {
                header = 'Crafting Menu',
                icon = 'fas fa-drafting-compass',
                isMenuHeader = true,
            }
        }
        for _, recipe in pairs(Config.Recipes) do
            local canCraft = true
            local itemsText = ""
            for _, reqItem in pairs(recipe.requiredItems) do
                local hasItem = false
                for _, invItem in pairs(inventory) do
                    if invItem.name == reqItem.item and invItem.amount >= reqItem.amount then
                        hasItem = true
                        break
                    end
                end
                local itemLabel = QBCore.Shared.Items[reqItem.item].label
                itemsText = itemsText .." x" .. tostring(reqItem.amount).." ".. itemLabel .. "<br>"
                print(itemsText)
                if not hasItem then
                    canCraft = false
                end
            end
            itemsText = string.sub(itemsText, 1, -5)
            Craft[#Craft + 1] = {
                header = QBCore.Shared.Items[recipe.item].label,
                txt = itemsText,
                icon = "nui://qb-inventory/html/images/"..recipe.item..".png",
                params = {
                    event = "crafting:craftItem",
                    args = {
                        craftedItem = recipe.item,
                        requiredItems = recipe.requiredItems
                    }
                },
                disabled = not canCraft
            }
        end
        exports['qb-menu']:openMenu(Craft)
    end)
end)

RegisterNetEvent('crafting:craftItem')
AddEventHandler('crafting:craftItem', function(data)
    local craftedItem = data.craftedItem
    local requiredItems = data.requiredItems
    local ped = PlayerPedId()
    for _,reqitems in pairs(requiredItems) do
        QBCore.Functions.Progressbar('crafting_item', 'Crafting '..QBCore.Shared.Items[craftedItem].label, (math.random(2000, 5000) * reqitems.amount), false, true, {
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
            TriggerServerEvent('crafting:receiveItem', craftedItem,requiredItems)
        end, function() -- Cancel
            StopAnimTask(ped, 'mini@repair', 'fixing_a_player', 1.0)
            QBCore.Functions.Notify("Failed", 'error')
        end)
    end
end)