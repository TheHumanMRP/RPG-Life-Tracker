extends Node2D

# To-Do: Impliment proper selection ui later

func _init() -> void:
	set_global_state()

func _ready() -> void:
	temp()
	
	print("\nDungeon Selection Menu: _ready func called")

func set_global_state() -> void:
	SignalBus.set_game_state.emit(All_Enums.GAME_STATES.DungeonSelectionMenu)

func temp() -> void:
	var path_to_level: String = "res://Folders/Systems/Dungeon_Related/Scenes/level.tscn"

	Global.main_node.switch_to_scene(self, path_to_level, true)
