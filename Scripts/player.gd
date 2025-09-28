extends CharacterBody2D

@export var speed := 100

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	position += Input.get_vector("Left", "Right", "", "") * delta * speed
