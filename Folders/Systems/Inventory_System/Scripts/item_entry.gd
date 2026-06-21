extends Resource
class_name ItemEntry

var item: BaseItem
var durability: int

func setup(new_item: BaseItem):
	item = new_item
	