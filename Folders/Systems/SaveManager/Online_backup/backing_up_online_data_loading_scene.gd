extends PanelContainer

@export var loading_label: Label

const ORIGINAL_TEXT: String = "Backing Up Save Data to Codeberg."

func _ready() -> void:
	loading_label.text = ORIGINAL_TEXT + "."

func _process(delta: float) -> void:
	loading_label.text = ORIGINAL_TEXT
