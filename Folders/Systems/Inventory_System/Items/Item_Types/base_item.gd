extends Resource
class_name BaseItem

@export var base_durability: int = 100
@export var type: All_Enums.ITEM_TYPES = All_Enums.ITEM_TYPES.Item
@export var weapon_type: All_Enums.WEAPON_TYPE = All_Enums.WEAPON_TYPE.None

func use(target) -> void:
	pass