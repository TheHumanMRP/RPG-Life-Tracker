extends MarginContainer

func _ready() -> void:
	SignalBus.right_click_menu_option_selected.connect(_on_right_click_menu_option_selected)
	_set_mouse_filter()

func _on_right_click_menu_option_selected(option: String) -> void:
	match option:
		"Add Task":
			pass

func _set_mouse_filter() -> void:
	self.mouse_filter = Control.MOUSE_FILTER_STOP

	var children: Array[Control] = self.get_children() as Array[Control]

	for child in children:
		child.mouse_filter = Control.MOUSE_FILTER_PASS