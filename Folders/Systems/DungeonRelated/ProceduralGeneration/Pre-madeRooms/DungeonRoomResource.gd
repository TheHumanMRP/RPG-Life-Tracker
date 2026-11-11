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

func is_valid() -> bool:
    if map_width <= 0 or map_height <= 0:
        return false

    if map.size() != map_width * map_height:
        return false

    for doorway in doorways:
        if doorway.x < 0 or doorway.x >= map_width:
            return false

        if doorway.y < 0 or doorway.y >= map_height:
            return false

    return true