extends MarginContainer

# ==============================================
# Initialize
# ==============================================
func _ready() -> void:
	SignalBus.right_click_menu_option_selected.connect(_on_right_click_menu_option_selected)
	SignalBus.text_input_submitted_by_user.connect(_on_text_input_submitted_by_user)
	_set_mouse_filter()

# ==============================================
# Setup
# ==============================================
func _set_mouse_filter() -> void:
	self.mouse_filter = Control.MOUSE_FILTER_STOP

	var children: Array[Node] = self.get_children()

	for child in children:
		child.mouse_filter = Control.MOUSE_FILTER_PASS

# ==============================================
# Handle Input
# ==============================================	
func _gui_input(event: InputEvent) -> void:
	_detect_right_mouse_click(event)

func _detect_right_mouse_click(event: InputEvent) -> void:
	if event is not InputEventMouseButton:
		return

	# Check if it's the right mouse button and it was just pressed down
	if event.button_index != MOUSE_BUTTON_RIGHT or not event.pressed:
		return
	
	_open_right_click_menu()

func _open_right_click_menu() -> void:
	SignalBus.popup_right_click_menu.emit(self, Constants.TASK_MANAGER_RIGHT_CLICK_MENU_OPTIONS, get_global_mouse_position())

func _on_right_click_menu_option_selected(request_sender: Node, option: String) -> void:
	if request_sender != self:
		return

	match option:
		"Add Task":
			SignalBus.get_text_input_from_user.emit("What should be the name of the task?", "add_task", self)
		"Go back to main menu":
			

func _on_text_input_submitted_by_user(text_submitted: String, tag: String, request_sender: Node) -> void:
	if request_sender != self:
		return
	
	if tag == "add_task":
		InfoGetter.get_task_manager().add_task(text_submitted)
		return