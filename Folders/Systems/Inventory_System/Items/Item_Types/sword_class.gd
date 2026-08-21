class_name Sword
extends BaseItem

var damage_power: int = 10

func setup(new_logo: Texture2D = null, new_base_durability: int = base_durability) -> void:
	base_durability = new_base_durability
	type = All_Enums.ITEM_TYPES.Item

func use(target) -> void:
	if not target.has_method("take_damage"):
		push_error("Sword Item: Target doesn't have method: take_damage")
		return
	
	target.take_damage(damage_power)
