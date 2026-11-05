extends CanvasLayer

# Just here cause IDK why but the init of task_manage_ui doesn't get called 
# and that's way too late for setting game state
func _init() -> void:
	SignalBus.set_game_state.emit(All_Enums.GAME_STATES.TaskManager)