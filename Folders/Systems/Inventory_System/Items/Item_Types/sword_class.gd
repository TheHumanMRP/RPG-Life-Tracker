class_name Sword
extends BaseItem

var damage: int = 10

func _init() -> void:
	type = "sword"

func setup(new_name: String, new_logo: Texture2D) -> void:
	name = new_name
	logo = new_logo

func use(target) -> void:
