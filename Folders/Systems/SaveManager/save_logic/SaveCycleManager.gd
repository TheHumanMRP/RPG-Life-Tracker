extends Node

var save_timer: int = 60

var save_next: bool

var save_manager: SaveManagerLogic = SaveManagerLogic.new()

var save_time_tick: TimeTick = TimeTick.new()

func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS

	SignalBus.save_game.connect(_on_save_game)
	SignalBus.quit_game.connect(_on_quit_game)

	save_time_tick.initialize(60.0)

	save_time_tick.tick_updated

	_load_data()

	save_loop()

func _on_save_time_tick_updated(_current_tick: int) -> void:
	

func _on_save_game() -> void:
	print("Save Cycle Manager: Save Game signal received.")
	save_next = true		

func _save_data() -> void:
	save_manager.save_data(Global.save_data)

func _load_data():
	Global.save_data = save_manager.load_data()

func _on_quit_game() -> void:
	save_manager.save_data(Global.save_data)
	get_tree().quit()

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		_save_data()
