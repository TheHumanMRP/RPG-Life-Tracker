# Overall
---
- [ ] Add transitions when changing scenes


# Death Menu
---
- [ ] Add the main menu button functionality


# Equipment Manager
---
- [ ] Make the equipment manager handle equipment of sword
 
# Task Manager
---
- [ ] Make the `Task` class
- [ ] Make the `TaskManager` with the following funcs:
    - [ ] `add_task`
    - [ ] `remove_task`
    - [ ] `rename_task`

# Completed Tasks
---
- [X] Refactor the hotbar to handle selection and equipment of item
    - [X] Make it a new equip item func in it
        - [X] Make a new equip item input
    
        - [X] Make the func emit a new equip item signal when equipped
            - [X] Refactor the equipment manager (go to the todo block)
    
        - [X] Remove that item from the hotbar list

    - [X] Make it update the opacity when selected

- [X] Refactor the equipment manager
    - [X] Make selection and equip management separate