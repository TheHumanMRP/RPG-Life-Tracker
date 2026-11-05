extends Node
class_name OnlineBackupManager

func _init() -> void:
	SignalBus.set_online_backup_setting.connect(_on_set_online_backup_setting)

func _on_set_online_backup_setting(setting: All_Enums.ONLINE_BACKUP_SETTINGS, new_value: String) -> void:
	var settings: OnlineBackupSettings = InfoGetter.get_save_data().online_backup_settings

	match setting:
		All_Enums.ONLINE_BACKUP_SETTINGS.CodebergToken:
			settings.CODEBERG_TOKEN = new_value
		All_Enums.ONLINE_BACKUP_SETTINGS.User_Name:
			settings.USER_NAME = new_value
		All_Enums.ONLINE_BACKUP_SETTINGS.Repository:
			settings.REPOSITORY = new_value
		All_Enums.ONLINE_BACKUP_SETTINGS.File_Name:
			settings.FILE_NAME = new_value
	
	SignalBus.save_game.emit()