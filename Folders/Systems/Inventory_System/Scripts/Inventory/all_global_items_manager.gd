class_name AllGlobalItemManager
extends Node

# ===================================================================
# Initialization
# ===================================================================

func _init() -> void:
	call_deferred("_setup")

func _setup() -> void:
	_calculate_max_id()

# ===================================================================
# Getters
# ===================================================================

func get_all_global_items() -> Array[ItemEntry]:
	return Global.save_data.all_global_items_data.all_global_items

func get_items_by_id_dict() -> Dictionary:
	return Global.save_data.all_global_items_data.items_by_id_dict

func get_global_max_id() -> int:
	return Global.save_data.all_global_items_data.global_max_id

# ===================================================================
# Setter
# ===================================================================

func set_all_global_items(new_all_global_items: Array[ItemEntry]) -> void:
	Global.save_data.all_global_items_data.all_global_items = new_all_global_items

func set_items_by_id_dict() -> Dictionary:
	return Global.save_data.all_global_items_data.items_by_id_dict

func set_global_max_id(new_global_max_id: int) -> void:
	return Global.save_data.all_global_items_data.global_max_id

# ===================================================================
# ID Management
# ===================================================================

func sync_item_by_id_dict() -> void:
	InfoGetter.get_items_by_id_dict().clear()

	for item in InfoGetter.get_all_global_items():
		InfoGetter.get_items_by_id_dict()[item.item_id] = item

## Calculates the next available item ID.
func _calculate_max_id() -> void:
	InfoGetter.get_global_max_id() = 0

	for item in InfoGetter.get_all_global_items():
		if item.item_id >= InfoGetter.get_global_max_id().value:
			InfoGetter.get_global_max_id().value = item.item_id + 1


# ===================================================================
# Inventory Operations
# ===================================================================

## Adds an item to the inventory.
func add_item(new_item: ItemEntry) -> void:
	new_item.item_id = InfoGetter.get_global_max_id().value

	InfoGetter.get_all_global_items().append(new_item)
	InfoGetter.get_items_by_id_dict()[new_item.item_id] = new_item

	InfoGetter.get_global_max_id().value += 1

	notify_global_inventory_changed()

## Removes an item from the inventory.
func remove_item(item_id: int) -> void:
	if not InfoGetter.get_items_by_id_dict().has(item_id):
		push_error("All Global Items Manager: Item not found: ", item_id)
		return

	InfoGetter.get_items_by_id_dict().erase(item_id)

	for i in InfoGetter.get_all_global_items().size():
		if InfoGetter.get_all_global_items()[i].item_id == item_id:
			InfoGetter.get_all_global_items().remove_at(i)
			notify_global_inventory_changed()
			return

## Removes every item from the inventory.
func clear_inventory() -> void:
	InfoGetter.get_all_global_items().clear()

	InfoGetter.get_items_by_id_dict().clear()

	InfoGetter.get_global_max_id().value = 0

	notify_global_inventory_changed()

func check_if_item_at_index_in_global_inventory_exists(index: int) -> bool:
	if index < 0 or index >= InfoGetter.get_all_global_items().size():
		return false

	return true

# ===================================================================
# Getters
# ===================================================================

## Returns an item using its unique ID.
func get_item_by_id(item_id: int) -> ItemEntry:
	if not InfoGetter.get_items_by_id_dict().has(item_id):
		push_error("All Global Items Manager: No item with item id: ", item_id)
		return null

	return InfoGetter.get_items_by_id_dict()[item_id] as ItemEntry

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

	for item in InfoGetter.get_all_global_items():
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