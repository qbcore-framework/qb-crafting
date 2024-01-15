Config = {
    item_bench = {
        object = `prop_tool_bench02`,
        xpType = 'craftingrep',
        recipes = {
            {
                item = 'lockpick',
                xpRequired = 0,
                xpGain = 10,
                requiredItems = {
                    { item = 'metalscrap', amount = 1 },
                    { item = 'plastic',    amount = 1 }
                }
            },
            {
                item = 'screwdriverset',
                xpRequired = 0,
                xpGain = 10,
                requiredItems = {
                    { item = 'metalscrap', amount = 1 },
                    { item = 'plastic',    amount = 1 }
                }
            },
            {
                item = 'electronickit',
                xpRequired = 20,
                xpGain = 10,
                requiredItems = {
                    { item = 'metalscrap', amount = 1 },
                    { item = 'plastic',    amount = 1 },
                    { item = 'aluminum',   amount = 1 }
                }
            },
            {
                item = 'radioscanner',
                xpRequired = 0,
                xpGain = 10,
                requiredItems = {
                    { item = 'electronickit', amount = 1 },
                    { item = 'plastic',       amount = 1 },
                    { item = 'steel',         amount = 1 }
                }
            },
            {
                item = 'gatecrack',
                xpRequired = 0,
                xpGain = 10,
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
                xpRequired = 0,
                xpGain = 10,
                requiredItems = {
                    { item = 'metalscrap', amount = 1 },
                    { item = 'steel',      amount = 1 },
                    { item = 'aluminum',   amount = 1 }
                }
            },
            {
                item = 'repairkit',
                xpRequired = 0,
                xpGain = 10,
                requiredItems = {
                    { item = 'metalscrap', amount = 1 },
                    { item = 'steel',      amount = 1 },
                    { item = 'plastic',    amount = 1 }
                }
            },
            {
                item = 'pistol_ammo',
                xpRequired = 0,
                xpGain = 10,
                requiredItems = {
                    { item = 'metalscrap', amount = 1 },
                    { item = 'steel',      amount = 1 },
                    { item = 'copper',     amount = 1 }
                }
            },
            {
                item = 'ironoxide',
                xpRequired = 0,
                xpGain = 10,
                requiredItems = {
                    { item = 'iron',  amount = 1 },
                    { item = 'glass', amount = 1 }
                }
            },
            {
                item = 'aluminumoxide',
                xpRequired = 0,
                xpGain = 10,
                requiredItems = {
                    { item = 'aluminum', amount = 1 },
                    { item = 'glass',    amount = 1 }
                }
            },
            {
                item = 'armor',
                xpRequired = 0,
                xpGain = 10,
                requiredItems = {
                    { item = 'iron',     amount = 1 },
                    { item = 'steel',    amount = 1 },
                    { item = 'plastic',  amount = 1 },
                    { item = 'aluminum', amount = 1 }
                }
            },
            {
                item = 'drill',
                xpRequired = 0,
                xpGain = 10,
                requiredItems = {
                    { item = 'iron',             amount = 1 },
                    { item = 'steel',            amount = 1 },
                    { item = 'screwdriverset',   amount = 1 },
                    { item = 'advancedlockpick', amount = 1 }
                }
            },
        }
    },
    attachment_bench = {
        object = `prop_tool_bench02_ld`,
        xpType = 'attachmentcraftingrep',
        recipes = {
            {
                item = 'clip_attachment',
                xpRequired = 0,
                xpGain = 10,
                requiredItems = {
                    { item = 'metalscrap', amount = 140 },
                    { item = 'steel',      amount = 250 },
                    { item = 'rubber',     amount = 60 }
                }
            },
            {
                item = 'suppressor_attachment',
                xpRequired = 0,
                xpGain = 10,
                requiredItems = {
                    { item = 'metalscrap', amount = 165 },
                    { item = 'steel',      amount = 285 },
                    { item = 'rubber',     amount = 75 }
                }
            },
            -- Add more recipes as needed
        }
    }
}
