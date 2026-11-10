extends Node2D

var dungeon_resource: DungeonResource

@export var dungoen_tilemap: TileMapLayer

func setup(new_dungeon_resource: DungeonResource) -> void:
	dungeon_resource = new_dungeon_resource

func _ready() -> void:
	# Crash if dungeon_resource not present in debug builds
	# Only in debug build cause the assert is removed in export
	assert(dungeon_resource, "Dungeon Level: No dungeon resource!")

	# For exported builds
	if not dungeon_resource:
		push_error("Dungeon Level: No dungeon resource!")
		return

	dungoen_tilemap.tile_set = TileSet.new()
	dungoen_tilemap.tile_set.tile_size = dungeon_resource.dungeon_tilemap.tile_size

	_build_tilemap(dungeon_resource.dungeon_tilemap)


func _build_tilemap(map_data: MapData) -> void:
	var loaded_tiles: Dictionary[int, Vector2i] = {}

	for y in range(map_data.map_height):
		for x in range(map_data.map_width):
			var index: int = y * map_data.map_width + x
			var tile_id: int = map_data.map[index]

			if tile_id == 0:
				continue

			var atlas_coords: Vector2i = get_tile(loaded_tiles, tile_id)

			if atlas_coords == Vector2i(-1, -1):
				continue

			dungoen_tilemap.set_cell(
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

	var texture: Texture2D = load(MapData.MAP_TILES[tile_id]) as Texture2D

	if texture == null:
		push_error("Failed to load tile: " + str(tile_id))
		return Vector2i(-1, -1)

	var atlas: TileSetAtlasSource = TileSetAtlasSource.new()
	atlas.texture = texture
	atlas.texture_region_size = dungeon_resource.dungeon_tilemap.tile_size
	atlas.create_tile(Vector2i.ZERO)

	var source_id: int = dungoen_tilemap.tile_set.add_source(atlas)

	var coords: Vector2i = Vector2i(source_id, 0)
	loaded_tiles[tile_id] = Vector2i.ZERO

	return coords

func _place_checkpoints() -> void:
	var checkpoint_packed_scene: PackedScene = load(Constants.PATH_TO_CHECKPOINT)

	for checkpoint in dungeon_resource.checkpoints:
		