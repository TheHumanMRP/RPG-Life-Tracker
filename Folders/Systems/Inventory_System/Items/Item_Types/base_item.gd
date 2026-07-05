extends Resource
class_name BaseItem

# Naming of the vars should be in snake_case

@export var name: String = "base_item" # Should only be used for ui, not in any way for andy logic
@export var base_durability: int = 100 # Used to initialise a new item

func get_type() -> String:
	return "base_item"

func use(target) -> void:
	pass

func item_selected() -> void:
	pass