extends Node

# ============================================================================
# Testing
# ============================================================================

func test() -> void:
	var testing: TestingScript = TestingScript.new()

	testing.setup(save_data.inventory_logic, save_data.hotbar_logic)

	testing.test()

# ============================================================================
# INVENTORY SETTINGS
# ============================================================================
func check_if_item_at_index_in_inventory_exists(index: int) -> bool:
	return save_data.inventory_logic.check_if_item_at_index_in_inventory_exists(index)

func get_inventory_logic() -> InventoryLogicComponent:
	return save_data.inventory_logic

func get_number_of_hotbar_slots() -> int:
	return save_data.hotbar_logic.NUMBER_OF_HOTBAR_SLOTS

func get_hotbar_logic() -> HotBarLogicComponent:
	return save_data.hotbar_logic

func get_inventory() -> Array[ItemEntry]:
	return save_data.inventory_logic.inventory_items

func get_hotbar() -> Array[int]:
	return save_data.hotbar_logic.hotbar_slots

# ============================================================================
# SAVE SETTINGS
# ============================================================================

var save_next: bool = false
var save_timer: int = 60
var save_data: SaveData

# @onready var save_manager: SaveManager = SaveManager.new()
@onready var save_cycle_manager: SaveCycleManager = SaveCycleManager.new()


# ============================================================================
# PUBLIC FUNCTIONS
# ============================================================================s

func load() -> void:
	_load_data()

func close_game() -> void:
	_save_data()
	get_tree().quit()


# ============================================================================
# LIFECYCLE
# ============================================================================

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("add_test_sword"):
		save_data.inventory_logic.add_test_sword()

func _ready() -> void:
	_load_data()
	save_loop()
	test()

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		_save_data()


# ============================================================================
# SAVE LOOP
# ============================================================================

func save_loop() -> void:
	save_cycle_manager.save_loop()

# ============================================================================
# INTERNAL SAVE/LOAD
# ============================================================================

func _save_data() -> void:
	save_cycle_manager._save_data()

func _load_data():
	save_cycle_manager._load_data()