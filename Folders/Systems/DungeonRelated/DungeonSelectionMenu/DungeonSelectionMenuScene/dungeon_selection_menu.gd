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
		