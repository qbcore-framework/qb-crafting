local Translations = {
    menus = {
        header = 'Crafting Menu',
        entercraftAmount = 'Zadejte počet:',
    },
    notifications = {
        pickupBench = 'Zvedl si workbench.',
        invalidAmount = 'Špatný počet zadán',
        invalidInput = 'Zadán neplatný vstup',
        notenoughMaterials = "Nemáš dostatek materiálů!",
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
