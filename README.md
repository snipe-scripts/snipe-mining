# Mining Resource

# Discord - https://discord.gg/VGYkkAYVv2

# Features
- You can have multiple mines
- You can configure if each person can mine one location just once or unlimited times
- Configure the chances of getting items
- Configure the items that can be obtained
- Configure the time it takes to mine
- and many more..

# Dependencies
- QBCore/ESX
- ox_lib (https://github.com/overextended/ox_lib/releases/download/v3.6.2/ox_lib.zip)
- snipe-aimgame (https://github.com/snipe-scripts/snipe-aimgame)

# Items
## QBCore

```lua
	['pickaxe'] 					 = {['name'] = 'pickaxe', 			  	  	  	['label'] = 'Pickaxe', 					['weight'] = 100, 		['type'] = 'item', 		['image'] = 'pickaxe.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'RECYCLE! - Greta Thunberg 2019'},
	['stone'] 					 = {['name'] = 'stone', 			  	  	  	['label'] = 'Stone', 					['weight'] = 100, 		['type'] = 'item', 		['image'] = 'stone.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'RECYCLE! - Greta Thunberg 2019'},
	['diamond'] 					 = {['name'] = 'diamond', 			  	  	  	['label'] = 'Diamond', 					['weight'] = 100, 		['type'] = 'item', 		['image'] = 'diamond.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'RECYCLE! - Greta Thunberg 2019'},
	['ruby'] 					 = {['name'] = 'ruby', 			  	  	  	['label'] = 'Ruby', 					['weight'] = 100, 		['type'] = 'item', 		['image'] = 'ruby.png', 				['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'RECYCLE! - Greta Thunberg 2019'},
```

## ESX

```sql
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('pickaxe', 'Pickaxe', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('stone', 'Stone', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('diamond', 'Diamond', 1, 0, 1);
INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES ('ruby', 'Ruby', 1, 0, 1);
```