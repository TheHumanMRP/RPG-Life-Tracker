extends PanelContainer

var current_request_sender: Node = null
var current_tag: String = ""

@export var conformation_textbox: Label
@export var conform_button: Button
@export var deny_button: Button

func _init() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS

func _ready() -> void:
	self.hide()

	SignalBus.popup_conformation_menu.connect(_on_popup_conformation_menu)

	conform_button.pressed.connect(_on_conform_button_pressed)
	deny_button.pressed.connect(_on_deny_button_pressed)

func _on_popup_conformation_menu(request_sender: Node, conformation_textbox_text: String, conform_button_text: String, deny_button_text: String, tag: String) -> void:
	current_request_sender = request_sender
	current_tag = tag

	conformation_textbox.text = conformation_textbox_text
	deny_button.text = deny_button_text
	conform_button.text = conform_button_text

	self.show()

func _on_conform_button_pressed() -> void:
	_answer_button_pressed(true)

func _on_deny_button_pressed() -> void:
	_answer_button_pressed(false)

func _answer_button_pressed(conform: bool) -> void:
	var request_sender: Node = current_request_sender
	var tag: String = current_tag

	current_request_sender = null
	current_tag = ""

	self.hide()

	SignalBus.conformation_menu_option_selected.emit(
		request_sender,
		conform,
		tag
	)