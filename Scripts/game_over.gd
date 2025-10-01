extends CanvasLayer

# Restart
func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_SPACE):
		get_tree().change_scene_to_file("res://Scenes/level.tscn")
