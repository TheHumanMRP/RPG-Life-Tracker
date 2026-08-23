# Equipment Manager
---

- [ ] Make the equipment manager handle equipment of sword
	- [ ] Add the sword scene to the equipment manager scene

	- [ ] Make it show the sword and set it's values when equipped and hide it when it's unequipped


- [ ] Setup the sword scene
	- [X] Add all the sword parameters to the sword scene
	- [ ] Make a sword scene init func
		- [ ] It takes task entry as an input
		- [ ] Checks all the values and raises errors
		- [ ] Then sets the values of the scene

	- [ ] Make the sword scene hide func

	- [ ] Make the sword scene show func


- [ ] Handle the unequipment of gear
	- [ ] Add 5 more slots to the hotbar
		- [ ] Display all the armor and weapon there

		- [ ] Figure out how to travel to all that 

# Task Manager
---
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