extends PanelContainer

func _ready() -> void:
	SignalBus.popup_conformation_menu.connect()

func _on_popup_conformation_menu(request_sender: Node, conformation_textbox_text: String, conform_button_text: String, deny_button_text: String) -> void:
	pass