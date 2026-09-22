class_name SaveManager
extends Resource

@export var save_path: String = "user://dev/save_data.tres"
@export var create_file: bool

func _init(new_save_path: String = "", new_create_file: bool = true) -> void:
	print("Save Manager: Init Called")

	if new_save_path == "":
		save_path = get_save_file_path()
	else:
		save_path = new_save_path

	create_file = new_create_file

func get_save_file_path() -> String:
	if OS.is_debug_build():
		return Constants.DEV_SAVE_PATH
	return Constants.LIVE_SAVE_PATH

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

func load_data() -> SaveData:
	delete_save_file()
	if not FileAccess.file_exists(save_path):
		return SaveData.new()

	return ResourceLoader.load(save_path)

func save_data(save_data: SaveData) -> void:
	if not create_file and not FileAccess.file_exists(save_path):
		push_error("File Dosen't Exist: ", save_path)
		return
	
	_ensure_file_exists()
	var err = ResourceSaver.save(save_info, save_path)

	if err != OK:
		push_error("Error from resource saver: ", err)
		return

	print("\nSaveManager: Game-State Saved")