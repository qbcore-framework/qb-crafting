local Translations = {
    menus = {
        header = 'Crafting Menü',
        pickupworkBench = 'Werkbank aufnehmen',
        entercraftAmount = 'Menge zum Craften eingeben:',
    },
    notifications = {
        pickupBench = 'Du hast die Werkbank aufgenommen.',
        invalidAmount = 'Ungültige Menge eingegeben',
        invalidInput = 'Ungültige Eingabe',
        notenoughMaterials = 'Du hast nicht genug Materialien!',
        craftingCancelled = 'Du hast das Craften abgebrochen',
        tablePlace = 'Dein Crafting-Tisch wurde platziert',
        craftMessage = 'Du hast ein %s gefertigt',
        xpGain = 'Du hast %d XP in %s gewonnen',
    }
}

if GetConvar('qb_locale', 'en') == 'de' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
