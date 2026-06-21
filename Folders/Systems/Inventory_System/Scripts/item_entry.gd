extends Resource
class_name ItemEntry

var item: BaseItem
var durability: int
var item_id: int

func setup(new_item: BaseItem, new_durability: int):
	item = new_item
	durability = new_durability

func use_item() -> void:
	item.use()