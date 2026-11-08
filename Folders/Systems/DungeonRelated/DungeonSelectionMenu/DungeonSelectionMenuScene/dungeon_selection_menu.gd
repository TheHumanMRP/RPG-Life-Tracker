extends CanvasLayer

# To-Do: Impliment proper selection ui later

func _init() -> void:
	_set_global_state()

func _ready() -> void:
	_refresh_ui()

func _set_global_state() -> void:
	SignalBus.set_game_state.emit(All_Enums.GAME_STATES.DungeonSelectionMenu)

func _refresh_ui() -> void:
	