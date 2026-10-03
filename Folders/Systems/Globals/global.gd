extends Node


# ============================================================================
# Managers
# ============================================================================

var inventory_related_managers: InventoryRelatedManagers
var tasks_related_managers: TasksRelatedManagers

# ============================================================================
# Game State
# ============================================================================

var current_game_state: All_Enums.GAME_STATES

func _set_game_state_settings() -> void:
	match current_game_state:
		All_Enums.GAME_STATES.MainMenu:
			get_tree().paused = false
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

		All_Enums.GAME_STATES.DungeonSelectionMenu:
			get_tree().paused = false
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

		All_Enums.GAME_STATES.DungeonPlaying:
			get_tree().paused = false

			if OS.is_debug_build():
				return

			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

		All_Enums.GAME_STATES.TaskManager:
			get_tree().paused = false
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

		All_Enums.GAME_STATES.DeathMenu:
			get_tree().paused = true
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _handle_loading_and_unloading_of_managers() -> void:
	match current_game_state:
		All_Enums.GAME_STATES.MainMenu:
			tasks_related_managers = null
			inventory_related_managers = null
		
		All_Enums.GAME_STATES.DungeonSelectionMenu:
			tasks_related_managers = null
			inventory_related_managers = null

		All_Enums.GAME_STATES.DungeonPlaying:
			tasks_related_managers = null

			if inventory_related_managers:
				return

			inventory_related_managers = InventoryRelatedManagers.new()
			inventory_related_managers.setup()

		All_Enums.GAME_STATES.TaskManager:
			if tasks_related_managers and inventory_related_managers:
				return
			
			tasks_related_managers = TasksRelatedManagers.new()
			inventory_related_managers = InventoryRelatedManagers.new()

			tasks_related_managers.setup()
			inventory_related_managers.setup()


func _on_set_game_state(new_game_state: All_Enums.GAME_STATES) -> void:
	current_game_state = new_game_state
	_set_game_state_settings()
	_handle_loading_and_unloading_of_managers()


# ============================================================================
# Save Data
# ============================================================================

var save_data: SaveData = SaveData.new()


# ============================================================================
# Main Node
# ============================================================================

@onready var main_scene: MainScene

func set_main_scene_var() -> void:
	main_scene = get_tree().get_first_node_in_group("main_scene")


# ============================================================================
# Lifecycle
# ============================================================================

func _ready() -> void:
	SignalBus.set_game_state.connect(_on_set_game_state)

	call_deferred("test")
	
	set_main_scene_var()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("add_test_sword"):
		InfoGetter.get_all_global_items_manager().add_test_sword()


# ============================================================================
# Testing
# ============================================================================

func test() -> void:
	if not OS.is_debug_build():
		return

	var testing: TestingScript = TestingScript.new()

	testing.test()