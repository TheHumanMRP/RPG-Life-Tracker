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
	
	var dungeon_levels: Array[DungeonResource] = InfoGetter.get_save_data().dungeon_save_data.dungeon_levels

	var dungeon_item_packed_scene: PackedScene = load(Constants.PATH_TO_DUNGEON_ITEM)

	for dungeon_level in dungeon_levels:
		_add_dungeon_item_entry(dungeon_item_packed_scene)

func _add_dungeon_item_entry(dungeon_item_packed_scene: PackedScene) -> void:
	