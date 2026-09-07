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

func setup(new_task_name: String, new_task_index: int) -> void:
	task_name

# ===================================================
# TASK STATUS
# ===================================================

func mark_task_as_completed() -> void:
	task_status = All_Enums.TASK_STATUS.Completed

func mark_task_as_pending() -> void:
	task_status = All_Enums.TASK_STATUS.Pending

func mark_task_as_working() -> void:
	task_status = All_Enums.TASK_STATUS.Working