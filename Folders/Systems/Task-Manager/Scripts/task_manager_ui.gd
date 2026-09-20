extends Control

func _init() -> void:
	SignalBus.set_game_state.emit(All_Enums.GAME_STATES.TaskManager)