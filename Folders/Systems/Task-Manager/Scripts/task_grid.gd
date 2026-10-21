extends ScrollContainer

@export var task_vbox_container: VBoxContainer

func _init() -> void:
	SignalBus.refresh_ui.connect(_on_refresh_ui)

func _on_refresh_ui() -> void:
	var all_tasks = InfoGetter.get_tasks_save_data().all_tasks

	for child in task_vbox_container.get_children():
		child.queue_free()

	var packed_task_scene: PackedScene = _get_task_scene_preload()

	for task in all_tasks:
		var task_scene: Node = packed_task_scene.instantiate()

		task_scene.setup(task.task_id)

		task_vbox_container.add_child(task_scene)

func _get_task_scene_preload() -> PackedScene:
	return load(Constants.PATH_TO_TASK_ITEM_SCENE)