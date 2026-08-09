extends CanvasLayer

@onready var fps_label: Label = $%FPSLabel

func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS

func _process(delta: float) -> void:
	var fps: int = round(1 / delta)

	var fps_string: String = "FPS: " + str(fps)

	fps_label.text = fps_string
