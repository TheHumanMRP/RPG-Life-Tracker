extends PanelContainer

@export var loading_label: Label

const ORIGINAL_TEXT: String = "Backing Up Save Data to Codeberg"

func _ready() -> void:
	hide()
	SignalBus.start_loading_screen.connect(_on_start_loading_screen)

func _on_start_loading_screen() -> void:
	if OS.is_debug_build():
		return

	show()

	while true:
		loading_label.text = ORIGINAL_TEXT + "."
		await get_tree().create_timer(1).timeout

		loading_label.text = ORIGINAL_TEXT + ".."
		await get_tree().create_timer(1).timeout
	
		loading_label.text = ORIGINAL_TEXT + "..."
		await get_tree().create_timer(1).timeout
