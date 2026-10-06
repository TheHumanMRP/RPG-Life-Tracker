class_name MainScene
extends Node2D

@export var right_click_menu: RightClickMenu

func _init() -> void:
	self.add_to_group("main_scene")

func _ready() -> void:
	SignalBus.switch_scene.connect(switch_scenes)

func switch_scenes(caller: Node, new_scene_path: String, _clear_children: bool = false) -> void:
	if _clear_children:
		_clear_all_children()
	
	# Remove the caller of the scene change caller regardless
	# of wether clear_all_children is true or false
	if self.get_children().has(caller):
		self.remove_child(caller)

	var new_scene: Node = _get_new_scene(new_scene_path)

	add_child(new_scene)

func _clear_all_children() -> void:
	for child in self.get_children():
		# Don't remove the needed scenes
		if child == right_click_menu:
			continue
		
		child.queue_free()

func _get_new_scene(new_scene_path: String) -> Node:
	var packed_new_scene: PackedScene = load(new_scene_path)

	var new_scene: Node = packed_new_scene.instantiate()

	return new_scene
