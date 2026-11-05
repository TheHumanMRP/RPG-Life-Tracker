class_name InventoryManager
extends Resource

# ===================================================================
# Ensure Dict Entry
# ===================================================================

func setup(inventory_name: String) -> void:
	if get_inventory_dict().has(inventory_name):
		return
	
	get_inventory_dict()[inventory_name] = []

# ===================================================================
# Getters
# ===================================================================

func get_inventory_item_ids(inventory_name: String) -> Array[int]:
	var inventory_item_ids: Array = get_inventory_dict()[inventory_name] as Array

	return inventory_item_ids

func get_inventory_dict() -> Dictionary:
	return Global.save_data.inventory_items_data.all_inventories

# ===================================================================
# Inventory Operations
# ===================================================================
## Adds an already-globally-registered item to this inventory by its id.
func add_item(inventory_name: String, item_id: int) -> void:
	if get_inventory_item_ids(inventory_name).has(item_id):
		push_error("InventoryComponent: Item already in this inventory: ", item_id)
		return

	if Global.all_global_items_manager.get_item_by_id(item_id) == null:
		return

	get_inventory_item_ids(inventory_name).append(item_id)

	notify_inventory_changed(inventory_name)


## Removes an item's reference from this inventory. The item itself stays
## registered in the global item manager (e.g. for dropping/transferring).
func remove_item(inventory_name: String, item_id: int) -> void:
	for i in get_inventory_item_ids(inventory_name).size():
		if get_inventory_item_ids(inventory_name)[i] != item_id:
			continue

		get_inventory_item_ids(inventory_name).pop_at(i)
		notify_inventory_changed(inventory_name)
		return

	push_error("InventoryComponent: Item not found in this inventory: ", item_id)


## Uses an item that belongs to this inventory.
func use_item(inventory_name: String, item_id: int, target: Node) -> void:
	var item: ItemEntry = Global.all_global_items_manager.get_item_by_id(item_id)

	if item == null:
		return

	item.use_item(target)

	notify_inventory_changed(inventory_name)


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
	var new_test_sword_item_id: int = Global.all_global_items_manager.add_test_sword()

	add_item(new_test_sword_item_id)


func print_all_items() -> void:
	print("\nInventory Component: Printing all items")

	for item_id in get_inventory_item_ids():
		var item: ItemEntry = Global.all_global_items_manager.get_item_by_id(item_id)

		if item != null:
			item.print_self()

# ===================================================================
# Notify Listner
# ===================================================================

func notify_inventory_changed(inventory_name: String) -> void:
	Global.signal_bus.save_game.emit()
	
	if inventory_name != Global.PLAYER_INVENTORY_NAME:
		return
	
	print("\nInventory Component: Notified that the player inventory changed.")
	Global.signal_bus.player_inventory_changed.emit()
