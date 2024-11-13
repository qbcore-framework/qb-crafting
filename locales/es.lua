local Translations = {
    menus = {
        header = 'Menú de crafteo',
        pickupworkBench = 'Agarrar banco de trabajo',
        entercraftAmount = 'Ingrese la cantidad:',
    },
    notifications = {
        pickupBench = 'Has recogido el banco de trabajo.',
        invalidAmount = 'El monto ingresado no es valido.',
        invalidInput = 'La entrada no es válida.',
        notenoughMaterials = "¡No tienes suficientes materiales!",
        craftingCancelled = 'Crafteo cancelado.',
        tablePlace = 'Su mesa de trabajo fue colocada.',
        craftMessage = 'Ha creado un %s',
        xpGain = 'Has ganado %d XP en %s',
    }
}

if GetConvar('qb_locale', 'en') == 'es' then
    Lang = Locale:new({
        phrases = Translations,
        warnOnMissing = true,
        fallbackLang = Lang,
    })
end
