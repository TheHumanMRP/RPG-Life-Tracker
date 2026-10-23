extends CanvasLayer

# To-Do: Impliment proper selection ui later

func _init() -> void:
	set_global_state()

func _ready() -> void:
	temp()

func set_global_state() -> void:
	SignalBus.set_game_state.emit(All_Enums.GAME_STATES.DungeonSelectionMenu)

func temp() -> void:
	SignalBus.switch_scene.emit(self, Constants.PATH_TO_DUNGEON_SCENE, true)
