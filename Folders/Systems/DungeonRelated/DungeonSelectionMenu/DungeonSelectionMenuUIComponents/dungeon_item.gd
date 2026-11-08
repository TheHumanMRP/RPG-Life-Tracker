extends PanelContainer

signal dungeon_item_pressed(selected_dungeon_resource: DungeonResource)

@export var dungeon_name_label: Label
@export var play_button: Button

var dungeon_resource: DungeonResource

func _ready() -> void:
	# Crash if dungeon_resource not present in debug builds
	assert(dungeon_resource, "Dungeon Item: No Dungeon Resource!")

	play_button.pressed.connect(_on_play_button_pressed)

	SignalBus.conformation_menu_option_selected.connect(_on_conformation_menu_option_selected)


func refresh(new_dungeon_resource: DungeonResource) -> void:
	dungeon_resource = new_dungeon_resource

	_refresh_ui()

func _refresh_ui() -> void:
	dungeon_name_label.text = dungeon_resource.dungeon_name

func _on_play_button_pressed() -> void:
	var conformation_textbox_text: String = "Are you sure you want to play the dungeon: " + dungeon_resource.dungeon_name

	SignalBus.popup_conformation_menu.emit(self, conformation_textbox_text, "Yes", "No", "Play Dungeon")

func _on_conformation_menu_option_selected() -> void:
	pass