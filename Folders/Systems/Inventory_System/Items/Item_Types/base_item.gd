extends Resource
class_name BaseItem

# Naming of the vars should be in snake_case
@export var base_durability: int = 100 # Used to initialise a new item
@export var type: All_Enums.Item_Type = All_Enums.Item_Type.BASE_ITEM # Should only be used for verification that the item's type is correct

func use(target) -> void:
	pass