# All-Tasks

# To-Do
---


- [ ] Make 


- [ ] Make animations for sword attack
- [ ] Code sword attack animation playing

- [ ] Impliment the right click menu option handlings
	- [X] For Main Menu
	- [ ] For task Manager

- [ ] Make the add task name input
- [ ] Make the main menu quit right click menu option ask for conformation

- [ ] Make the input menu for taking text inputs
- [ ] Make the input menu for conformations

- [ ] Make pixel art for the UI

- [ ] Impliment swapping of gear, so that when I equip a gear which is already occupied, it swaps instead of disgarding

- [ ] Handle the unequipment of gear
	- [ ] Add 5 more slots to the hotbar
		- [ ] Display all the armor and weapon there

		- [ ] Figure out how to travel to all those slots

- [ ] Fix the loop because of which there are hundreds of statement being printed every single time I equip an item 
- [ ] Make it so that it checks if none of the hotbar slots have the item to put in a slot, cause that will cause duplication

- [ ] Make esc menu

- [ ] Add transitions when changing scenes

# Completed Tasks
---

- [X] Make the bg scene
	- [X] Make it intercept the mouse click and summom right click menu

- [X] Add a right click menu
	- [X] Make the signal bus signals
	- [X] Impliment popping up of options
		- [X] Make it accept a list of string which it adds to the menu

- [X] Make animations for player movement
- [X] Code movement animations playing for player

- [X] Make the basic ui for task manager with godot nodes
	- [X] Compelte the task grid
	- [X] Link the backend and the frontend

- [X] Handle changing of task status in task entry scene

- [X] Check if the task entry option button is working properly with a dict

- [X] Make pixel art for sword

- [X] Handle the resolution setting
	- Setting up so that my game renders in lower resolution and gets scaled up
	- Took me about ~3 hours

- [X] Start adding some pixel art
- [X] In level set up the spawning of:
	- [X] UILayer
	- [X] Inventory_UI_Layer
	- [X] DeathMenu

	- in a call_deffered func 

	- cause they are currently loading before _ready of level runs so the managers aren't loaded in yet and the hotbar causes a scene 

- [X] Combine all the managers in groups
- [X] Make a var for each one of them
- [X] Make a new var that handles the game state
- [X] Make a new func that handles the loading and unloading of those manager group vars

- [X] Make the `Task` class
- [X] Make the `TaskManager`
	- [X] Make the task status handling
	- [X] Make proper max id handling, with reference to all global inventory manager
	- [X] make the func `add_task`
	- [X] make the func `remove_task`
	- [X] make the func `rename_task`
	- [X] make the func `clear_all_tasks`

- [X] Check if rotation sword 180 degrees makes it upside down, if yes, fix it

- [X] Make the sword point towards the player's direction

- [X] Fix the bug where the hotbar slots aren't getting the proper item_id
	- LOL, there was no bug, it was just trash testing code

	- IDK the prob, but when testing, it's setting the slots properly, but after that when the system grabs it for setting the slots id, it just defaults to the default -1 list
	
	- The bug is that the hotbar is not updating, the item is there, but the hotbar is not updating properly

	- [X] Try putting the item in diff slots and testing like that

- [X] Fix the bug where the sword doesn't show up when equipped through hotbar slot

- [X] Make the equipment manager handle equipment of sword
	- [X] Add the sword scene to the equipment manager scene

	- [X] Make it show the sword and set it's values when equipped and hide it when it's unequipped

- [X] Setup the sword scene
	- [X] Add all the sword parameters to the sword scene
	- [X] Make a sword scene init func
		- [X] It takes item entry as an input
		- [X] Checks all the values and raises errors
		- [X] Then sets the values of the scene

- [X] Add the main menu button functionality

- [X] Refactor the hotbar to handle selection and equipment of item
    - [X] Make it a new equip item func in it
	- [X] Make a new equip item input
    
	- [X] Make the func emit a new equip item signal when equipped
	    - [X] Refactor the equipment manager (go to the todo block)
    
	- [X] Remove that item from the hotbar list

    - [X] Make it update the opacity when selected

- [X] Refactor the equipment manager
    - [X] Make selection and equip management separate