extends Node

var hotbar_logic: HotbarLogic

# ============================================================================
# Global scripts
# ============================================================================

var signal_bus: SignalBus = SignalBus.new()
var info_getter: InfoGetter = InfoGetter.new()
var constants: Constants = Constants.new()
var all_global_items_manager: AllGlobalItemsManager = AllGlobalItemsManager.new()

# ============================================================================
# Vars
# ============================================================================
var save_data: SaveData = SaveData.new()

var current_game_state: All_Enums.GAME_STATES:
	set(new_current_game_state):
		current_game_state = new_current_game_state
		_set_game_state_settings()

func _set_game_state_settings() -> void:
	match current_game_state:
		All_Enums.GAME_STATES.Playing:
			if not OS.is_debug_build():
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			get_tree().paused = false

		All_Enums.GAME_STATES.UIMenu:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			get_tree().paused = false
			
		All_Enums.GAME_STATES.DeathMenu:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

# ============================================================================
# Main Node
# ============================================================================
var main_node: MainNode

func set_main_node() -> void:
	main_node = get_tree().get_first_node_in_group("main_node")

# ============================================================================
# Testing
# ============================================================================

func test() -> void:
	if not OS.is_debug_build():
		return

	var testing: TestingScript = TestingScript.new()

	testing.test()

# ============================================================================
# LIFECYCLE
# ============================================================================
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("add_test_sword"):
		AllGlobalItemsManager.add_test_sword()

		hotbar_logic.add_item_to_hotbar(1, 1)

func _ready() -> void:
	SignalBus.set_game_state.connect(_on_set_game_state)

	hotbar_logic = HotbarLogic.new()

	call_deferred("test")

	call_deferred("set_main_node")

func _on_set_game_state(new_game_state: All_Enums.GAME_STATES) -> void:
	current_game_state = new_game_state
