extends Node2D

@export var spawn_point: Vector2 = Vector2(0, 0)

@onready var spawn_point_marker: Marker2D

func _ready() -> void:
	SignalBus.set_game_state.emit(All_Enums.GAME_STATES.DungeonPlaying)

	_setup_spawn_point()

	add_player()

	_setup_ui_layers()

func _setup_spawn_point() -> void:
	if has_node("%SpawnPoint"):
		spawn_point = $%SpawnPoint.position

func _setup_ui_layers() -> void:
	var packed_ui_layer: PackedScene = load(Constants.PATH_TO_INVENTORY_UI_LAYER)
	var packed_inventory_ui_layer: PackedScene = load(Constants.PATH_TO_INVENTORY_UI_LAYER)
	var packed_death_menu: PackedScene = load(Constants.PATH_TO_DEATH_MENU)

func add_player() -> void:
	var player_packed_scene: PackedScene = load("res://Folders/Systems/Player/player.tscn")

	var player = player_packed_scene.instantiate()

	player.setup(spawn_point)

	add_child(player)