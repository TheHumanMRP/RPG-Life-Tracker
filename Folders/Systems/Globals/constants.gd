extends Node

# Hotbar
const NUMBER_OF_HOTBAR_SLOTS: int = 9

const UNSELECTED_HOTBAR_SLOT_OPACITY: float = 0.0
const SELECTED_HOTBAR_SLOT_OPACITY: float = 0.5

# Scene Paths
const PATH_TO_PLAYER_SCENE: String = "res://Folders/Systems/Player/player.tscn"

const PATH_TO_TASK_MANAGER: String = "res://Folders/Systems/Task-Manager/Scenes/task_manager_ui.tscn"
const PATH_TO_DUNGEON_SELECTION_MENU: String = "res://Folders/Systems/Dungeon_Related/Scenes/dungeon_selection_menu.tscn"
const PATH_TO_DUNGEON_SCENE: String = "res://Folders/Systems/Dungeon_Related/Scenes/dungeon.tscn"
const PATH_TO_MAIN_MENU: String = "res://Folders/Systems/Main/Scenes/main_menu.tscn"

const PATH_TO_UILAYER_SCENE: String = "res://Folders/Systems/Main/Scenes/ui_layer.tscn"
const PATH_TO_INVENTORY_UI_LAYER: String = "res://Folders/Systems/Inventory_System/Scenes/inventory_ui_layer.tscn"
const PATH_TO_DEATH_MENU: String = "res://Folders/Systems/Dungeon_Related/Death_Menu/death_menu.tscn"

const PATH_TO_HOTBAR_SLOT: String = "res://Folders/Systems/Inventory_System/Scenes/hotbar_slot.tscn"

# PLayer
const PLAYER_INVENTORY_NAME: String = "player"

# Items
const NO_ITEM = -1

# Saving and loading
const DEV_SAVE_PATH := "user://dev/save_data.tres"
const LIVE_SAVE_PATH := "user://live/save_data.tres"

# Right Click Menu

const RIGHT_CLICK_MENU_OPTIONS_WITH_GAME_STATES: Dictionary[All_Enums.GAME_STATES, Array] = {
	All_Enums.GAME_STATES.MainMenu: [""]
}

const callable: Callable = InfoGetter.get_main_menu().handle_right_click_menu_quit_game

# Tasks
const TASK_STATUS_OPTIONS: Dictionary[String, All_Enums.TASK_STATUS] = {
	"To-Do": All_Enums.TASK_STATUS.ToDo,
	"Completed": All_Enums.TASK_STATUS.Completed,
}

const NO_TASK = -1