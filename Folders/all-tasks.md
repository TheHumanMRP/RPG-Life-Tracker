- [X] Fix the bug where the sword doesn't show up when equipped through hotbar slot

- [ ] Handle the unequipment of gear
	- [ ] Add 5 more slots to the hotbar
		- [ ] Display all the armor and weapon there

		- [ ] Figure out how to travel to all that 

- [ ] Make the `Task` class
- [ ] Make the `TaskManager` with the following funcs:
    - [ ] `add_task`
    - [ ] `remove_task`
    - [ ] `rename_task`


# Overall
---
- [ ] Add transitions when changing scenes
- [ ] Start adding some pixel art


# Completed Tasks
---

## Equipment Manager
- [X] Make the equipment manager handle equipment of sword
	- [X] Add the sword scene to the equipment manager scene

	- [X] Make it show the sword and set it's values when equipped and hide it when it's unequipped

## Sword Scene
- [X] Setup the sword scene
	- [X] Add all the sword parameters to the sword scene
	- [X] Make a sword scene init func
		- [X] It takes item entry as an input
		- [X] Checks all the values and raises errors
		- [X] Then sets the values of the scene

## Death Menu
- [X] Add the main menu button functionality

## Hotbar Slots
- [X] Refactor the hotbar to handle selection and equipment of item
    - [X] Make it a new equip item func in it
        - [X] Make a new equip item input
    
        - [X] Make the func emit a new equip item signal when equipped
            - [X] Refactor the equipment manager (go to the todo block)
    
        - [X] Remove that item from the hotbar list

    - [X] Make it update the opacity when selected

## Equipment Manager
- [X] Refactor the equipment manager
    - [X] Make selection and equip management separate