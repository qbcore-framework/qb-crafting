local Translations = {
    menus = {
        header = 'Crafting Menu',
        pickupworkBench = 'Zvednout Workbench',
        entercraftAmount = 'Zadejte počet:',
    },
    notifications = {
        pickupBench = 'Zvedl si workbench.',
        invalidAmount = 'Špatný počet zadán',
        invalidInput = 'Zadán neplatný vstup',
        notenoughMaterials = "Nemáš dostatek materiálů!",
        craftingCancelled = 'Přerušil si crafting',
        tablePlace = 'Tvůj Workbench byl položen',
        craftMessage = 'Vycraftil si %s',
        xpGain = 'Získal si %d XP z %s',
    }
}

if GetConvar('qb_locale', 'en') == 'cs' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end