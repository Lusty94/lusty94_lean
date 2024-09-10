
lib.registerContext({
    id = 'TableMenuLean',
    title = 'Make Lean',
    options = {                           
        {
            title = '🥤 Make Cup of Lean',
            description = 'Ingredients Required: \n 1x Codeine Promethazine \n 1x Pack of Sweets \n 1x Bottle of Fizzy Drink \n 1x Plastic Cup',
            event = 'lusty94_lean:client:MakeLean',
            arrow = true,
            icon = ItemImage('leancup'),
            image = ItemImage('leancup'),
        },            
    }
})



RegisterNetEvent('lusty94_lean:client:LeanMenu', function(data)
    lib.showContext('TableMenuLean')
end)