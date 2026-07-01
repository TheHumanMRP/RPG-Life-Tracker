class_name SaveManager
extends Resource

@export var save_path: String = "user://gamedata/save_data.tres"
@export var save_info: SaveData
@export var create_file: bool

func get_

func _init(new_save_path = "user://gamedata/save_data.tres", new_create_file: bool = true) -> void:
	save_path = new_save_path
	create_file = new_create_file

func _ensure_file_exists():
	var dir_path = save_path.get_base_dir()

	DirAccess.make_dir_recursive_absolute(dir_path)

	if not FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.WRITE)

		if file:
			file.store_string("")
			file.close()

func delete_save_file() -> void:
	DirAccess.remove_absolute(save_path)

func load_data() -> void:
	if not FileAccess.file_exists(save_path):
		save_info = SaveData.new()
		return

	save_info = ResourceLoader.load(save_path)

func save_data() -> void:
	if create_file:
		_ensure_file_exists()

	if not FileAccess.file_exists(save_path):
		push_error("File Dosen't Exist: ", save_path)
		return
	
	var err = ResourceSaver.save(save_info, save_path)

	if err != OK:
		push_error("Error from resource saver: ", err)
		return

	print("\nSaveManager: Game-State Saved")