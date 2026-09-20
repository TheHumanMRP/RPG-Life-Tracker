extends Node2D

@export var spawn_point: Vector2 = Vector2(0, 0)

@onready var spawn_point_marker: Marker2D

func _init() -> void:
	SignalBus.set_game_state.emit(All_Enums.GAME_STATES.DungeonPlaying)

func _ready() -> void:
	_setup_spawn_point()

	add_player()

func _setup_spawn_point() -> void:
	if has_node("%SpawnPoint"):
		spawn_point = $%SpawnPoint.position

func add_player() -> void:
	var player_packed_scene: PackedScene = load("res://Folders/Systems/Player/player.tscn")

	var player = player_packed_scene.instantiate()

	player.setup(spawn_point)

	add_child(player)