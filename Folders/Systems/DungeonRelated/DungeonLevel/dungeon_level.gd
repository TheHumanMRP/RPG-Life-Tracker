extends Node2D

var dungeon_resource: DungeonResource

@export var checkpoint_container: Node
@export var damage_areas_container: Node
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
	var dungeon_tilemap: DungeonTilemap = map_data.map_tiles

	var atlas: TileSetAtlasSource = TileSetAtlasSource.new()
	atlas.texture = dungeon_tilemap.tilemap_sheet
	atlas.texture_region_size = dungeon_tilemap.tile_size

	# Register all available tiles in the atlas.
	for tile_id in dungeon_tilemap.tilemap_data:
		var pixel_position: Vector2 = dungeon_tilemap.tilemap_data[tile_id]

		var atlas_coords: Vector2 = pixel_position / dungeon_tilemap.tile_size

		atlas.create_tile(atlas_coords)

	var source_id: int = dungoen_tilemap.tile_set.add_source(atlas)

	# Place tiles according to MapData.
	for y in range(map_data.map_height):
		for x in range(map_data.map_width):
			var index: int = y * map_data.map_width + x
			var tile_id: int = map_data.map[index]

			if tile_id == 0:
				continue

			if not dungeon_tilemap.tilemap_data.has(tile_id):
				push_warning("Unknown tile ID: " + str(tile_id))
				continue

			var pixel_position: Vector2i = dungeon_tilemap.tilemap_data[tile_id]
			var atlas_coords: Vector2i = pixel_position / dungeon_tilemap.tile_size

			dungoen_tilemap.set_cell(
				Vector2i(x, y),
				source_id,
				atlas_coords
			)

func _place_checkpoints() -> void:
	var checkpoint_packed_scene: PackedScene = load(Constants.PATH_TO_CHECKPOINT)

	for checkpoint_position in dungeon_resource.checkpoints:
		var checkpoint: Node = checkpoint_packed_scene.instantiate()

		checkpoint.setup(checkpoint_position)

		checkpoint_container.add_child(checkpoint)

func _place_damage_areas() -> void:
	var damage_area_packed_scene: PackedScene = load(Constants.PATH_TO_DAMAGE_AREA)

	for damage_area_resource in dungeon_resource.damage_areas:
		var damage_area: Node = damage_area_packed_scene.instantiate()

		damage_area.setup(damage_area_resource)

		damage_areas_container.add_child(damage_area)