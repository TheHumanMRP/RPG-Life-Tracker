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
func get_inventory_logic() -> InventoryLogicComponent:
	return save_data.inventory_logic

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

@onready var save_manager: SaveManager = SaveManager.new()


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
		print("\nTesting In Global: Adding Item")

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
	while true:
		await get_tree().create_timer(save_timer).timeout
		
		if save_next:
			_save_data()


# ============================================================================
# INTERNAL SAVE/LOAD
# ============================================================================

func _save_data() -> void:
	save_manager.save_info = save_data
	save_manager.save_data()

func _load_data():
	save_manager.load_data()
	save_data = save_manager.save_info
