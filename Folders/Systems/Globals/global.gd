extends Node

# ============================================================================
# Vars
# ============================================================================

var save_data: SaveData

enum GAME_STATES {
	Playing,
	UIMenu,

}

var current_game_state: GAME_STATES:
	set(new_current_game_state):
		current_game_state = new_current_game_state
		_set_game_state_settings()

# ============================================================================
# Consts
# ============================================================================

const PLAYER_INVENTORY_NAME: String = "player"

# ============================================================================
# Testing
# ============================================================================

func test() -> void:
	var testing: TestingScript = TestingScript.new()

	testing.test()

# ============================================================================
# LIFECYCLE
# ============================================================================

func _set_game_state_settings() -> void:
	match current_game_state:
		GAME_STATES.Playing:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			get_tree().paused = false
		GAME_STATES.UIMenu:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			get_tree().paused = true

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("add_test_sword"):
		save_data.inventory_component.add_test_sword()

func _ready() -> void:
	test()
