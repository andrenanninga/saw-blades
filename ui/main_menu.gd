extends Control



func _on_play_pressed() -> void:
	SceneManager.change_scene("res://scenes/playground.tscn")



func _on_quit_pressed() -> void:
	get_tree().quit()
