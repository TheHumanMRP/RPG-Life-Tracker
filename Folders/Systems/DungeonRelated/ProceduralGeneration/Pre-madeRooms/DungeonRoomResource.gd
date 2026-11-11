class_name DungeonRoomResource
extends Resource

@export_group("Room Information")
@export var room_name: String

@export_group("Room Dimensions")
@export var map_width: int
@export var map_height: int

@export_group("Room Data")
@export var map: Array[int]
@export var doorways: Array[Vector2i]