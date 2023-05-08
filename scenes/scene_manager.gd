extends CanvasLayer

@onready var animation_player = $AnimationPlayer

var storage_file: String = "user://data.save"
var storage_data: Dictionary = {
	"highscore": 0,
	"collected_coins": 0,
}



func _ready() -> void:
	storage_data = _read_storage(storage_file)
	get_tree().change_scene_to_file("res://ui/main_menu.tscn")


func change_scene(path: String) -> void:
	animation_player.play("dissolve")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(path)
	animation_player.play_backwards("dissolve")



func _read_storage(file_path: String) -> Dictionary:
	if FileAccess.file_exists(file_path):
		var file = FileAccess.open(file_path, FileAccess.READ)
		var content = file.get_as_text();
		var data = JSON.parse_string(content);

		file.close()

		return data
	else:
		return {
			"highscore": 0,
			"collected_coins": 0
		}

func _write_storage(file_path: String, content: Dictionary) -> void:
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	var data = JSON.stringify(content)
	file.store_line(data)

	file.close()


func store_data(key: String, value) -> void:
	storage_data[key] = value;

	_write_storage(storage_file, storage_data)
