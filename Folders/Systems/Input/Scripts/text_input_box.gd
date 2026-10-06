extends PanelContainer

@export var question_label: Label
@export var user_input_line_edit: LineEdit

func get_text_input(question: String, user_input_placeholder_text: String = "Answer Here") -> void:
	question_label.text = question
	