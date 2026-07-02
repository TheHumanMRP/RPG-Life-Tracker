class_name SaveCycleManager
extends Node

var save_timer: int = 60

func save_loop() -> void:
	while true:
		await get_tree().create_timer(save_timer).timeout
		
		if Global.save_next:
			_save_data()

func _save_data() -> void:
	Global.save_manager.save_info = Global.save_data
	Global.save_manager.save_data()

func _load_data():
	Global.save_manager.load_data()
	Global.save_data = Global.save_manager.save_info