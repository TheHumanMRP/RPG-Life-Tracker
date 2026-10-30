extends Node

var number_of_offline_saves_done: int
var number_of_saves_before_upload: int

func _ready() -> void:
	SignalBus.offline_save_completed.connect(_on_offline_save_completed)

func _on_offline_save_completed() -> void:
	var save_data SaveData = InfoGetter.get_save_data().online_backup_settings

	InfoGetter.get_save_data().online_backup_settings.number_of_offline_saves_done += 1

	if not number_of_offline_saves_done >= number_of_saves_before_upload:

		return
	
	SignalBus.upload_save.emit()
	number_of_offline_saves_done = 0