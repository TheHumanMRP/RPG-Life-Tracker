extends PanelContainer

@export var question_label: Label
@export var user_input_line_edit: LineEdit

var caller_tag: String

func _ready() -> void:
	self.hide()

	user_input_line_edit.text_submitted.connect(_on_user_input_line_edit_text_submitted)

	SignalBus.get_text_input_from_user.connect(_on_get_text_input_from_user)

func _on_get_text_input_from_user(question: String, new_caller_tag: String, user_input_placeholder_text: String = "Answer Here") -> void:
	question_label.text = question
	user_input_line_edit.placeholder_text = user_input_placeholder_text
	user_input_line_edit.text = ""
	caller_tag = new_caller_tag

	self.show()

func _on_user_input_line_edit_text_submitted(text_submitted: String) -> void:
	SignalBus.text_input_submitted_by_user.emit(text_submitted)

	self.hide()
