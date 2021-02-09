ESX = nil
VehiclesRented = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("fizzfau-rental:rent")
AddEventHandler("fizzfau-rental:rent", function(k, v, plate, store)
    local player = ESX.GetPlayerFromId(source)
    local identifier = player.identifier
    if VehiclesRented[identifier] == nil then
        VehiclesRented[identifier] = {
            plate = plate,
            time = os.time(),
            max_time = v.max_time * 60 * 60 * 1000,
            price = v.price,
            store = store
        }
        TriggerClientEvent("fizzfau-rental:spawnVehicle", source, k, v, plate)
        TriggerEvent("fizzfau-rental:startCounter", player)
    else
        TriggerClientEvent("notification", source, "You have already rented a car!")
    end
end)

RegisterServerEvent("fizzfau-rental:giveback")
AddEventHandler("fizzfau-rental:giveback", function(health)
    local player = ESX.GetPlayerFromId(source)
    local identifier = player.identifier
    if VehiclesRented[identifier] ~= nil then
        TriggerClientEvent("fizzfau-rental:delete", source, VehiclesRented[identifier].vehicle)
        if health < 1000 then
            player.removeMoney(Config.Fee * (1000 - health)/100)
        elseif os.time() - VehiclesRented[identifier].time > VehiclesRented[identifier].max_time then
            player.removeMoney(Config.Fee * max_time)
        end
        VehiclesRented[identifier] = nil
    end
end)

RegisterServerEvent("fizzfau-rental:update")
AddEventHandler("fizzfau-rental:update", function(vehicle)
    local player = ESX.GetPlayerFromId(source)
    local identifier = player.identifier
    VehiclesRented[identifier].vehicle = vehicle
end)

RegisterServerEvent("fizzfau-rental:getVehicle")
AddEventHandler("fizzfau-rental:getVehicle", function()
    local player = ESX.GetPlayerFromId(source)
    local identifier = player.identifier
    if VehiclesRented[identifier] ~= nil then
        TriggerClientEvent("fizzfau-rental:client:getVehicle", source, VehiclesRented[identifier].vehicle)
    end
end)

RegisterServerEvent("fizzfau-rental:startCounter")
AddEventHandler("fizzfau-rental:startCounter", function(player)
    local identifier = player.identifier
    Citizen.CreateThread(function()
        while true do
            if VehiclesRented[identifier] ~= nil then
                if player then
                    local cash = player.getMoney()
                    local bank = player.getAccount("bank").money
                    if bank >= VehiclesRented[identifier].price then
                        player.removeAccountMoney("bank", VehiclesRented[identifier].price)
                    elseif cash >= VehiclesRented[identifier].price then
                        player.removeMoney(VehiclesRented[identifier].price)
                    else
                        if Config.ESXBilling then
                            TriggerEvent("esx_billing:sendBill", source, VehiclesRented[identifier].store, VehiclesRented[identifier].plate.. " - ", VehiclesRented[identifier].price)
                            TriggerEvent("notification", source, "Check your bills!")
                        end
                    end
                end
            else
                break
            end
            Citizen.Wait(60*60*1000)
        end
    end)
end)
