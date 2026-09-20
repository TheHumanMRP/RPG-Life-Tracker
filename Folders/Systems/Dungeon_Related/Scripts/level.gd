extends Node2D

@export var spawn_point: Vector2 = Vector2(0, 0)

@onready var spawn_point_marker: Marker2D

func _init() -> void:
	SignalBus.set_game_state.emit(All_Enums.GAME_STATES.DungeonPlaying)

func _ready() -> void:
	_setup_spawn_point()

	add_player()

	# _setup_ui_layers()

func _setup_spawn_point() -> void:
	if has_node("%SpawnPoint"):
		spawn_point = $%SpawnPoint.position

func _setup_ui_layers() -> void:
	var ui_layer: Node = load(Constants.PATH_TO_UILAYER_SCENE).instantiate()
	var inventory_ui_layer: Node = load(Constants.PATH_TO_INVENTORY_UI_LAYER).instantiate()
	# var death_menu: Node = load(Constants.PATH_TO_DEATH_MENU).instantiate()

	self.add_child(ui_layer)
	self.add_child(inventory_ui_layer)
	# self.add_child(death_menu)


func add_player() -> void:
	var player_packed_scene: PackedScene = load("res://Folders/Systems/Player/player.tscn")

	var player = player_packed_scene.instantiate()

	player.setup(spawn_point)

	add_child(player)