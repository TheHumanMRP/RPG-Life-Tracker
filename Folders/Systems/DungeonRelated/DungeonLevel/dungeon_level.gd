extends TileMapLayer

const TILE_SIZE := Vector2i(32, 32)

var dungeon_resource: DungeonResource

func setup(new_dungeon_resource: DungeonResource) -> void:
	dungeon_resource = new_dungeon_resource

func _ready() -> void:
	tile_set = TileSet.new()
	tile_set.tile_size = TILE_SIZE

	var new_map_data = MapData.new()
	
	new_map_data.setup(1, 1, [1])

	build_tilemap(new_map_data)


func build_tilemap(map_data: MapData) -> void:
	var loaded_tiles: Dictionary[int, Vector2i] = {}

	for y in range(map_data.map_height):
		for x in range(map_data.map_width):
			var index := y * map_data.map_width + x
			var tile_id := map_data.map[index]

			if tile_id == 0:
				continue

			var atlas_coords := get_tile(loaded_tiles, tile_id)

			if atlas_coords == Vector2i(-1, -1):
				continue

			set_cell(
				Vector2i(x, y),
				0,
				atlas_coords
			)


func get_tile(loaded_tiles: Dictionary[int, Vector2i], tile_id: int) -> Vector2i:
	if loaded_tiles.has(tile_id):
		return loaded_tiles[tile_id]

	if not MapData.MAP_TILES.has(tile_id):
		push_warning("Unknown tile ID: " + str(tile_id))
		return Vector2i(-1, -1)

	var texture := load(MapData.MAP_TILES[tile_id]) as Texture2D

	if texture == null:
		push_error("Failed to load tile: " + str(tile_id))
		return Vector2i(-1, -1)

	var atlas := TileSetAtlasSource.new()
	atlas.texture = texture
	atlas.texture_region_size = TILE_SIZE
	atlas.create_tile(Vector2i.ZERO)

	var source_id := tile_set.add_source(atlas)

	var coords := Vector2i(source_id, 0)
	loaded_tiles[tile_id] = Vector2i.ZERO

	return coords