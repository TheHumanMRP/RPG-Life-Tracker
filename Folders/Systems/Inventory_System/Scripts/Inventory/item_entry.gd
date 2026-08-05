extends Resource
class_name ItemEntry

@export var item: BaseItem
@export var item_type: BaseItem.Item_Type
@export var durability: float
@export var item_id: int
@export var logo: Texture2D

func setup(new_item: BaseItem, new_logo: Texture2D, new_durability: float = new_item.base_durability):
	item = new_item
	item_type = item.type
	durability = new_durability
	logo = new_logo

func use_item(target) -> void:
	item.use(target)

func print_self() -> void:
	print("\n\t-----ItemEntry [", item.name, "]-----")
	print("\t1. Name: ", item.name)
	print("\t2. Durability: ", durability)
	print("\t3. Item ID: ", item_id)