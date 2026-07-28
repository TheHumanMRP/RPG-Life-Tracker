class_name AllGlobalItemManager
extends Node

# ===================================================================
# Inventory Data
# ===================================================================

@export var all_global_items: Array[ItemEntry] = []

@export var items_by_id_dict: Dictionary

@export var max_id: int = 0


# ===================================================================
# Initialization
# ===================================================================

func _init() -> void:
	call_deferred("_setup")

func _setup() -> void:
	_calculate_max_id()

# ===================================================================
# ID Management
# ===================================================================

func sync_item_by_id_dict() -> void:
	items_by_id_dict.clear()

	for item in all_global_items:
		items_by_id_dict[item.item_id] = item

## Calculates the next available item ID.
func _calculate_max_id() -> void:
	max_id = 0

	for item in all_global_items:
		if item.item_id >= max_id:
			max_id = item.item_id + 1


# ===================================================================
# Inventory Operations
# ===================================================================

## Adds an item to the inventory.
func add_item(new_item: ItemEntry) -> void:
	new_item.item_id = max_id

	all_global_items.append(new_item)
	items_by_id_dict[new_item.item_id] = new_item

	max_id += 1

	notify_global_inventory_changed()

## Removes an item from the inventory.
func remove_item(item_id: int) -> void:
	if not items_by_id_dict.has(item_id):
		push_error("All Global Items Manager: Item not found: ", item_id)
		return

	items_by_id_dict.erase(item_id)

	for i in all_global_items.size():
		if all_global_items[i].item_id == item_id:
			all_global_items.remove_at(i)
			notify_global_inventory_changed()
			return

## Removes every item from the inventory.
func clear_inventory() -> void:
	all_global_items.clear()

	items_by_id_dict.clear()

	max_id = 0

	notify_global_inventory_changed()

func check_if_item_at_index_in_global_inventory_exists(index: int) -> bool:
	if index < 0 or index >= all_global_items.size():
		return false
	
	return true

# ===================================================================
# Getters
# ===================================================================

## Returns an item using its unique ID.
func get_item_by_id(item_id: int) -> ItemEntry:
	if not items_by_id_dict.has(item_id):
		push_error("All Global Items Manager: No item with item id: ", item_id)
		return null
	
	return items_by_id_dict[item_id] as ItemEntry

# ===================================================================
# Debug
# ===================================================================

func add_test_sword() -> void:
	var sword := Sword.new()
	sword.setup("Hello Brother", null)

	var entry := ItemEntry.new()
	entry.setup(
		sword,
		load("res://Folders/Assets/icon.svg"),
		sword.base_durability,
	)

	add_item(entry)

	print_all_items()

	notify_global_inventory_changed()


func print_all_items() -> void:
	print("\nAll Global Items Manager: Printing all items")
	
	for item in all_global_items:
		item.print_self()

# ===================================================================
# Notify Listner
# ===================================================================

func notify_global_inventory_changed() -> void:
	SignalBus.notify_global_inventory_changed.emit()
	SignalBus.save_game.emit()

	print("\nAll Global Items Manager: Notified that the inventory changed.")