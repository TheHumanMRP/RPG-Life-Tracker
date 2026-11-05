extends CanvasLayer

# To-Do: Impliment proper selection ui later

func _init() -> void:
	set_global_state()

func _ready() -> void:
	pass

func set_global_state() -> void:
	SignalBus.set_game_state.emit(All_Enums.GAME_STATES.DungeonSelectionMenu)