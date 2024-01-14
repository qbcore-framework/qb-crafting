Config = {

    TableObject = `prop_tool_bench02`,

    Recipes = {
        {
            item = 'lockpick',
            requiredItems = {
                { item = 'metalscrap', amount = 1 },
                { item = 'plastic',    amount = 1 }
            }
        },
        {
            item = 'screwdriverset',
            requiredItems = {
                { item = 'metalscrap', amount = 1 },
                { item = 'plastic',    amount = 1 }
            }
        },
        {
            item = 'electronickit',
            requiredItems = {
                { item = 'metalscrap', amount = 1 },
                { item = 'plastic',    amount = 1 },
                { item = 'aluminum',   amount = 1 }
            }
        },
        {
            item = 'radioscanner',
            requiredItems = {
                { item = 'electronickit', amount = 1 },
                { item = 'plastic',       amount = 1 },
                { item = 'steel',         amount = 1 }
            }
        },
        {
            item = 'gatecrack',
            requiredItems = {
                { item = 'metalscrap',    amount = 1 },
                { item = 'plastic',       amount = 1 },
                { item = 'aluminum',      amount = 1 },
                { item = 'iron',          amount = 1 },
                { item = 'electronickit', amount = 1 }
            }
        },
        {
            item = 'handcuffs',
            requiredItems = {
                { item = 'metalscrap', amount = 1 },
                { item = 'steel',      amount = 1 },
                { item = 'aluminum',   amount = 1 }
            }
        },
        {
            item = 'repairkit',
            requiredItems = {
                { item = 'metalscrap', amount = 1 },
                { item = 'steel',      amount = 1 },
                { item = 'plastic',    amount = 1 }
            }
        },
        {
            item = 'pistol_ammo',
            requiredItems = {
                { item = 'metalscrap', amount = 1 },
                { item = 'steel',      amount = 1 },
                { item = 'copper',     amount = 1 }
            }
        },
        {
            item = 'ironoxide',
            requiredItems = {
                { item = 'iron',  amount = 1 },
                { item = 'glass', amount = 1 }
            }
        },
        {
            item = 'aluminumoxide',
            requiredItems = {
                { item = 'aluminum', amount = 1 },
                { item = 'glass',    amount = 1 }
            }
        },
        {
            item = 'armor',
            requiredItems = {
                { item = 'iron',     amount = 1 },
                { item = 'steel',    amount = 1 },
                { item = 'plastic',  amount = 1 },
                { item = 'aluminum', amount = 1 }
            }
        },
        {
            item = 'drill',
            requiredItems = {
                { item = 'iron',             amount = 1 },
                { item = 'steel',            amount = 1 },
                { item = 'screwdriverset',   amount = 1 },
                { item = 'advancedlockpick', amount = 1 }
            }
        },
        -- Add more recipes as needed
    }
}
