class_name MainScene
extends Node2D

@export var right_click_menu: RightClickMenu

func _init() -> void:
	self.add_to_group("main_scene")

func _ready() -> void:
	SignalBus.switch_scene.connect(switch_to_scene)

func switch_to_scene(caller: Node, new_scene_path: String, clear_all_children: bool = false) -> void:
	if clear_all_children:
		clear_all_children()
	
	if self.get_children().has(caller):
		self.remove_child(caller)
	
	var new_scene: Node = get_new_scene(new_scene_path)

	add_child(new_scene)

func clear_all_children() -> void:
	for child in self.get_children():
		if child == right_click_menu:
			continue
		
		child.queue_free()

func get_new_scene(new_scene_path: String) -> Node:
	var packed_new_scene: PackedScene = load(new_scene_path)

	var new_scene: Node = packed_new_scene.instantiate()

	return new_scene
