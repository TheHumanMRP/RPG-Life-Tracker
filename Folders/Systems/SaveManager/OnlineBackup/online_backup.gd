extends HTTPRequest

signal backup_completed(success: bool, message: String)

var save_path: String

var backup_in_progress: bool = false

const WAIT_TIMER_BEFORE_QUIT: int = 15

func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS
	save_path = get_save_file_path()
	SignalBus.handle_closing_game.connect(handle_closing_game)


func get_save_file_path() -> String:
	if OS.is_debug_build():
		return Constants.DEV_SAVE_PATH

	return Constants.LIVE_SAVE_PATH

# Qutting Handled here cause of uploading before save
func _notification(what: int) -> void:
	if OS.is_debug_build():
		return

	if what != NOTIFICATION_WM_CLOSE_REQUEST:
		handle_closing_game()
	
func handle_closing_game() -> void:
	SignalBus.set_game_state.emit(All_Enums.GAME_STATES.BackingUpOnlineData)
	_start_wait_timer_before_quit()

	if not backup_in_progress:
		await _on_upload_save()
		get_tree().quit()
	
	if backup_in_progress:
		print("Backup in progress")

func _start_wait_timer_before_quit() -> void:
	SignalBus.start_loading_screen.emit()

	await get_tree().create_timer(WAIT_TIMER_BEFORE_QUIT).timeout

	get_tree().quit()

func _on_upload_save() -> void:
	print("Upload save func ran")

	var settings: OnlineBackupSettings = InfoGetter.get_save_data().online_backup_settings
	var api_token: String = settings.CODEBERG_TOKEN
	var url := _get_remote_url(settings)
	var headers := _get_request_headers(api_token)

	if not _validate_backup(api_token):
		return

	backup_in_progress = true

	var encoded_content: String = _get_encoded_save()

	if encoded_content.is_empty():
		_finish(false, "Failed to read local save file.")
		return

	var metadata_response: Dictionary = await _get_remote_metadata(url, headers)

	if not metadata_response["success"]:
		_finish(false, metadata_response["message"])
		return

	var payload := _create_payload(encoded_content, metadata_response["sha"])
	var method: HTTPClient.Method = metadata_response["method"]

	await _upload_payload(url, headers, method, payload)


func _validate_backup(api_token: String) -> bool:
	if backup_in_progress:
		return false

	if api_token.is_empty():
		_finish(false, "API token is missing.")
		return false

	if not FileAccess.file_exists(save_path):
		_finish(false, "Local save file not found.")
		return false

	return true


func _get_encoded_save() -> String:
	var file_bytes := FileAccess.get_file_as_bytes(save_path)

	if file_bytes.is_empty():
		return ""

	return Marshalls.raw_to_base64(file_bytes)


func _get_remote_url(settings: OnlineBackupSettings) -> String:
	return "%s/repos/%s/%s/contents/%s" % [
		settings.CODEBERG_URL,
		settings.USER_NAME,
		settings.REPOSITORY,
		settings.FILE_NAME
	]


func _get_request_headers(api_token: String) -> PackedStringArray:
	return PackedStringArray([
		"Authorization: token " + api_token,
		"Content-Type: application/json",
		"Accept: application/json"
	])


func _get_remote_metadata(
	url: String,
	headers: PackedStringArray
) -> Dictionary:
	var response: Dictionary = await _send_request(
		HTTPClient.METHOD_GET,
		url,
		headers
	)

	if not response.get("transport_ok", false):
		return _metadata_failure("Failed to contact Codeberg.")

	var status: int = response["status"]

	if status == 404:
		return {
			"success": true,
			"sha": "",
			"method": HTTPClient.METHOD_POST
		}

	if status != 200:
		return _metadata_failure(
			"Metadata request failed: HTTP %d" % status
		)

	var metadata = JSON.parse_string(response["body"])

	if not metadata is Dictionary or not metadata.has("sha"):
		return _metadata_failure("Invalid remote file metadata.")

	return {
		"success": true,
		"sha": metadata["sha"],
		"method": HTTPClient.METHOD_PUT
	}


func _metadata_failure(message: String) -> Dictionary:
	return {
		"success": false,
		"message": message
	}


func _create_payload(encoded_content: String, sha: String) -> Dictionary:
	var payload := {
		"message": "Automatic save backup",
		"content": encoded_content
	}

	if not sha.is_empty():
		payload["sha"] = sha

	return payload


func _upload_payload(
	url: String,
	headers: PackedStringArray,
	method: HTTPClient.Method,
	payload: Dictionary
) -> void:
	var response: Dictionary = await _send_request(
		method,
		url,
		headers,
		JSON.stringify(payload)
	)

	if not response.get("transport_ok", false):
		_finish(false, "Upload request failed.")
		return

	var status: int = response["status"]

	if status == 200 or status == 201:
		_finish(true, "Save backed up to Codeberg.")
		return

	_finish(
		false,
		"Upload failed: HTTP %d — %s" % [
			status,
			response["body"]
		]
	)


func _send_request(
	method: HTTPClient.Method,
	url: String,
	headers: PackedStringArray,
	body: String = ""
) -> Dictionary:
	var error := request(url, headers, method, body)

	if error != OK:
		return {"transport_ok": false}

	var result: Array = await request_completed

	return {
		"transport_ok": result[0] == HTTPRequest.RESULT_SUCCESS,
		"status": result[1],
		"body": (result[3] as PackedByteArray).get_string_from_utf8()
	}


func _finish(success: bool, message: String) -> void:
	backup_in_progress = false
	backup_completed.emit(success, message)
