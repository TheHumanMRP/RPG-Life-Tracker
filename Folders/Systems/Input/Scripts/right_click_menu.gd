class_name RightClickMenu
extends PopupMenu

var current_request_sender: Node = null

func _init() -> void:
	self.add_to_group("right_click_menu")

func _ready() -> void:
	self.hide()
	self.index_pressed.connect(_on_index_pressed)

func popup_right_click_menu(request_sender: Node, list_of_options: Array[String], mouse_position: Vector2) -> void:
	current_request_sender = request_sender

	# Clear the existing options 
	self.clear()

	# Add all the options
	for option in list_of_options:
		self.add_item(option)
	
	self.position = mouse_position

	# Popup the menu
	self.popup()

func _on_index_pressed(index: int) -> void:
	var selected_option: String = self.get_item_text(index)

	SignalBus.right_click_menu_option_selected.emit(current_request_sender, selected_option)

	current_request_sender = null

	self.queue_free()