extends CharacterBody2D

@export var speed := 150
@export var jump_speed := 300

# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(delta):
	if Input.is_action_just_pressed("Left"):
		$Sprite.set_flip_h(true)
	elif Input.is_action_just_pressed("Right"):
		$Sprite.set_flip_h(false)

func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = -jump_speed

	# Get the input direction.
	var direction = Input.get_axis("Left", "Right")
	velocity.x = direction * speed
		
	move_and_slide()
