extends PanelContainer

var current_request_sender: Node = null

@export var conformation_textbox: Label
@export var conform_button: Button
@export var deny_button: Button

func _ready() -> void:
	self.hide()

	SignalBus.popup_conformation_menu.connect(_on_popup_conformation_menu)

	conform_button.pressed.connect()

func _on_popup_conformation_menu(request_sender: Node, conformation_textbox_text: String, conform_button_text: String, deny_button_text: String) -> void:
	current_request_sender = request_sender

	conformation_textbox.text = conformation_textbox_text
	deny_button.text = deny_button_text
	conform_button.text = conform_button_text

	self.show()