extends PanelContainer

var dungeon_resource: DungeonResource

func _ready() -> void:
	# Crash if dungeon_resource not present in debug builds
	assert(dungeon_resource, "Dungeon Item: No Dungeon Resource!")


func refresh(new_dungeon_resource: DungeonResource) -> void:
	dungeon_resource = new_dungeon_resource

	