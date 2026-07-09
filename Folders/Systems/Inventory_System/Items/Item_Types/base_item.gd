extends Resource
class_name BaseItem

# Naming of the vars should be in snake_case

@export var name: String = "base_item" # Should only be used for ui, not in any way for andy logic
@export var base_durability: int = 100 # Used to initialise a new item
@export var type: String = "base_item" # Should only be used for verification that the item's type is correct

enum Item_Types {
	HELMET,
	CHESTPLATE,
	LEGGINGS,
	BOOTS,
	WEAPON,
	BASE
}

func get_type() -> String:
	return "base_item"

func use(target) -> void:
	pass