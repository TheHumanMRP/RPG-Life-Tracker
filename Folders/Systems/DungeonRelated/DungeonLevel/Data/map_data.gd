extends Resource
class_name MapData

@export var map_width: int
@export var map_height: int
@export var map: Array[int]

func setup(new_map_width: int, new_map_height: int, new_map: Array[int]) -> void:
	map_width = new_map_width
	map_height = new_map_height
	map = new_map

const MAP_TILES: Dictionary[int, String] = {
	1: "res://Folders/Assets/Player-Front.png",

}
