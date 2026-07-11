extends Node

# ============================================================================
# Vars
# ============================================================================

var save_data: SaveData


# ============================================================================
# Testing
# ============================================================================

func test() -> void:
	var testing: TestingScript = TestingScript.new()

	testing.setup(save_data.inventory_logic, save_data.hotbar_logic)

	testing.test()

# ============================================================================
# LIFECYCLE
# ============================================================================

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("add_test_sword"):
		save_data.inventory_logic.add_test_sword()

func _ready() -> void:
	test()
