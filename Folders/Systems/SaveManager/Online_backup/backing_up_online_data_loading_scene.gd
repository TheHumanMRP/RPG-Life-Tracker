extends PanelContainer

@export var loading_label: Label

const ORIGINAL_TEXT: String = "Backing Up Save Data to Codeberg"

func _ready() -> void:
	_set_loading_screen_text()

func _set_loading_screen_text() -> void:
	while true:
		loading_label.text = ORIGINAL_TEXT + "."
		await get_tree().create_timer(1).timeout

		loading_label.text = ORIGINAL_TEXT + ".."
		await get_tree().create_timer(1).timeout
	
		loading_label.text = ORIGINAL_TEXT + "..."
		await get_tree().create_timer(1).timeout
