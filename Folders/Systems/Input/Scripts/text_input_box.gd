extends PanelContainer

@export var question_label: Label
@export var user_input_line_edit: LineEdit

func _ready() -> void:
	user_input_line_edit.text_submitted.connect(_on_user_input_line_edit_text_submitted)

func get_text_input(question: String, user_input_placeholder_text: String = "Answer Here") -> void:
	question_label.text = question
	user_input_line_edit.placeholder_text = user_input_placeholder_text

	self.show()

func _on_user_input_line_edit_text_submitted() -> void:
	