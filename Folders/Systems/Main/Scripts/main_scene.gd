class_name MainScene
extends Node2D

@export var important_UI_canvas_layer: CanvasLayer

func _init() -> void:
	self.add_to_group("main_scene")

func _ready() -> void:
	SignalBus.switch_scene.connect(switch_scenes)

	SignalBus.popup_right_click_menu.connect(_on_popup_right_click_menu)

func switch_scenes(caller: Node, new_scene_path: String, _clear_children: bool = false) -> void:
	if _clear_children:
		_clear_all_children()
	
	# Remove the caller of the scene change caller regardless
	# of wether clear_children is true or false
	if self.get_children().has(caller):
		self.remove_child(caller)

	var new_scene: Node = _get_new_scene(new_scene_path)

	add_child(new_scene)

func _clear_all_children() -> void:
	for child in self.get_children():
		if child == important_UI_canvas_layer:
			continue

		child.queue_free()

func _get_new_scene(new_scene_path: String) -> Node:
	var packed_new_scene: PackedScene = load(new_scene_path)

	var new_scene: Node = packed_new_scene.instantiate()

	return new_scene

func _on_popup_right_click_menu(request_sender: Node, list_of_options: Array[String], mouse_position: Vector2) -> void:
	var right_click_menu: Node = _get_new_scene(Constants.PATH_TO_RIGHT_CLICK_MENU)

	right_click_menu.popup_right_click_menu(request_sender, list_of_options, mouse_position)

	important_UI_canvas_layer.add_child(right_click_menu)

func _on_get_text_input_from_user(question: String, tag: String, request_sender: Node, user_input_placeholder_text: String = "Answer Here") -> void:
	var text_input_box: Node = _get_new_scene(Constants.PATH_TO_TEXT_INPUT_BOX)

	text_input_box.get_text_input_from_user(question, tag, request_sender, user_input_placeholder_text)

	important_UI_canvas_layer.add_child(text_input_box)

func _on_popup_conformation_menu(request_sender: Node, conformation_textbox_text: String, conform_button_text: String, deny_button_text: String, tag: String) -> void:
	var conformation_input_box: Node = _get_new_scene(Constants.PATH_TO_CONFORMATION_BOX)

	conformation_input_box.popup_conformation_menu(request_sender, conformation_textbox_text, conform_button_text, deny_button_text, tag)

	important_UI_canvas_layer.add_child(conformation_input_box)
