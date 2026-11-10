extends Node2D

var dungeon_resource: DungeonResource

@export var checkpoint_container: Node
@export var damage_areas_container: Node
@export var dungoen_tilemap: TileMapLayer


func setup(new_dungeon_resource: DungeonResource) -> void:
	dungeon_resource = new_dungeon_resource


func _ready() -> void:
	# Crash if dungeon_resource not present in debug builds.
	# Only in debug builds because assert is removed in export.
	assert(dungeon_resource, "Dungeon Level: No dungeon resource!")

	# For exported builds.
	if not dungeon_resource:
		push_error("Dungeon Level: No dungeon resource!")
		return

	dungoen_tilemap.tile_set = TileSet.new()
	dungoen_tilemap.tile_set.tile_size = dungeon_resource.dungeon_tilemap.tile_size

	_build_tilemap(dungeon_resource.dungeon_tilemap)


# --------------------------------------------------
# Tilemap Building
# --------------------------------------------------

func _build_tilemap(map_data: MapData) -> void:
	var dungeon_tilemap: DungeonTilemap = map_data.map_tiles
	var atlas: TileSetAtlasSource = _create_tilemap_atlas(dungeon_tilemap)

	var source_id: int = dungoen_tilemap.tile_set.add_source(atlas)

	for index in range(map_data.map.size()):
		var tile_id: int = map_data.map[index]

		var map_x: int = index % map_data.map_width

		@warning_ignore("integer_division")
		var map_y: int = index / map_data.map_width

		var map_position := Vector2i(map_x, map_y)

		_place_tile(tile_id, map_position, dungeon_tilemap, source_id)


func _create_tilemap_atlas(dungeon_tilemap: DungeonTilemap) -> TileSetAtlasSource:
	var atlas := TileSetAtlasSource.new()
	atlas.texture = dungeon_tilemap.tilemap_sheet
	atlas.texture_region_size = dungeon_tilemap.tile_size

	for tile_id in dungeon_tilemap.tilemap_data:
		var pixel_position: Vector2i = dungeon_tilemap.tilemap_data[tile_id]
		var atlas_coords: Vector2i = _get_atlas_coords(pixel_position, dungeon_tilemap.tile_size)

		atlas.create_tile(atlas_coords)

	return atlas


func _get_atlas_coords(pixel_position: Vector2i, tile_size: Vector2i) -> Vector2i:
	@warning_ignore("integer_division")
	return pixel_position / tile_size


func _place_tile(
	tile_id: int,
	map_position: Vector2i,
	dungeon_tilemap: DungeonTilemap,
	source_id: int
) -> void:
	if tile_id == 0:
		return

	if not dungeon_tilemap.tilemap_data.has(tile_id):
		push_warning("Unknown tile ID: " + str(tile_id))
		return

	var pixel_position: Vector2i = dungeon_tilemap.tilemap_data[tile_id]
	var atlas_coords: Vector2i = _get_atlas_coords(pixel_position, dungeon_tilemap.tile_size)

	dungoen_tilemap.set_cell(map_position, source_id, atlas_coords)


# --------------------------------------------------
# Checkpoints
# --------------------------------------------------

func _place_checkpoints() -> void:
	var checkpoint_packed_scene: PackedScene = load(Constants.PATH_TO_CHECKPOINT)

	for checkpoint_position in dungeon_resource.checkpoints:
		var checkpoint: Node = checkpoint_packed_scene.instantiate()
		checkpoint.setup(checkpoint_position)
		checkpoint_container.add_child(checkpoint)


# --------------------------------------------------
# Damage Areas
# --------------------------------------------------

func _place_damage_areas() -> void:
	var damage_area_packed_scene: PackedScene = load(Constants.PATH_TO_DAMAGE_AREA)

	for damage_area_resource in dungeon_resource.damage_areas:
		var damage_area: Node = damage_area_packed_scene.instantiate()
		damage_area.setup(damage_area_resource)
		damage_areas_container.add_child(damage_area)
