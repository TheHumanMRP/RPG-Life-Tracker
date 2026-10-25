extends HTTPRequest

signal backup_completed(success: bool, message: String)

var save_path: String
var api_token := ""

var backup_in_progress: bool = false

func _ready() -> void:
	save_path = get_save_file_path()

func get_save_file_path() -> String:
	if OS.is_debug_build():
		return Constants.DEV_SAVE_PATH
	return Constants.LIVE_SAVE_PATH


func upload_save() -> void:
	if backup_in_progress:
		return

	if api_token.is_empty():
		backup_completed.emit(false, "API token is missing.")
		return

	if not FileAccess.file_exists(save_path):
		backup_completed.emit(false, "Local save file not found.")
		return

	backup_in_progress = true

	# Read the existing file without changing its contents.
	var file_bytes := FileAccess.get_file_as_bytes(save_path)
	var encoded_content := Marshalls.raw_to_base64(file_bytes)

	var save_file :SaveData 

	var url := "%s/repos/%s/%s/contents/%s" % [
		API_URL, OWNER, REPOSITORY, REMOTE_PATH
	]

	var headers := PackedStringArray([
		"Authorization: token " + api_token,
		"Content-Type: application/json",
		"Accept: application/json"
	])

	# Find out whether the remote file already exists.
	var response := await _send_request(
		HTTPClient.METHOD_GET, url, headers
	)

	if not response.get("transport_ok", false):
		_finish(false, "Failed to contact Codeberg.")
		return

	var status: int = response["status"]
	var sha := ""

	if status == 200:
		var metadata = JSON.parse_string(response["body"])

		if not metadata is Dictionary or not metadata.has("sha"):
			_finish(false, "Invalid remote file metadata.")
			return

		sha = metadata["sha"]

	elif status != 404:
		_finish(false, "Metadata request failed: HTTP %d" % status)
		return

	# Prepare the create/update payload.
	var payload := {
		"message": "Automatic save backup",
		"content": encoded_content
	}

	var method: int

	if status == 200:
		method = HTTPClient.METHOD_PUT
		payload["sha"] = sha
	else:
		method = HTTPClient.METHOD_POST

	# Upload the file.
	var upload_response := await _send_request(
		method, url, headers, JSON.stringify(payload)
	)

	if not upload_response.get("transport_ok", false):
		_finish(false, "Upload request failed.")
		return

	var upload_status: int = upload_response["status"]

	if upload_status == 200 or upload_status == 201:
		_finish(true, "Save backed up to Codeberg.")
	else:
		_finish(
			false,
			"Upload failed: HTTP %d — %s" % [
				upload_status, upload_response["body"]
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