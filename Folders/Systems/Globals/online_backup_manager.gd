extends Node

var number_of_offline_saves_done: int

func _ready() -> void:
	SignalBus.offline_save_completed.connect(_on_offline_save_completed)

func _on_offline_save_completed() -> void:
	number_of_offline_saves_done += 1

	if number_of_offline_saves_done >= 10:
		SignalBus.upload_save.emit()
		number_of_offline_saves_done
		
