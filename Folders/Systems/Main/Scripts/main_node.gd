class_name MainNode
extends Node2D

func _ready() -> void:
	self.add_to_group("main_node")

func switch_to_scene(myself: Node, new_scene_path: String, clear_all_children: bool = false) -> void:
	if clear_all_children:
		for child in self.get_children():
			child.queue_free()
    
	if self.get_children().has(myself):
		self.remove_child(myself)
    
	var new_scene: Node = get_new_scene(new_scene_path)

	add_child(new_scene)

func get_new_scene(new_scene_path: String) -> Node:
	var packed_new_scene: PackedScene = load(new_scene_path)

	var new_scene: Node = packed_new_scene.instantiate()

	return new_scene