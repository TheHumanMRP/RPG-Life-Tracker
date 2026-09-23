class_name Task
extends Resource

# ===================================================
# TASK VARS
# ===================================================

@export var task_name: String
@export var task_status: All_Enums.TASK_STATUS
@export var task_id: int

# ===================================================
# TASK SETUP
# ===================================================

func setup(new_task_name: String, new_task_id: int) -> void:
	task_name = new_task_name
	task_id = new_task_id

# ===================================================
# TASK STATUS
# ===================================================

func set_task_status()