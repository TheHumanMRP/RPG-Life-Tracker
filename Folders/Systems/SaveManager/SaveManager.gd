class_name SaveManager
extends Resource

@export var save_path: String = "user://gamedata/save_data.tres"
@export var save_info: SaveData
@export var create_file: bool

const DEV_SAVE_PATH := "user://dev/save_data.tres"
const LIVE_SAVE_PATH := "user://live/save_data.tres"

func _init(new_save_path: String = "user://dev/save_data.tres", new_create_file: bool = true) -> void:
	print("Save Manager: Init Called")

	save_path = get_save_file_path()

	create_file = new_create_file

func get_save_file_path() -> String:
	if OS.is_debug_build():
		return DEV_SAVE_PATH
	return LIVE_SAVE_PATH

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
	delete_save_file()

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