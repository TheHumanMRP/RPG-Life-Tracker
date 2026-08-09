extends Node

# ============================================================================
# Game State
# ============================================================================

enum GAME_STATES {
	Playing,
	Menu,

}

var current_game_state: GAME_STATES

# ============================================================================
# Vars
# ============================================================================

var save_data: SaveData

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
	elif current_game_state == GAME_STATES.Menu:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _ready() -> void:
	test()
