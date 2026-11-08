extends PanelContainer

@export var dungeon_name_label: Label

var dungeon_resource: DungeonResource

func _ready() -> void:
	# Crash if dungeon_resource not present in debug builds
	assert(dungeon_resource, "Dungeon Item: No Dungeon Resource!")


func refresh(new_dungeon_resource: DungeonResource) -> void:
	dungeon_resource = new_dungeon_resource

	_refresh_ui()

func _refresh_ui() -> void:
	dungeon_name_label.text = dungeon_resource.dungeon_name