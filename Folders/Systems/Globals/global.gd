extends Node

# ============================================================================
# Vars
# ============================================================================

var save_data: SaveData

enum GAME_STATES {
	Playing,
	Menu,

}

var current_game_state: GAME_STATES

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

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("add_test_sword"):
		save_data.inventory_component.add_test_sword()

	if current_game_state == GAME_STATES.Playing:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
		get_tree().paused = false
	elif current_game_state == GAME_STATES.Menu:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().paused = true

func _ready() -> void:
	test()
