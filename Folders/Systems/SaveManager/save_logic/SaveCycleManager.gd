class_name SaveCycleManage
extends Node

var save_timer: int = 60

var save_next: bool

var save_manager: SaveManager = SaveManager.new()

func _init() -> void:
	Global.signal_bus.save_game.connect(toggle_save_next)

	_load_data()

	save_loop()

func toggle_save_next() -> void:
	save_next = true

func save_loop() -> void:
	while true:
		await get_tree().create_timer(save_timer).timeout
		
		if save_next:
			_save_data()
			save_next = false

func _save_data() -> void:
	save_manager.save_info = Global.save_data
	save_manager.save_data()

func _load_data():
	save_manager.load_data()
	Global.save_data = save_manager.save_info

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		_save_data()