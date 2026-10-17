extends PanelContainer

@export var question_label: Label
@export var user_input_line_edit: LineEdit
@export var cancle_button: Button

var current_request_sender: Node = null
var current_tag: String = ""

func _ready() -> void:
	self.hide()

	user_input_line_edit.text_submitted.connect(_on_user_input_line_edit_text_submitted)

	cancle_button.pressed.connect(_on_cancle_button_pressed)

func get_text_input_from_user(question: String, tag: String, request_sender: Node, user_input_placeholder_text: String = "Answer Here") -> void:
	question_label.text = question
	user_input_line_edit.placeholder_text = user_input_placeholder_text
	user_input_line_edit.text = ""
	user_input_line_edit.grab_focus()

	current_request_sender = request_sender
	current_tag = tag

	self.show()

func _on_user_input_line_edit_text_submitted(text_submitted: String) -> void:
	SignalBus.text_input_submitted_by_user.emit(text_submitted, current_tag, current_request_sender)

	current_request_sender = null
	current_tag = ""

	self.hide()

	self.queue_free()

func _on_cancle_button_pressed() -> void:
	self.queue_free()