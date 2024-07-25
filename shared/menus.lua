local MenuType = Config.CoreSettings.Menu.Type


local TableMenuLean = {
    {
        header = "Make Lean",
        isMenuHeader = true,
    },  
    {   
        header = "🥤 Make Cup of Lean",
        txt = "Ingredients Required: <br> 1x Codeine Promethazine <br> 1x Pack of Sweets <br> 1x Bottle of Fizzy Drink <br> 1x Plastic Cup",
        params = {
            event = "lusty94_lean:client:MakeLean",
        }
    },
    {
        header = "X Close",
        txt = "",
        params = {
            event = "qb-menu:closeMenu",
        }
    },
}



lib.registerContext({
    id = 'TableMenuLean',
    title = 'Make Lean',
    options = {                           
        {
            title = '🥤 Make Cup of Lean',
            description = 'Ingredients Required: \n 1x Codeine Promethazine \n 1x Pack of Sweets \n 1x Bottle of Fizzy Drink \n 1x Plastic Cup',
            event = 'lusty94_lean:client:MakeLean',
            arrow = true,
        },            
    }
})


--main menu
RegisterNetEvent('lusty94_lean:client:LeanMenu', function(data)
    if MenuType == 'qb' then
        exports['qb-menu']:openMenu(TableMenuLean)
    elseif MenuType == 'jixel' then
        exports['jixel-menu']:openMenu(TableMenuLean)
    elseif MenuType == 'ox' then
        lib.showContext('TableMenuLean')
    elseif MenuType == 'custom' then
        --INSERT YOUR CUSTOM MENU CODE HERE
    end
end)