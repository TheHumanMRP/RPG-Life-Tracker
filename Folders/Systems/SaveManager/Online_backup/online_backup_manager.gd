extends Node
class_name OnlineBackupManager

func _init() -> void:
	SignalBus.set_online_backup_setting.connect()

func _on_online_backup_setting()