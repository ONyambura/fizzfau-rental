Config = {
    ESXBilling = false, -- let it false if you dont know what are you doing
    Fee = 300, -- per hour
    Locations = {
        ["South Side Rental"] = {
            coords = {
                rent = vector3(-42.0448, -1676.37, 29.422),
                spawn = vector3(-28.1626, -1678.68, 29.480),
                heading = 100.0 
            },
            Vehicles = {
                {name = "blista",label = "Blista", price = 100, max_time = 6 --[[ hours ]]}, --max time means, if you reach the max time with rented car you need to pay fine
                {name = "asea",label = "Asea", price = 200, max_time = 6 --[[ hours ]]},
                {name = "intruder",label = "Intruder", price = 300, max_time = 6 --[[ hours ]]},
                {name = "ratbike",label = "Rat Bike", price = 400, max_time = 6 --[[ hours ]]},
                {name = "ruiner",label = "Ruiner", price = 500, max_time = 6 --[[ hours ]]},
                {name = "sultan",label = "Sultan", price = 500, max_time = 6 --[[ hours ]]},
                {name = "slamvan",label = "Slamvan", price = 650, max_time = 6 --[[ hours ]]},
                {name = "virgo",label = "Virgo", price = 100, max_time = 6 --[[ hours ]]},
                {name = "fugitive",label = "Fugitive", price = 1000, max_time = 6 --[[ hours  ]]},
            }
        },
    }
}
