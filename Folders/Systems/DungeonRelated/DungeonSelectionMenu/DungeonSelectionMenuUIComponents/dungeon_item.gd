extends PanelContainer

var dungeon_resource: DungeonResource

func _ready() -> void:
	assert(dungeon_resource, "Dungeon Item: No Dungeon Resource!")
