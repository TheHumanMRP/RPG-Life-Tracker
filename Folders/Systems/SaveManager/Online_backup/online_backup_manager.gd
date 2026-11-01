extends Node
class_name OnlineBackupManager

func _init() -> void:
	SignalBus.set_online_backup_setting.connect(_on_set_online_backup_setting)

func _on_set_online_backup_setting(setting: All_Enums.ONLINE_BACKUP_SETTINGS, new_value: String) -> void:
	
	
	match setting:
		All_Enums.ONLINE_BACKUP_SETTINGS.ApiUrl:
