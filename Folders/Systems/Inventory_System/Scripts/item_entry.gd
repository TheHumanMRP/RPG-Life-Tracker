extends Resource
class_name ItemEntry

@export var item: BaseItem
@export var durability: float
@export var item_id: int
@export var logo: Texture2D

func setup(new_item: BaseItem, new_durability: float, new_logo: Texture2D):
	item = new_item
	durability = new_durability
	logo = new_logo

func use_item(target) -> void:
	item.use(target)

func print_self() -> void:
	print("\n-----ItemEntry [", item.name, "]")