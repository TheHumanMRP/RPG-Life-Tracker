extends Resource
class_name InventoryLogic

var inventory_items: Array[BaseItem]

func add_item(new_item_entry: BaseItem) -> void:
	inventory_items.append(new_item_entry)
	SignalBus.inventory_changed.emit()