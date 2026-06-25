class_name Sword
extends BaseItem

var damage_power: int = 10

func _init() -> void:
	type = "sword"

func setup(new_name: String, new_logo: Texture2D) -> void:
	name = new_name
	logo = new_logo

func use(target) -> void:
	if not target.has_method("take_damage"):
		push_error("Sword Item: Target doesn't have method: take_damage")
		return
	
	target.take_damage(damage_power)