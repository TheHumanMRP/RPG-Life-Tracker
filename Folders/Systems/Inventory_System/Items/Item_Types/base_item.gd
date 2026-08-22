extends Resource
class_name BaseItem

# Naming of the vars should be in snake_case
@export var base_durability: int = 100 # Used to initialise a new item
@export var type: All_Enums.ITEM_TYPES = All_Enums.ITEM_TYPES.Item # Should only be used for verification that the item's type is correct
@export var weapon_type: All_Enums.WEAPON_TYPE = All_Enums.WEAPON_TYPE.None

func use(target) -> void:
	pass