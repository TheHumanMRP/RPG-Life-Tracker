class_name AllGlobalItemManagerClass
extends Node

# ===================================================================
# Initialization
# ===================================================================

func _init() -> void:
	connect_signals()

	call_deferred("_setup")

func connect_signals() -> void:
	SignalBus.add_item_to_global_inventory.connect(add_item)

func _setup() -> void:
	_calculate_max_id()

# ===================================================================
# Getters
# ===================================================================

func get_all_global_items_data() -> AllGlobalItemsData:
	return Global.save_data.all_global_items_data

# ===================================================================
# ID Management
# ===================================================================

func sync_item_by_id_dict() -> void:
	var data := get_all_global_items_data()

	data.items_by_id_dict.clear()

	for item in data.all_global_items:
		data.items_by_id_dict[item.item_id] = item

	save_all_global_items_data()

## Calculates the next available item ID.
func _calculate_max_id() -> void:
	var data := get_all_global_items_data()

	data.global_max_id = 0

	for item in data.all_global_items:
		if item.item_id >= data.global_max_id:
			data.global_max_id = item.item_id + 1

	save_all_global_items_data()

# ===================================================================
# Inventory Operations
# ===================================================================

## Adds an item to the inventory.
func add_item(new_item_entry: ItemEntry) -> void:
	var data := get_all_global_items_data()

	new_item_entry.item_id = data.global_max_id

	data.all_global_items.append(new_item_entry)
	data.items_by_id_dict[new_item_entry.item_id] = new_item_entry

	data.global_max_id += 1

	save_all_global_items_data()
	notify_global_inventory_changed()

## Removes an item from the inventory.
func remove_item(item_id: int) -> void:
	var data := get_all_global_items_data()

	if not data.items_by_id_dict.has(item_id):
		push_error("All Global Items Manager: Item not found: ", item_id)
		return

	data.items_by_id_dict.erase(item_id)

	for i in data.all_global_items.size():
		if data.all_global_items[i].item_id == item_id:
			data.all_global_items.remove_at(i)

			save_all_global_items_data()
			notify_global_inventory_changed()
			return

func rename_item_in_inventory(item_id: int, new_name: String) -> void:
	var item_to_rename: ItemEntry = get_item_by_id(item_id)

	item_to_rename.name = new_name

	save_all_global_items_data()

## Removes every item from the inventory.
func clear_inventory() -> void:
	var data := get_all_global_items_data()

	data.all_global_items.clear()
	data.items_by_id_dict.clear()
	data.global_max_id = 0

	save_all_global_items_data()
	notify_global_inventory_changed()

func check_if_item_at_index_in_global_inventory_exists(index: int) -> bool:
	var data := get_all_global_items_data()

	if index < 0 or index >= data.all_global_items.size():
		return false

	return true

# ===================================================================
# Getters
# ===================================================================

## Returns an item using its unique ID.
func get_item_by_id(item_id: int) -> ItemEntry:
	var data := get_all_global_items_data()

	if not data.items_by_id_dict.has(item_id):
		push_error("All Global Items Manager: No item with item id: ", item_id)
		return null

	return data.items_by_id_dict[item_id] as ItemEntry

# ===================================================================
# Debug
# ===================================================================

func add_test_sword() -> void:
	var sword := Sword.new()
	sword.setup("Hello Brother", null)

	var sword_name: String = "Test Sword"

	var entry := ItemEntry.new()
	entry.setup(
		sword,
		sword_name,
		load("res://Folders/Assets/icon.svg"),
		sword.base_durability,
	)

	add_item(entry)

	print_all_items()

	notify_global_inventory_changed()

func print_all_items() -> void:
	print("\nAll Global Items Manager: Printing all items")

	var data := get_all_global_items_data()

	for item in data.all_global_items:
		item.print_self()

# ===================================================================
# Notify Listener
# ===================================================================

func notify_global_inventory_changed() -> void:
	SignalBus.notify_global_inventory_changed.emit()
	SignalBus.save_game.emit()

	print("\nAll Global Items Manager: Notified that the inventory changed.")

func save_all_global_items_data() -> void:
	SaveCycleManager.toggle_save_next()