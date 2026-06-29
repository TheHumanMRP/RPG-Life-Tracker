class_name InventoryLogicComponent
extends Resource

# -------------------------------------------------------------------
# Inventory Data
# -------------------------------------------------------------------

@export var inventory_items: Array[ItemEntry] = []
@export var hotbar_slots: Array[int] = []
@export var max_id: int = 0

const EMPTY_HOTBAR_ARRAY: int = -1

# -------------------------------------------------------------------
# Initialization
# -------------------------------------------------------------------

func _init() -> void:
	call_deferred("calculate_max_id")
	call_deferred("testing_inventory")


func testing_inventory() -> void:
	clear_inventory()
	for i in range(2):
		add_test_sword()
	

func setup_hotbar_slots() -> void:
	hotbar_slots.clear()

	for i in range(9):
		hotbar_slots.append(EMPTY_HOTBAR_ARRAY)


# -------------------------------------------------------------------
# ID Management
# -------------------------------------------------------------------

## Finds the next available item ID based on existing inventory items.
func calculate_max_id() -> void:
	max_id = 0

	for item in inventory_items:
		if item.item_id >= max_id:
			max_id = item.item_id + 1


func add_test_sword() -> void:
	var test_item: Sword = Sword.new()

	test_item.setup("Hello Brother", null)

	var test_item_entry: ItemEntry = ItemEntry.new()

	test_item_entry.setup(test_item, test_item.base_durability, load("res://Folders/Assets/icon.svg"))

	add_item(test_item_entry)

	print("\nInventory Logic: Here's the inventory brother: ", inventory_items)

	print("\nInventory Logic: Here's the inventory size brother: ", inventory_items.size())


# -------------------------------------------------------------------
# Inventory Operations
# -------------------------------------------------------------------

func add_item_to_hotbar(item: ItemEntry, slot: int) -> void:
	if check_if_slot_empty(slot):
		push_error("Slot not empty: ", slot)

## Adds a new item to the inventory and assigns it a unique ID.
func add_item(new_item_entry: ItemEntry) -> void:
	new_item_entry.item_id = max_id

	inventory_items.append(new_item_entry)

	max_id += 1

	# Notify listeners that the inventory has changed.
	SignalBus.inventory_changed.emit()


## Removes an item with the specified ID from the inventory.
func remove_item(item_id: int) -> void:
	for index in range(inventory_items.size()):
		if inventory_items[index].item_id != item_id:
			continue

		inventory_items.pop_at(index)

		# Notify listeners that the inventory has changed.
		SignalBus.inventory_changed.emit()

		return

	push_error(
		"InventoryLogic: Item with ID ",
		item_id,
		" was not found for removal."
	)


## Uses the item with the specified ID from the inventory
func use_item(item_id: int, target) -> void:
	for item in inventory_items:
		if not item.item_id == item_id:
			continue
		
		item.use_item(target)

		SignalBus.inventory_changed.emit()

func clear_inventory() -> void:
	inventory_items.clear()
	SignalBus.inventory_changed.emit()

func get_iten_by_id(item_id: int) -> ItemEntry:
	for item in inventory_items:
		if not item.item_id == item_id:
			continue
		
		return item
	
	push_error("Item not found with item_id: ", item_id)
	return

func check_if_slot_empty(slot: int) -> bool:
	if hotbar_slots[slot] == EMPTY_HOTBAR_ARRAY:
		return true
	
	return false