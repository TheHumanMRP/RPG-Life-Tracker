extends Resource
class_name MapData

@export var tile_size: Vector2i
@export var map_width: int
@export var map_height: int
@export var map: Array[int]

const MAP_TILES: Dictionary[int, String] = {
	1: "res://Folders/Assets/Player-Front.png",

}
