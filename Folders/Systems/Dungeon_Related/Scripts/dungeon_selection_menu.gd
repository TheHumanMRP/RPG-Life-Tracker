extends Node2D

# To-Do: Impliment proper selection ui later

func _ready() -> void:
	temp()
	
	# set_global_state()
	
	print("\nDungeon Selection Menu: _ready func called")

func set_global_state() -> void:
	Global.signal_bus.set_game_state.emit(All_Enums.GAME_STATES.UIMenu)

func temp() -> void:
	var packed_level: PackedScene = load("res://Folders/Systems/Dungeon_Related/Scenes/level.tscn")

	var level: Node = packed_level.instantiate()

	self.add_child(level)
