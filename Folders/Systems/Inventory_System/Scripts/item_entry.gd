extends Resource
class_name ItemEntry

var item: BaseItem
var durability: int
var item_id: int
var logo: Texture2D

func setup(new_item: BaseItem, new_durability: int, new_logo: Texture2D):
	item = new_item
	durability = new_durability

func use_item(target) -> void:
	item.use(target)
