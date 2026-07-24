class_name AllGlobalItemManager
extends Resource


# ===================================================================
# Inventory Data
# ===================================================================

@export var inventory_items: Array[ItemEntry] = []

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

## Calculates the next available item ID.
func _calculate_max_id() -> void:
	max_id = 0

	for item in inventory_items:
		if item.item_id >= max_id:
			max_id = item.item_id + 1


# ===================================================================
# Inventory Operations
# ===================================================================

## Adds an item to the inventory.
func add_item(new_item: ItemEntry) -> void:
	new_item.item_id = max_id

	inventory_items.append(new_item)

	max_id += 1

	notify_inventory_changed()


## Removes an item from the inventory.
func remove_item(item_id: int) -> void:
	for i in inventory_items.size():
		if inventory_items[i].item_id != item_id:
			continue

		inventory_items.pop_at(i)
		notify_inventory_changed()
		return

	push_error("InventoryLogic: Item not found: ", item_id)


## Uses an item.
func use_item(item_id: int, target) -> void:
	var item := get_item_by_id(item_id)

	if item == null:
		return

	item.use_item(target)

	notify_inventory_changed()


## Removes every item from the inventory.
func clear_inventory() -> void:
	inventory_items.clear()

	max_id = 0

	notify_inventory_changed()

func check_if_item_at_index_in_inventory_exists(index: int) -> bool:
	if index < 0 or index >= inventory_items.size():
		return false
	
	return true

# ===================================================================
# Getters
# ===================================================================

## Returns an item using its unique ID.
func get_item_by_id(item_id: int) -> ItemEntry:
	for item in inventory_items:
		if not item.item_id == item_id:
			continue
		
		return item

	print("\nInventoryLogic: Debug")
	print("Inventory Size: ", inventory_items.size())

	push_error("InventoryLogic: Item not found with ID ", item_id, ". Check the debug print.")

	return null


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

	notify_inventory_changed()


func print_all_items() -> void:
	print("\nInventory Logic: Printing all items")
	
	for item in inventory_items:
		item.print_self()

# ===================================================================
# Notify Listner
# ===================================================================

func notify_inventory_changed() -> void:
	SignalBus.inventory_changed.emit()
	SignalBus.save_game.emit()

	print("\nInventory Logic: Notified that the inventory changed.")