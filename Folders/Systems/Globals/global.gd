extends Node

# ============================================================================
# Vars
# ============================================================================

var save_data: SaveData

var current_game_state: All_Enums.GAME_STATES:
	set(new_current_game_state):
		current_game_state = new_current_game_state
		_set_game_state_settings()

func _set_game_state_settings() -> void:
	match current_game_state:
		All_Enums.GAME_STATES.Playing:
			if 

			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			get_tree().paused = false
		All_Enums.GAME_STATES.UIMenu:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			get_tree().paused = false
		All_Enums.GAME_STATES.DeathMenu:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

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
		save_data.inventory_component.add_test_sword()

func _ready() -> void:
	test()
	SignalBus.set_game_state.connect(_on_set_game_state)

func _on_set_game_state(new_game_state: All_Enums.GAME_STATES) -> void:
	current_game_state = new_game_state
