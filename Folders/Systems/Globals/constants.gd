extends Node

# Hotbar
const NUMBER_OF_HOTBAR_SLOTS: int = 9

const UNSELECTED_HOTBAR_SLOT_OPACITY: float = 0.0
const SELECTED_HOTBAR_SLOT_OPACITY: float = 0.5

# Main Menu
const MAIN_MENU_LABEL_TEXT: String = "Main Menu"
const MAIN_MENU_DUNGOEN_BUTTON_TEXT: String = "Dungeon"
const MAIN_MENU_TASK_MANAGER_BUTTON_TEXT: String = "  Task Manager  "

# Scene Paths
const PATH_TO_DUNGEON_SELECTION_MENU: String = "res://Folders/Systems/Dungeon_Related/Scenes/dungeon_selection_menu.tscn"
const PATH_TO_MAIN_MENU: String = ("res://Folders/Systems/Main/Scenes/main_menu.tscn")

# PLayer
const PLAYER_INVENTORY_NAME: String = "player"

# Items
const NO_ITEM = -1

# Saving and loading
const DEV_SAVE_PATH := "user://dev/save_data.tres"
const LIVE_SAVE_PATH := "user://live/save_data.tres"

# Tasks
const TASK_STATUS_OPTIONS: Array[All_Enums.TASK_STATUS] = [All_Enums.TASK_STATUS.ToDo, All_Enums.TASK_STATUS.Completed]