extends ScrollContainer

@export var task_vbox_container: VBoxContainer

func _init() -> void:
	SignalBus.refresh_ui.connect(_on_refresh_ui)

func _on_refresh_ui() -> void:
	pass