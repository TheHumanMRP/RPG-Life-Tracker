class_name DungeonTilemap
extends Resource

@export var name: String
@export var type: All_Enums.DUNGEON_TILEMAP_TYPES
@export var tile_size: Vector2i
@export var tilemap_sheet: Texture2D
@export var tilemap_data: Dictionary[int, Vector2i]

func get_tile_at_id(tile_id: int) -> Texture2D:
	if not tilemap_data.has(tile_id):
		return null

	var atlas_texture := AtlasTexture.new()
	atlas_texture.atlas = tilemap_sheet
	atlas_texture.region = Rect2(
		tilemap_data[tile_id],
		tile_size
	)

	return atlas_texture