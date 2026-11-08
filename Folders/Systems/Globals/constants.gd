extends Node

# ==============================================================================
# HOTBAR CONFIGURATION
# ==============================================================================
const NUMBER_OF_HOTBAR_SLOTS: int = 9
const UNSELECTED_HOTBAR_SLOT_OPACITY: float = 0.0
const SELECTED_HOTBAR_SLOT_OPACITY: float = 0.5

# ==============================================================================
# PLAYER & ITEMS
# ==============================================================================
const PLAYER_INVENTORY_NAME: String = "player"
const NO_ITEM: int = -1

# ==============================================================================
# SAVE & LOAD
# ==============================================================================
const DEV_SAVE_PATH: String = "user://dev/save_data.tres"
const LIVE_SAVE_PATH: String = "user://live/save_data.res"

# ==============================================================================
# TASKS
# ==============================================================================
const NO_TASK: int = -1
const TASK_STATUS_OPTIONS: Dictionary[String, All_Enums.TASK_STATUS] = {
	"To-Do": All_Enums.TASK_STATUS.ToDo,
	"Completed": All_Enums.TASK_STATUS.Completed,
}

# ==============================================================================
# RIGHT-CLICK MENU OPTIONS
# ==============================================================================
const MAIN_MENU_RIGHT_CLICK_MENU_OPTIONS: Array[String] = ["Quit Game"]
const TASK_MANAGER_RIGHT_CLICK_MENU_OPTIONS: Array[String] = ["Add Task", "Go back to main menu"]
const TASK_ITEM_SCENE_EXTRA_OPTIONS: Array[String] = ["Remove this task", "Rename this task"]

# ==============================================================================
# SCENE PATHS
# ==============================================================================

# Core & Player
const PATH_TO_PLAYER_SCENE: String = "res://Folders/Systems/Player/player.tscn"

# Menus & Navigation
const PATH_TO_MAIN_MENU: String = "res://Folders/Systems/Main/MainMenu/main_menu.tscn"
const PATH_TO_DEATH_MENU: String = "res://Folders/Systems/DungeonRelated/DeathMenu/death_menu.tscn"

# Task Manager
const PATH_TO_TASK_MANAGER: String = "res://Folders/Systems/TaskManager/Display/TaskManagerCanvasLayer/task_manager_ui_canvas_layer.tscn"
const PATH_TO_TASK_ENTRY_SCENE: String = "res://Folders/Systems/TaskManager/TaskEntry/task_entry_scene.tscn"

# Dungeon Related
const PATH_TO_DUNGEON_SELECTION_MENU: String = "res://Folders/Systems/DungeonRelated/DungeonSelectionMenu/DungeonSelectionMenuScene/dungeon_selection_menu.tscn"
const PATH_TO_DUNGEON_ITEM: String = "res://Folders/Systems/DungeonRelated/DungeonSelectionMenu/DungeonSelectionMenuUIComponents/dungeon_item.tscn"
const PATH_TO_DUNGEON_CANVAS_LAYER: String = "res://Folders/Systems/DungeonRelated/Display/dungeon_canvas_layer.tscn"

# Inventory & Hotbar
const PATH_TO_INVENTORY_UI_LAYER: String = "res://Folders/Systems/InventorySystem/Display/inventory_ui_layer.tscn"
const PATH_TO_HOTBAR_SLOT: String = "res://Folders/Systems/InventorySystem/Hotbar/HotbarSlot/hotbar_slot.tscn"

# Input & UI Widgets
const PATH_TO_RIGHT_CLICK_MENU: String = "res://Folders/Systems/Input/RightClickMenu/right_click_menu.tscn"
const PATH_TO_TEXT_INPUT_BOX: String = "res://Folders/Systems/Input/TextInputBox/text_input_box.tscn"
const PATH_TO_CONFORMATION_BOX: String = "res://Folders/Systems/Input/ConformationBox/conformation_box.tscn"

# Save Manager & Online Backup
const PATH_TO_ONLINE_BACKUP_SCENE: String = "res://Folders/Systems/SaveManager/OnlineBackup/online_backup.tscn"
const PATH_TO_BACKING_UP_ONLINE_DATA_LOADING_SCENE: String = "res://Folders/Systems/SaveManager/OnlineBackup/backing_up_online_data_loading_scene.tscn"