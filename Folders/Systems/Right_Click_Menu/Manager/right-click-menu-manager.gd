extends Node

var right_click_menu: RightClickMenu

func _ready() -> void:
	right_click_menu = get_tree().get_first_node_in_group("right_click_menu")

func popup_right_click_menu(options: Array[String]):
	right_click_menu
	
	right_click_menu.popup()