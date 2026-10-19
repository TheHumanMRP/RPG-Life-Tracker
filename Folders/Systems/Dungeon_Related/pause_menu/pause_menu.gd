extends CanvasLayer

@export var respawn_button: Button
@export var quit_dungeon_button: Button

var opened: bool = false

func _ready() -> void:
	setup_properties()

	setup_signals()

func setup_signals() -> void:
	respawn_button.pressed.connect(_on_respawn_button_pressed)
	quit_dungeon_button.pressed.connect(_on_quit_dungeon_button_pressed)
	
	SignalBus.conformation_menu_option_selected.connect(_on_conformation_menu_option_selected)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("open_pause_menu") and not opened:
		_set_visibility(true)

func _set_visibility(_visible: bool) -> void:
	if _visible:
		self.show()
		opened = true
		return
	
	self.hide()
	opened = false

func setup_properties() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	_set_visibility(false)

func _on_respawn_button_pressed() -> void:
	SignalBus.popup_conformation_menu.emit(self, "Are you sure you want to respawn?", "Yes", "No", "respawn_conformation")

func _respawn_player() -> void:
	SignalBus.respawn_player.emit()

	set_global_state_dungeon_playing()

	_set_visibility(false)

	print("\nDeath Menu: Respawn Button Pressed")

func _on_quit_dungeon_button_pressed() -> void:
	SignalBus.popup_conformation_menu.emit(self, "Are you sure you want to quit the dungeon?", "Yes", "No", "quit dungeon")

func set_global_state_pause_menu() -> void:
	SignalBus.set_game_state.emit(All_Enums.GAME_STATES.DeathMenu)

func set_global_state_dungeon_playing() -> void:
	SignalBus.set_game_state.emit(All_Enums.GAME_STATES.DungeonPlaying)

func _on_conformation_menu_option_selected(request_sender: Node, conformed: bool, tag: String) -> void:
	if request_sender != self:
		return
	
	if not conformed:
		return
	
	match tag:
		"quit dungeon":
			SignalBus.switch_scene.emit(self, Constants.PATH_TO_MAIN_MENU, true)

		"respawn_conformation":
			_respawn_player()
