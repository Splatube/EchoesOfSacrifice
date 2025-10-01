extends CanvasLayer

func _on_continue_pressed() -> void:
	set_visible(false)

func pause_game(pause):
	set_visible(pause)
