extends Node


# ============================================================================
# Managers
# ============================================================================

var inventory_related_managers: InventoryRelatedManagers
var tasks_related_managers: TasksRelatedManagers

func _setup_managers() -> void:
	inventory_related_managers = InventoryRelatedManagers.new()

	inventory_related_managers.setup()
	tasks_related_managers.setup()


# ============================================================================
# Game State
# ============================================================================

var current_game_state: All_Enums.GAME_STATES:
	set(new_current_game_state):
		current_game_state = new_current_game_state
		_set_game_state_settings()

func _set_game_state_settings() -> void:
	match current_game_state:
		All_Enums.GAME_STATES.Dungeon:
			get_tree().paused = false

			if OS.is_debug_build():
				return

			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

			tasks_related_managers.free()

		All_Enums.GAME_STATES.UIMenu:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			get_tree().paused = false

		All_Enums.GAME_STATES.TaskManager:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			get_tree().paused = false


		All_Enums.GAME_STATES.DeathMenu:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_set_game_state(new_game_state: All_Enums.GAME_STATES) -> void:
	current_game_state = new_game_state


# ============================================================================
# Save Data
# ============================================================================

var save_data: SaveData = SaveData.new()


# ============================================================================
# Main Node
# ============================================================================

var main_node: MainNode

func set_main_node() -> void:
	main_node = get_tree().get_first_node_in_group("main_node")


# ============================================================================
# Lifecycle
# ============================================================================

func _ready() -> void:
	SignalBus.set_game_state.connect(_on_set_game_state)

	_setup_managers()

	call_deferred("test")
	call_deferred("set_main_node")


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("add_test_sword"):
		AllGlobalItemsManager.add_test_sword()


# ============================================================================
# Testing
# ============================================================================

func test() -> void:
	if not OS.is_debug_build():
		return

	var testing: TestingScript = TestingScript.new()

	testing.test()