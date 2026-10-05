extends MarginContainer

func _ready() -> void:
	SignalBus.right_click_menu_option_selected.connect(_on_right_click_menu_option_selected)

func _on_right_click_menu_option_selected(option: String) -> void:
	match option:
		"Add Task":
			pass

func _set_propogation() -> void:
	var children: Array[Control] = 