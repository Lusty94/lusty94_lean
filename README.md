## Lusty94_Lean


<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

PLEASE MAKE SURE TO READ THIS ENTIRE FILE AS IT COVERS SOME IMPORTANT INFORMATION

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



======================================
SCRIPT SUPPORT VIA DISCORD: https://discord.gg/BJGFrThmA8
======================================



## Features

- Speak with a gang members to get information about a supply shipment
- Intercept the shipment and get items required to process lean
- Search the driver and the passenger to get items
- Configurable chance to call the cops and required amount to start
- Random spawn locations for start ped
- Random spawn locations for the shipment delivery
- Random delivery locations for shipment
- Drink lean to get effects
- Useable plastic cup to open lean processing menu



## DEPENDENCIES

- [qb-core](https://github.com/qbcore-framework/qb-core)
- [qb-target](https://github.com/qbcore-framework/qb-target)
- [qb-inventory](https://github.com/qbcore-framework/qb-inventory)
- [qb-phone](https://github.com/qbcore-framework/qb-phone)
- [ox_lib](https://github.com/overextended/ox_lib/releases/)






## INSTALLATION

- Add the ##ITEMS snippet below into your core/shared/items.lua file
- Add all .png images inside [images] folder into your inventory/html/images folder - ox_inventory users place images inside inventory/web/images
- Add your own methods of obtaining sweets, fizzy drink and the plastic cup, maybe to a general store?



## LEAN XP
If you are using the inbuilt XP system then you must add the metadata lines below to your player.lua file in core
- new qb method is via the config but you might need to edit how metadata is assigned in server files

- look for the lines that are similair for the hunger and thirst  and stress or other xp types etc
- do not forget to edit this if you have changed your `MetaDataName` inside `config.lua`

```

#old core

PlayerData.metadata['leanxp'] = PlayerData.metadata['leanxp'] or 0 -- Added for lusty94_LEAN

#new core

leanxp = 0,

```



## QB-CORE ITEMS

```


    --LEAN
    codeinepromethazine     = {name ='codeinepromethazine',     label ='Codeine Promethazine',  weight = 500, type = 'item', image ='codeinepromethazine.png',   unique = false, useable = true, shouldClose = true, combinable = nil, description =''},
    sweets                  = {name ='sweets',                  label ='Pack of Sweets',        weight = 500, type = 'item', image ='sweets.png',                unique = false, useable = true, shouldClose = true, combinable = nil, description =''},
    fizzydrink              = {name ='fizzydrink',              label ='Bottle of Fizzy Drink', weight = 500, type = 'item', image ='fizzydrink.png',            unique = false, useable = true, shouldClose = true, combinable = nil, description =''},
    plasticcup              = {name = 'plasticcup',             label = 'Plastic Cup',          weight = 100, type = 'item', image = 'plasticcup.png',           unique = false, useable = true, shouldClose = true, combinable = nil, description = ''},
    leancup                 = {name = 'leancup',                label = 'Cup of Lean',          weight = 100, type = 'item', image = 'leancup.png',              unique = false, useable = true, shouldClose = true, combinable = nil, description = ''},


```


## OX_INVENTORY ITEMS

```


	["plasticcup"] = {
		label = "Plastic Cup",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "plasticcup.png",
		}
	},

	["sweets"] = {
		label = "Pack of Sweets",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "sweets.png",
		}
	},

	["leancup"] = {
		label = "Cup of Lean",
		weight = 100,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "leancup.png",
		}
	},

	["codeinepromethazine"] = {
		label = "Codeine Promethazine",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "codeinepromethazine.png",
		}
	},

	["fizzydrink"] = {
		label = "Bottle of Fizzy Drink",
		weight = 500,
		stack = true,
		close = true,
		description = "",
		client = {
			image = "fizzydrink.png",
		}
	},


```