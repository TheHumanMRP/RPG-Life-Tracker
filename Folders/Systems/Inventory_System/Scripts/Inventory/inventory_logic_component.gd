class_name InventoryLogicComponent
extends Resource

# ===================================================================
# Inventory Vars
# ===================================================================

var inventory_name: String

# ===================================================================
# Initialise
# ===================================================================

func setup(new_inventory_name: String) -> void:
	inventory_name = new_inventory_name

# ===================================================================
# Getters
# ===================================================================

func get_inventory_item_ids() -> Array[int]:
	if not inventory_name:
		push_error("Inventory Logic Component: No Inventory Name")

	var inventory_item_ids: Array[int] = Global.save_data.inventory_items_data.all_inventories[inventory_name] as Array[int]

	return inventory_item_ids

# ===================================================================
# Helpers
# ===================================================================

func ensure_this_inventory_name_array_exists_in_the_inventory_data_dict() -> void:
# ===================================================================
# Inventory Operations
# ===================================================================
## Adds an already-globally-registered item to this inventory by its id.
func add_item(item_id: int) -> void:
	if get_inventory_item_ids().has(item_id):
		push_error("InventoryComponent: Item already in this inventory: ", item_id)
		return

	if AllGlobalItemsManager.get_item_by_id(item_id) == null:
		return

	get_inventory_item_ids().append(item_id)

	notify_inventory_changed()


## Removes an item's reference from this inventory. The item itself stays
## registered in the global item manager (e.g. for dropping/transferring).
func remove_item(item_id: int) -> void:
	for i in get_inventory_item_ids().size():
		if get_inventory_item_ids()[i] != item_id:
			continue

		get_inventory_item_ids().pop_at(i)
		notify_inventory_changed()
		return

	push_error("InventoryComponent: Item not found in this inventory: ", item_id)


## Uses an item that belongs to this inventory.
func use_item(item_id: int, target) -> void:
	var item: ItemEntry = AllGlobalItemsManager.get_item_by_id(item_id)

	if item == null:
		return

	item.use_item(target)

	notify_inventory_changed()


## Removes every item reference from this inventory. Items stay registered
## in the global item manager.
func clear_inventory() -> void:
	get_inventory_item_ids().clear()

	notify_inventory_changed()


func check_if_item_at_index_in_inventory_exists(index: int) -> bool:
	if index < 0 or index >= get_inventory_item_ids().size():
		return false

	return true

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

	AllGlobalItemsManager.add_item(entry)
	add_item(entry.item_id)

	print_all_items()

	notify_inventory_changed()


func print_all_items() -> void:
	print("\nInventory Component: Printing all items")

	for item_id in get_inventory_item_ids():
		var item: ItemEntry = AllGlobalItemsManager.get_item_by_id(item_id)

		if item != null:
			item.print_self()

# ===================================================================
# Notify Listner
# ===================================================================

func notify_inventory_changed() -> void:
	SignalBus.save_game.emit()
	
	if inventory_name != Global.PLAYER_INVENTORY_NAME:
		return
	
	print("\nInventory Component: Notified that the player inventory changed.")
	SignalBus.player_inventory_changed.emit()