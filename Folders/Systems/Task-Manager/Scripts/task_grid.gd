extends ScrollContainer

@export var task_vbox_container: VBoxContainer

func _init() -> void:
	SignalBus.refresh_ui.connect(_on_refresh_ui)

func _on_refresh_ui() -> void:
	var all_tasks = InfoGetter.get_tasks_save_data().all_tasks

	for child in task_vbox_container.get_children():
		child.queue_free()

	var task_scene_preload: PackedScene = _get_task_scene_preload()

	for task in all_tasks:
		var task_scene : Node = task_scene_preload 


func _get_task_scene_preload() -> PackedScene:
	return load(Constants.PATH_TO_TASK_ITEM_SCENE)