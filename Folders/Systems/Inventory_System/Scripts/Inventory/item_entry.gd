extends Resource
class_name ItemEntry

@export var item: BaseItem
@export var name: String
@export var item_type: All_Enums.ITEM_TYPES
@export var durability: float
@export var item_id: int
@export var logo: Texture2D

func setup(new_item: BaseItem, new_name: String, new_logo: Texture2D, new_durability: float = new_item.base_durability):
	item = new_item
	name = new_name
	item_type = item.type
	durability = new_durability
	logo = new_logo

func use_item(target) -> void:
	item.use(target)

func print_self() -> void:
	print("\n\t", item_id, ".-----ItemEntry [", name, "]-----")
	print("\tName: ", name)
	print("\tDurability: ", durability)
	print("\tItem ID: ", item_id)