extends Node

# Hotbar
const NUMBER_OF_HOTBAR_SLOTS: int = 9

const UNSELECTED_HOTBAR_SLOT_OPACITY: float = 0.0
const SELECTED_HOTBAR_SLOT_OPACITY: float = 0.5

# Scene Paths
const PATH_TO_PLAYER_SCENE: String = "res://Folders/Systems/Player/player.tscn"

const PATH_TO_TASK_MANAGER: String = "res://Folders/Systems/TaskManager/Display/TaskManagerCanvasLayer/task_manager_ui_canvas_layer.tscn"
const PATH_TO_DUNGEON_SELECTION_MENU: String = "res://Folders/Systems/DungeonRelated/DungeonSelectionMenu/DungeonSelectionMenuScene/dungeon_selection_menu.tscn"
const PATH_TO_DUNGEON_CANVAS_LAYER: String = "res://Folders/Systems/DungeonRelated/Display/dungeon_canvas_layer.tscn"
const PATH_TO_MAIN_MENU: String = "res://Folders/Systems/Main/MainMenu/main_menu.tscn"

const PATH_TO_UILAYER_SCENE: String = "res://Folders/Systems/Main/Scenes/ui_layer.tscn"
const PATH_TO_INVENTORY_UI_LAYER: String = "res://Folders/Systems/Inventory_System/Scenes/inventory_ui_layer.tscn"
const PATH_TO_DEATH_MENU: String = "res://Folders/Systems/Dungeon_Related/Death_Menu/death_menu.tscn"

const PATH_TO_HOTBAR_SLOT: String = "res://Folders/Systems/Inventory_System/Scenes/hotbar_slot.tscn"

const PATH_TO_RIGHT_CLICK_MENU: String = "res://Folders/Systems/Input/Scenes/right_click_menu.tscn"
const PATH_TO_TEXT_INPUT_BOX: String = "res://Folders/Systems/Input/Scenes/text_input_box.tscn"
const PATH_TO_CONFORMATION_BOX: String = "res://Folders/Systems/Input/Scenes/conformation_box.tscn"

const PATH_TO_TASK_ITEM_SCENE: String = "res://Folders/Systems/Task-Manager/Scenes/task_item_scene.tscn"

const PATH_TO_ONLINE_BACKUP_SCENE: String = "res://Folders/Systems/SaveManager/Online_backup/online_backup.tscn"
const PATH_TO_BACKING_UP_ONLINE_DATA_LOADING_SCENE: String = "res://Folders/Systems/SaveManager/Online_backup/backing_up_online_data_loading_scene.tscn"

# PLayer
const PLAYER_INVENTORY_NAME: String = "player"

# Items
const NO_ITEM: int = -1

# Saving and loading
const DEV_SAVE_PATH: String = "user://dev/save_data.tres"
const LIVE_SAVE_PATH: String = "user://live/save_data.res"

# Right Click Menu Options
const MAIN_MENU_RIGHT_CLICK_MENU_OPTIONS: Array[String] = ["Quit Game"]
const TASK_MANAGER_RIGHT_CLICK_MENU_OPTIONS: Array[String] = ["Add Task", "Go back to main menu"]
const TASK_ITEM_SCENE_EXTRA_OPTIONS: Array[String] = ["Remove this task", "Rename this task"]

# Tasks
const TASK_STATUS_OPTIONS: Dictionary[String, All_Enums.TASK_STATUS] = {
	"To-Do": All_Enums.TASK_STATUS.ToDo,
	"Completed": All_Enums.TASK_STATUS.Completed,
}

const NO_TASK = -1