class_name DungeonTilemap
extends Resource

@export var name: String
@export var type: All_Enums.DUNGEON_TILEMAP_TYPES
@export var tile_size: Vector2i
@export var tilemap_sheet: Texture2D
@export var tilemap_data: Dictionary[int, Vector2i]

func get_tile_at_id