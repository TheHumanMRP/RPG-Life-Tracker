# All-Tasks

# To-Do
---

- [[Bugs]]
- [[Task-Manager]]
- [[Hotbar]]
- [[Equipment]]
- [[UI]]
- [[Overall]]

# Completed Tasks
---

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