- Add below code to `ox_inventory/data/items.lua`
```lua
['tracker'] = {
	label = 'Tracker',
	description = "The app that lets you track the whereabouts of your fellow mates.",
	weight = 100,
	client = {
		remove = function(total)
			if total < 1 then
				TriggerServerEvent('cad-jobblips:removePlayer')
			end
		end
	},
	server = {
		export = 'cad-jobblips.useTracker'
	}
},
```

- Add `tracker.png` to `ox_inventory/web/images`