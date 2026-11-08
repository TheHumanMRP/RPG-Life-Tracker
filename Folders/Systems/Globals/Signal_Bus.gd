extends Node

@warning_ignore_start("unused_signal")

# ==============================================
# Player
# ==============================================

signal respawn_player
signal player_died

# ==============================================
# Player Inventory
# ==============================================

signal player_inventory_changed(new_inventory: Array[ItemEntry])
signal item_selected(item_id: int)
signal equip_item(item_id: int, slot_index: int)

# ==============================================
# Hotbar
# ==============================================

signal hotbar_item_selected(slot_index: int)
signal hotbar_item_equipped(slot_index: int)
signal swap_hotbar_item(slot_index: int, item_id: int)
signal hotbar_changed

# ==============================================
# Global Inventory
# ==============================================

signal notify_global_inventory_changed
signal add_item_to_global_inventory(new_item_entry: ItemEntry)
signal remove_item_from_global_inventory(item_id: int)
signal rename_item_in_inventory(item_id: int, new_name: String)
signal set_game_state(new_game_state: All_Enums.GAME_STATES)

# ==============================================
# Game State
# ==============================================

signal refresh_ui
signal save_game
signal quit_game

signal switch_scene(new_scene: Node)

# ==============================================
# Right Click Menu
# ==============================================

signal popup_right_click_menu(request_sender: Node, list_of_options: Array[String], mouse_position: Vector2)
signal right_click_menu_option_selected(request_sender: Node, selected_option: String)

# ==============================================
# Conformation Menu
# ==============================================

signal popup_conformation_menu(request_sender: Node,
conformation_textbox_text: String,
conform_button_text: String,
deny_button_text: String,
tag: String
)
signal conformation_menu_option_selected(request_sender: Node, conformed: bool, tag: String)

# ==============================================
# Input
# ==============================================

signal get_text_input_from_user(question: String, tag: String, request_sender: Node, user_input_line_edit_placeholder_text: String)
signal text_input_submitted_by_user(text_sumitted: String, tag: String, request_sender: Node)

# ==============================================
# Online Backup
# ==============================================

signal handle_closing_game
signal start_loading_screen
signal set_online_backup_setting(setting: All_Enums.ONLINE_BACKUP_SETTINGS, new_value: String)

@warning_ignore_restore("unused_signal")

# ==============================================
# Set process mode
# ==============================================

func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS