extends CanvasLayer

@export var dungeon_items_container: VBoxContainer

func _init() -> void:
	_set_global_state()

func _ready() -> void:
	_refresh_ui()

func _set_global_state() -> void:
	SignalBus.set_game_state.emit(All_Enums.GAME_STATES.DungeonSelectionMenu)

func _refresh_ui() -> void:
	for child in dungeon_items_container.get_children():
		child.queue_free()
	
	# Remove the test data later
	var dungeon_levels: Array[DungeonResource] = _get_dungeon_level()

	var dungeon_item_packed_scene: PackedScene = load(Constants.PATH_TO_DUNGEON_ITEM)

	for dungeon_level in dungeon_levels:
		_add_dungeon_item_entry(dungeon_item_packed_scene, dungeon_level)

func _add_dungeon_item_entry(dungeon_item_packed_scene: PackedScene, dungoen_level: DungeonResource) -> void:
	var dungeon_item_scene: Node = dungeon_item_packed_scene.instantiate()

	dungeon_item_scene.setup(dungoen_level)

	dungeon_item_scene.dungeon_item_pressed.connect(_on_dungeon_item_selected)

	dungeon_items_container.add_child(dungeon_item_scene)

func _get_dungeon_level() -> Array[DungeonResource]:
	var dungeon_level: DungeonResource = DungeonResource.new()

	dungeon_level.dungeon_name = "Hello"

	var dungeon_levels: Array[DungeonResource] = [dungeon_level]

	return dungeon_levels

	# return InfoGetter.get_save_data().dungeon_save_data.dungeon_levels

func _on_dungeon_item_selected(selected_dungeon_resource: DungeonResource) -> void:
	_add_dungeon_level(selected_dungeon_resource)

func _add_dungeon_level(selected_dungeon_resource: DungeonResource) -> void:
	