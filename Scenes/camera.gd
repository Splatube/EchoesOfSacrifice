extends Camera2D

@export var target: Node2D
@export var speed := 10

func _physics_process(delta: float) -> void:
	position = lerp(position, target.global_position, speed * delta)
