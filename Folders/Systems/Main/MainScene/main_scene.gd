class_name MainScene
extends Node2D

@export var important_stuff_canvas_layer: CanvasLayer


# ==============================================================================
# LIFECYCLE
# ==============================================================================

func _init() -> void:
	self.add_to_group("main_scene")


func _ready() -> void:
	SignalBus.switch_scene.connect(switch_scenes)

	_add_one_time_scenes()

	SignalBus.popup_conformation_menu.connect(_on_popup_conformation_menu)
	SignalBus.get_text_input_from_user.connect(_on_get_text_input_from_user)


# ==============================================================================
# INITIALIZATION & SETUP
# ==============================================================================

func _add_one_time_scenes() -> void:
	# Search the completed task for explanation why the right click menu works separately than text and conformation input box
	# `Fix the conformation box bug in quit dungeon in death menu` is the name of the task
	_add_right_click_menu()

	_add_online_backup_node()

	_add_backing_up_online_data_loading_scene()


func _add_right_click_menu() -> void:
	var right_click_menu: Node = _get_new_scene(Constants.PATH_TO_RIGHT_CLICK_MENU)
	important_stuff_canvas_layer.add_child(right_click_menu)


func _add_online_backup_node() -> void:
	var online_backup_scene: Node = _get_new_scene(Constants.PATH_TO_ONLINE_BACKUP_SCENE)
	important_stuff_canvas_layer.add_child(online_backup_scene)

func _add_backing_up_online_data_loading_scene() -> void:
	var backing_up_online_data_loading_scene: Node = _get_new_scene(Constants.PATH_TO_BACKING_UP_ONLINE_DATA_LOADING_SCENE)
	important_stuff_canvas_layer.add_child(backing_up_online_data_loading_scene)

# ==============================================================================
# SCENE MANAGEMENT
# ==============================================================================

func switch_scenes(new_scene: Node) -> void:
	_clear_all_children()

	self.add_child(new_scene)

	SignalBus.refresh_ui.emit()


func _clear_all_children() -> void:
	for child in self.get_children():
		if child == important_stuff_canvas_layer:
			continue

		child.queue_free()


func _get_new_scene(new_scene_path: String) -> Node:
	return (load(new_scene_path) as PackedScene).instantiate()


# ==============================================================================
# UI & SIGNAL CALLBACKS
# ==============================================================================

func _on_get_text_input_from_user(question: String, tag: String, request_sender: Node, user_input_placeholder_text: String = "Answer Here") -> void:
	var text_input_box: Node = _get_new_scene(Constants.PATH_TO_TEXT_INPUT_BOX)
	important_stuff_canvas_layer.add_child(text_input_box)
	text_input_box.get_text_input_from_user(question, tag, request_sender, user_input_placeholder_text)


func _on_popup_conformation_menu(request_sender: Node, conformation_textbox_text: String, conform_button_text: String, deny_button_text: String, tag: String) -> void:
	var conformation_input_box: Node = _get_new_scene(Constants.PATH_TO_CONFORMATION_BOX)
	important_stuff_canvas_layer.add_child(conformation_input_box)
	conformation_input_box.popup_conformation_menu(request_sender, conformation_textbox_text, conform_button_text, deny_button_text, tag)
