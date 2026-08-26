class_name SwordClass
extends BaseItem

var damage_power: int = 10

func _init() -> void:
	type = All_Enums.ITEM_TYPES.Weapon
	weapon_type = All_Enums.WEAPON_TYPES.Sword

func setup(new_base_durability: int = base_durability) -> void:
	base_durability = new_base_durability

func use(target) -> void:
	if not target.has_method("take_damage"):
		push_error("Sword Item: Target doesn't have method: take_damage")
		return
	
	target.take_damage(damage_power)
