class_name SaveCycleManager
extends Node

var save_timer: int = 60

@onready var save_manager: SaveManager = SaveManager.new()

func _init() -> void:
	SignalBus.save_game.connect(_save_data)

func save_loop() -> void:
	while true:
		await get_tree().create_timer(save_timer).timeout
		
		if Global.save_next:
			_save_data()

func _save_data() -> void:
	save_manager.save_info = Global.save_data
	save_manager.save_data()

func _load_data():
	save_manager.load_data()
	Global.save_data = Global.save_manager.save_info

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		_save_data()
