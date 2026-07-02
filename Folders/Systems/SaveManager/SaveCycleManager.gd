class_name SaveCycleManager

func _save_data() -> void:
	Global.save_manager.save_info = Global.save_data
	Global.save_manager.save_data()

func _load_data():
	Global.save_manager.load_data()
	Global.save_data = Global.save_manager.save_info