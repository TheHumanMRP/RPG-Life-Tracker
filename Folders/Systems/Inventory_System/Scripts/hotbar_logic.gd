class_name HotBarLogic
extends Resource

const EMPTY_HOTBAR_SLOT: int = -1

@export var hotbar_slots: Array[int] = [
	-1, -1, -1, -1,
	-1, -1, -1, -1,
	-1
]

func reset_hotbar_slots() -> void:
	hotbar_slots.clear()

	while hotbar_slots.size() < Global.number_of_hotbar_slots:
		hotbar_slots.append(EMPTY_HOTBAR_SLOT)