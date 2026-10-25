extends Node

# ============================================================================
# Set process mode
# ============================================================================

func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS

# ============================================================================
# Player
# ============================================================================

func get_player_max_health() -> int:
	return Global.save_data.player_stats.player_max_health

# ============================================================================
# Inventory
# ============================================================================

func get_all_globla_items_manager() -> AllGlobalItemsManager:
	return Global.inventory_related_managers.all_global_items_manager

# ============================================================================
# Hotbar
# ============================================================================

func get_hotbar_manager() -> HotbarManager:
	return Global.inventory_related_managers.hotbar_manager

# ============================================================================
# Task Manager
# ============================================================================
	
func get_task_manager() -> TaskManager:
	return Global.tasks_related_managers.tasks_manager

# ============================================================================
# Save Data
# ============================================================================

func get_save_data() -> SaveData:
	return Global.save_data

# ============================================================================
# Right Click Menu
# ============================================================================

func get_main_menu() -> MainMenu:
	if Global.current_game_state != All_Enums.GAME_STATES.MainMenu:
		return null
	
	return get_tree().get_first_node_in_group("main_menu")
