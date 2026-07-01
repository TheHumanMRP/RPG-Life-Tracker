class_name InventoryLogicComponent
extends Resource


# ===================================================================
# Constants
# ===================================================================

const EMPTY_HOTBAR_SLOT: int = -1


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
	calculate_max_id()

	# Temporary testing
	testing_inventory()


func testing_inventory() -> void:
	print_all_items()

	clear_inventory()
	add_test_sword()


# ===================================================================
# ID Management
# ===================================================================

## Calculates the next available item ID.
func calculate_max_id() -> void:
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

	SignalBus.inventory_changed.emit()


## Removes every item from the inventory.
func clear_inventory() -> void:
	inventory_items.clear()

	max_id = 0

	SignalBus.inventory_changed.emit()


# ===================================================================
# Getters
# ===================================================================

## Returns an item using its unique ID.
func get_item_by_id(item_id: int) -> ItemEntry:
	for item in inventory_items:
		if item.item_id == item_id:
			return item

	print("\nInventoryLogic Debug")
	print("Inventory Size: ", inventory_items.size())

	push_error(
		"InventoryLogic: Item not found with ID ",
		item_id
	)

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
		sword.base_durability,
		load("res://Folders/Assets/icon.svg")
	)

	add_item(entry)


func print_all_items() -> void:
	for item in inventory_items:
		item.print_self()

# ===================================================================
# Notify Listner
# ===================================================================

func notify_inventory_changed() -> void:
	SignalBus.inventory_changed.emit()