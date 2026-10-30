extends Node

func _ready() -> void:
	SignalBus.offline_save_completed.connect(_on_offline_save_completed)

func _on_offline_save_completed() -> void:
	var online_backup_settings: OnlineBackupSettings = InfoGetter.get_save_data().online_backup_settings

	online_backup_settings.number_of_offline_saves_done += 1

	if not (online_backup_settings.number_of_offline_saves_done >= online_backup_settings.number_of_saves_before_upload):
		return
	
	SignalBus.upload_save.emit()
	online_backup_settings.number_of_offline_saves_done = 0