extends Resource
class_name BaseItem

# Naming of the vars should be in snake_case

@export var name: String = "base_item" # Should only be used for ui, not in any way for andy logic
@export var type: String = "base_item" # Used to make sure that only the correct item gets accepted into the inventory slot
									   # basically oor filteration purpose
@export var base_durability: int = 100 # Used to initialise a new item

func use(target) -> void:
	pass

func equip() -> void:
	pass