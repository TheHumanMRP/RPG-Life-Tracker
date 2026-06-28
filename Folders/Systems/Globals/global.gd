3extends Node

# ============================================================================
# INVENTORY SETTINGS
# ============================================================================
var number_of_inventory_slots: int = 9

func get_inventory() -> Array[ItemEntry]:
	return save_data.inventory_logic.inventory_items

# ============================================================================
# SAVE SETTINGS
# ============================================================================

var save_next: bool = false
var save_timer: int = 60
var save_data: SaveData

@onready var save_manager: SaveManager = SaveManager.new()


# ============================================================================
# PUBLIC FUNCTIONS
# ============================================================================

func save() -> void:
	save_next = true

func load() -> void:
	_load_data()

func close_game() -> void:
	_save_data()
	get_tree().quit()


# ============================================================================
# LIFECYCLE
# ============================================================================

func _ready() -> void:
	_load_data()
	save_loop()

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