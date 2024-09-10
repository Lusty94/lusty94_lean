local QBCore = exports['qb-core']:GetCoreObject()
local NotifyType = Config.CoreSettings.Notify.Type
local TargetType = Config.CoreSettings.Target.Type
local InvType = Config.CoreSettings.Inventory.Type
local busy, hasRequested = false, false


--notification function
local function SendNotify(msg,type,time,title)
    if NotifyType == nil then print("Lusty94_Lean: NotifyType Not Set in Config.CoreSettings.Notify.Type!") return end
    if not title then title = "Lean" end
    if not time then time = 5000 end
    if not type then type = 'success' end
    if not msg then print("Notification Sent With No Message.") return end
    if NotifyType == 'qb' then
        QBCore.Functions.Notify(msg,type,time)
    elseif NotifyType == 'okok' then
        exports['okokNotify']:Alert(title, msg, time, type, true)
    elseif NotifyType == 'mythic' then
        exports['mythic_notify']:DoHudText(type, msg)
    elseif NotifyType == 'boii' then
        exports['boii_ui']:notify(title, msg, type, time)
    elseif NotifyType == 'ox' then
        lib.notify({ title = title, description = msg, type = type, duration = time})
    end
end

--police alert
local function alertPolice()
    local PoliceType = Config.CoreSettings.Police.Type
	if PoliceType == 'qb' then
		TriggerServerEvent('police:server:policeAlert', 'Suspicious Activity Reported')
	elseif PoliceType == 'ps' then
		exports['ps-dispatch']:SuspiciousActivity()
	elseif PoliceType == 'custom' then
		--insert your own code for police notifications here
	end
end



-- mission start ped
CreateThread(function()
    local ped = 'g_m_y_lost_02' -- change ped model here
    lib.requestModel(ped, 5000)
    local coords = Config.InteractionLocations.StartPedLocations[math.random(1, #Config.InteractionLocations.StartPedLocations)]
    leanStartPed = CreatePed(0, ped, coords, true, false)
    FreezeEntityPosition(leanStartPed, true)
    SetEntityInvincible(leanStartPed, true)
    SetBlockingOfNonTemporaryEvents(leanStartPed, true)
    TaskStartScenarioInPlace(leanStartPed, 'WORLD_HUMAN_SMOKING', true)
    if TargetType == 'qb' then
		exports['qb-target']:AddTargetEntity(leanStartPed, { options = { { type = "client", event = "lusty94_lean:client:missionEmail", icon = 'fa-solid fa-users', label = 'Speak With Gang Member', } }, distance = 2.0 })
	elseif TargetType == 'ox' then
		exports.ox_target:addLocalEntity(leanStartPed, { { name = 'leanStartPed', icon = 'fa-solid fa-users', label = 'Speak With Gang Member', event = 'lusty94_lean:client:missionEmail', distance = 2.0}, })
	end
    startblip = AddBlipForCoord(coords)
    SetBlipSprite(startblip, 66)
    SetBlipDisplay(startblip, 4)
    SetBlipScale(startblip, 0.8)
    SetBlipColour(startblip, 3)
    SetBlipAsShortRange(startblip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('Gang Member')
    EndTextCommandSetBlipName(startblip)
end)



------------------< MISSION >-----------------

--search driver
function SearchDriver()
    if busy then
        SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
        return
    else
        local success = lib.skillCheck({'easy', 'easy', 'easy',}, {'e'})
        if success then
            busy = true
            LockInventory(true)
            if lib.progressCircle({ 
                duration = Config.CoreSettings.Timers.SearchBody, 
                label = Config.Language.ProgressBar.SearchBody, 
                position = 'bottom', 
                useWhileDead = false, 
                canCancel = true, 
                disable = { car = true, move = true, }, 
                anim = { dict = Config.Animations.SearchBody.dict, clip = Config.Animations.SearchBody.anim, flag = Config.Animations.SearchBody.flag, },
            }) then
                if TargetType == 'qb' then exports['qb-target']:RemoveTargetEntity(driver) elseif TargetType == 'ox' then exports.ox_target:removeLocalEntity(driver, 'driver') end
                busy = false
                vehiclespawned = false
                LockInventory(false)
                local chance = math.random(1,100) 
                local chance2 = Config.CoreSettings.Chances.SearchBody
                if chance <= chance2 then
                    TriggerServerEvent('lusty94_lean:server:SearchBody')
                else
                    SendNotify(Config.Language.Notifications.NothingFound, 'error', 2000)
                end	
                local policechance = math.random(1,100)
                local policechance2 = Config.CoreSettings.Chances.CallPolice
                if policechance <= policechance2 then
                    alertPolice()				
                end	
            else 
                busy = false
                LockInventory(false)
                SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
            end
        else
            busy = false
            SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
        end
    end
end

--search passenger
function SearchPassenger()
    if busy then
        SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
        return
    else
        local success = lib.skillCheck({'easy', 'easy', 'easy',}, {'e'})
        if success then
            busy = true
            LockInventory(true)
            if lib.progressCircle({ 
                duration = Config.CoreSettings.Timers.SearchBody, 
                label = Config.Language.ProgressBar.SearchBody, 
                position = 'bottom', 
                useWhileDead = false, 
                canCancel = true, 
                disable = { car = true, move = true, }, 
                anim = { dict = Config.Animations.SearchBody.dict, clip = Config.Animations.SearchBody.anim, flag = Config.Animations.SearchBody.flag},
            }) then
                if TargetType == 'qb' then exports['qb-target']:RemoveTargetEntity(passenger) elseif TargetType == 'ox' then exports.ox_target:removeLocalEntity(passenger, 'passenger') end
                busy = false
                vehiclespawned = false
                LockInventory(false)
                local chance = math.random(1,100) 
                local chance2 = Config.CoreSettings.Chances.SearchBody
                if chance <= chance2 then
                    TriggerServerEvent('lusty94_lean:server:SearchBody')
                else
                    SendNotify(Config.Language.Notifications.NothingFound, 'error', 2000)
                end	
                local policechance = math.random(1,100)
                local policechance2 = Config.CoreSettings.Chances.CallPolice
                if policechance <= policechance2 then
                    alertPolice()				
                end	
            else 
                busy = false
                LockInventory(false)
                SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
            end
        else
            busy = false
            SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
        end
    end
end


--spawn delivery vehicle
function spawnLeanVehicle()
    for k, v in pairs(Config.InteractionLocations.Vehicle) do
        if vehiclespawned then
            SendNotify(Config.Language.Notifications.VehicleAlreadySpawned, 'error', 2000)
        else
            lib.requestModel(v.model, 5000)					
			local location = Config.InteractionLocations.StartLocations[math.random(1, #Config.InteractionLocations.StartLocations)]
			local car = CreateVehicle(v.model, location.x, location.y, location.z, location.w, true, true)
            vehiclespawned = true
			SendNotify(Config.Language.Notifications.CheckGPS, 'success', 2000)
			local vehicleBlip = AddBlipForEntity(car)
            SetBlipSprite(vehicleBlip, 477)
            SetBlipColour(vehicleBlip, 5)
			SetBlipScale(vehicleBlip, 0.8)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("Marked Vehicle")
            lib.requestModel(v.drivermodel, 5000)			
            lib.requestModel(v.passengermodel, 5000)            			
            driver = CreatePed(26, v.drivermodel, location.x, location.y, location.z, location.w, true, false)
            passenger = CreatePed(26, v.passengermodel, location.x, location.y, location.z, location.w, true, false)
			SetVehicleDoorsLocked(car, 0)
            SetPedIntoVehicle(driver, car, -1)
            SetPedIntoVehicle(passenger, car, 0)
            SetPedFleeAttributes(driver, 0, 0)
            SetPedFleeAttributes(passenger, 0, 0)
            SetPedCombatAttributes(driver, 46, 1)
            SetPedCombatAttributes(passenger, 46, 1)
            SetPedCombatAbility(driver, 100)
            SetPedCombatAbility(passneger, 100)
            SetPedCombatMovement(driver, 2)
            SetPedCombatMovement(passenger, 2)
            SetPedCombatRange(driver, 2)
            SetPedCombatRange(passenger, 2)
            GiveWeaponToPed(driver, GetHashKey(v.driverweapon), 250, false, true)
            GiveWeaponToPed(passenger, GetHashKey(v.passengerweapon), 250, false, true)
            SetPedRelationshipGroupHash(driver, GetHashKey("HATES_PLAYER"))
            SetPedRelationshipGroupHash(passenger, GetHashKey("HATES_PLAYER"))
            TaskCombatPed(driver, PlayerPedId(), 0, 16)
            TaskCombatPed(passenger, PlayerPedId(), 0, 16)
            SetPedDropsWeaponsWhenDead(driver, false)
			SetPedDropsWeaponsWhenDead(passenger, false)
			local destination = Config.InteractionLocations.DestinationLocations[math.random(#Config.InteractionLocations.DestinationLocations)]
            TaskVehicleDriveToCoordLongrange(driver, car, destination.x, destination.y, destination.z, 35.0, 524340, 10.0)
            if TargetType == 'qb' then
                exports['qb-target']:AddTargetEntity(driver, { options = { { type = "client", action = function() SearchDriver() end, icon = v.targeticon, label = v.targetlabel, } }, distance = v.targetdistance })
                exports['qb-target']:AddTargetEntity(passenger, { options = { { type = "client", action = function() SearchPassenger() end, icon = v.targeticon, label = v.targetlabel, } }, distance = v.targetdistance })
            elseif TargetType == 'ox' then
                exports.ox_target:addLocalEntity(driver, { { name = 'driver', icon = v.targeticon, label = v.targetlabel, onSelect = function() SearchDriver() end, distance = v.targetdistance} })
                exports.ox_target:addLocalEntity(passenger, { { name = 'passenger', icon = v.targeticon, label = v.targetlabel, onSelect = function() SearchPassenger() end, distance = v.targetdistance} })
            end
			local destinationCoords = vector3(destination.x, destination.y, destination.z)
			local arrivalDistance = 50.0
			CreateThread(function()
				while true do
					Wait(1000) -- updates every second			
					-- Check if the driver and passenger are dead
					if DoesEntityExist(driver, passenger) and IsEntityDead(driver, passenger) then
						RemoveBlip(vehicleBlip)
						SetPedKeepTask(driver, false)
						SetPedKeepTask(passenger, false)
						SetModelAsNoLongerNeeded(driver)
						SetModelAsNoLongerNeeded(passenger)
						vehiclespawned = false
						break
					end			
					-- Check if the vehicle has arrived at its destination
					if HasVehicleArrived(car, destinationCoords, arrivalDistance) then
						RemoveBlip(vehicleBlip)
						DeleteVehicle(car)
						SetPedKeepTask(driver, false)
						SetPedKeepTask(passenger, false)
						SetModelAsNoLongerNeeded(driver)
						SetModelAsNoLongerNeeded(passenger)
						DeletePed(driver)
						DeletePed(passenger)
                        if TargetType == 'qb' then exports['qb-target']:RemoveTargetEntity(driver) elseif TargetType == 'ox' then exports.ox_target:removeLocalEntity(driver, 'driver') end
                        if TargetType == 'qb' then exports['qb-target']:RemoveTargetEntity(passenger) elseif TargetType == 'ox' then exports.ox_target:removeLocalEntity(passenger, 'passenger') end						
						vehiclespawned = false
						break
					end
				end
			end)
        end
    end
end


--check if vehicle has arrived at destination
function HasVehicleArrived(vehicle, destinationCoords, arrivalDistance)
    if DoesEntityExist(vehicle) then
        local vehicleCoords = GetEntityCoords(vehicle)
        local distance = #(vehicleCoords - destinationCoords)
        return IsVehicleStopped(vehicle) and distance <= arrivalDistance
    end
    return false
end




 --search timer function
function leanTimer()
    local timer =  Config.CoreSettings.Timers.RequestMission
    if hasRequested then
        return
    end
    hasRequested = true
    SetTimeout(timer, function()
        hasRequested = false
    end)
end

--accept supply mission
RegisterNetEvent('lusty94_lean:client:AcceptMission', function()
	if hasRequested then		
        SendNotify(Config.Language.Notifications.Wait, 'error', 2000)
		return
	else
		hasRequested = true
		spawnLeanVehicle()
		leanTimer()
	end
end)


--generate mission email
RegisterNetEvent('lusty94_lean:client:missionEmail', function()
    local PhoneType = Config.CoreSettings.Phone.Type
    QBCore.Functions.TriggerCallback('lusty94_lean:server:StartMission', function(canStart)
        if canStart then
            if hasRequested then		
				SendNotify(Config.Language.Notifications.Wait, 'error', 2000)
				return
            else
                local phoneItems = {
                    "phone", -- qb-phone
                    "black_phone", -- qs-smartphone
                    "blue_phone", -- qs-smartphone
                    "gold_phone", -- qs-smartphone
                    "red_phone", -- qs-smartphone
                    "green_phone", -- qs-smartphone
                    "greenlight_phone", -- qs-smartphone
                    "pink_phone", -- qs-smartphone
                    "white_phone", -- qs-smartphone
                    -- Add more phone items to the list if needed
                }                
                local hasCompatiblePhone = false                
                for _, phoneItemName in pairs(phoneItems) do
                    if QBCore.Functions.HasItem(phoneItemName) then
                        hasCompatiblePhone = true
                        break
                    end
                end    
                if hasCompatiblePhone then
                    SendNotify(Config.Language.Notifications.TextMessage, 'success', 2000)
                    Wait(15 * 1000) -- 15 seconds
                    if PhoneType == 'qb' then
                        TriggerServerEvent('qb-phone:server:sendNewMail', {
                            sender = 'Unknown Sender ',
                            subject = 'Supplies Mission',
                            message = 'Hey <br><br> I Overheard some useless gangsters talking shit about moving a shipment of supplies <br><br> I think they have something you might want.. <br><br> Check your GPS for a location <br><br> CAREFUL THEY MIGHT BE ARMED!!',
                            button = {
                                enabled = true,
                                buttonEvent = 'lusty94_lean:client:AcceptMission'
                            }
                        })
                    elseif PhoneType == 'qs' then
                        TriggerServerEvent('qs-smartphone:server:sendNewMail', {
                            sender = 'Unknown Sender',
                            subject = 'Supplies Mission',
                            message = 'Hey <br><br> I Overheard some useless gangsters talking shit about moving a shipment of supplies <br><br> I think they have something you might want.. <br><br> Check your GPS for a location <br><br> CAREFUL THEY MIGHT BE ARMED!!',
                            button = {
                                enabled = true,
                                buttonEvent = 'lusty94_lean:client:AcceptMission'
                            }
                        })
                    elseif PhoneType == 'custom' then
                        --INSERT YOUR OWN METHODS OF EMAIL FOR YOUR PHONE RESOURCE HERE
                    end
                else
                    SendNotify(Config.Language.Notifications.WrongPhone, 'error', 2000)
                end
            end
        end
    end)
end)
------------------------< CRAFTING LEAN >------------------------

--make lean
RegisterNetEvent('lusty94_lean:client:MakeLean', function()
    QBCore.Functions.TriggerCallback('lusty94_lean:get:LeanIngredients', function(hasItems)
        if hasItems then
            if busy then
                SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
            else
                local success = lib.skillCheck({'easy', 'easy', 'easy',}, {'e'})
                if success then
                    busy = true
                    LockInventory(true)
                    if lib.progressCircle({ 
                        duration = Config.CoreSettings.Timers.MixLean, 
                        label = Config.Language.ProgressBar.MixLean, 
                        position = 'bottom', 
                        useWhileDead = false, 
                        canCancel = true, 
                        disable = { car = true, move = true, }, 
                        anim = { dict = Config.Animations.MixLean.dict, clip = Config.Animations.MixLean.anim, flag = Config.Animations.MixLean.flag},
                        prop = { 
                            {model = Config.Animations.MixLean.prop1, bone = Config.Animations.MixLean.bone1, pos = Config.Animations.MixLean.pos1, rot = Config.Animations.MixLean.rot1,},
                            {model = Config.Animations.MixLean.prop2, bone = Config.Animations.MixLean.bone2, pos = Config.Animations.MixLean.pos2, rot = Config.Animations.MixLean.rot2,}, 
                        },
                    }) then
                        TriggerServerEvent('lusty94_lean:server:MakeLean')
                        busy = false
                        LockInventory(false)
                    else 
                        busy = false
                        LockInventory(false)
                        SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                    end
                else
                    busy = false
                    LockInventory(false)
                    SendNotify(Config.Language.Notifications.Failed, 'error', 2000)
                end
            end
        end
    end)
end)


------------------< DRINKING LEAN >------------------

function leanEffect()
    local playerPed = PlayerPedId()
    local StressEvent = Config.CoreSettings.EventNames.Stress
    Wait(2000)
    SetTimecycleModifier('spectator9')
    SetPedMotionBlur(playerPed, true) 
    TriggerServerEvent(StressEvent, math.random(20,30))
    AddArmourToPed(playerPed, math.random(20,30))   
    Wait(30 * 1000) -- 30 seconds
    ClearTimecycleModifier()
    SetPedMotionBlur(playerPed, false)
end

--drink lean
RegisterNetEvent('lusty94_lean:client:DrinkLean', function()
    QBCore.Functions.TriggerCallback('lusty94_lean:get:Lean', function(hasItems)
        if hasItems then
            if busy then
                SendNotify(Config.Language.Notifications.Busy, 'error', 2000)
            else
                busy = true
                LockInventory(true)
                if lib.progressCircle({ 
                    duration = Config.CoreSettings.Timers.DrinkLean, 
                    label = Config.Language.ProgressBar.DrinkLean, 
                    position = 'bottom', 
                    useWhileDead = false, 
                    canCancel = true, 
                    disable = { car = true, move = false,}, 
                    anim = { dict = Config.Animations.DrinkLean.dict, clip = Config.Animations.DrinkLean.anim, flag = Config.Animations.DrinkLean.flag},
                    prop = { model = Config.Animations.DrinkLean.prop1, bone = Config.Animations.DrinkLean.bone1, pos = Config.Animations.DrinkLean.pos1, rot = Config.Animations.DrinkLean.rot1, },
                }) then
                    TriggerServerEvent('lusty94_lean:server:DrinkLean')
                    busy = false
                    LockInventory(false)                    
                    leanEffect()
                else 
                    busy = false
                    LockInventory(false)
                    SendNotify(Config.Language.Notifications.Cancelled, 'error', 2000)
                end
            end
        end
    end)
end)


------------------< DONT TOUCH >----------

-- function to lock inventory to prevent exploits
function LockInventory(toggle) -- big up to jim for how to do this
	if toggle then
        LocalPlayer.state:set("inv_busy", true, true) -- used by qb, ps and ox

        --this is the old method below uncomment if needed
        --[[         
        if InvType == 'qb' then
            this is for the old method if using old qb and ox
            TriggerEvent('inventory:client:busy:status', true) TriggerEvent('canUseInventoryAndHotbar:toggle', false)
        elseif InvType == 'ox' then
            LocalPlayer.state:set("inv_busy", true, true)
        end         
        ]]
    else 
        LocalPlayer.state:set("inv_busy", false, true) -- used by qb, ps and ox

        --this is the old method below uncomment if needed
        --[[        
        if InvType == 'qb' then
            this is for the old method if using old qb and ox
         TriggerEvent('inventory:client:busy:status', false) TriggerEvent('canUseInventoryAndHotbar:toggle', true)
        elseif InvType == 'ox' then
            LocalPlayer.state:set("inv_busy", false, true)
        end        
        ]]
    end
end

--function to display item images for ox_lib menu
function ItemImage(img)
	if InvType == 'ox' then
		return "nui://ox_inventory/web/images/".. img.. '.png'
	elseif InvType == 'qb' then
		return "nui://qb-inventory/html/images/".. QBCore.Shared.Items[img].image
	end
end

--dont touch
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
        busy = false
        LockInventory(false) 
        if TargetType == 'qb' then exports['qb-target']:RemoveTargetEntity(leanStartPed, 'leanStartPed') elseif TargetType == 'ox' then exports.ox_target:removeLocalEntity(leanStartPed, 'leanStartPed') end  
        DeletePed(leanStartPed)
        print('^5--<^3!^5>-- ^7| Lusty94 |^5 ^5--<^3!^5>--^7 Lean V1.0.1 Stopped Successfully ^5--<^3!^5>--^7')
    end
end)