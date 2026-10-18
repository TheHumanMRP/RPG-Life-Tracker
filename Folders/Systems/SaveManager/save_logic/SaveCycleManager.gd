extends Node

var save_timer: int = 60

var save_next: bool

var save_manager: SaveManagerLogic = SaveManagerLogic.new()

var time_tick : TimeTick = TimeTick.new()

func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS

	SignalBus.save_game.connect(_on_save_game)
	SignalBus.quit_game.connect(_on_quit_game)

	_load_data()

	save_loop()

func _on_save_game() -> void:
	print("Save Cycle Manager: Save Game signal received.")
	save_next = true

func save_loop() -> void:
	while true:
		await get_tree().create_timer(save_timer).timeout
		
		if save_next:
			_save_data()
			save_next = false

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
