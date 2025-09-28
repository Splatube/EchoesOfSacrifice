extends CharacterBody2D

@export_category("Speed")
@export var speed := 150
@export var climb_speed := 100
@export var jump_speed := 300
var dash = 1

# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = -jump_speed

	if Input.is_action_just_pressed("Dash"):
		dash = 2
		await get_tree().create_timer(0.25).timeout
		dash = 1

	if Input.is_action_pressed("Jump") and is_on_wall():
		var direction = Input.get_axis("Up", "Down")
		velocity.y = direction * climb_speed

	else:
		# Get the input direction.
		var direction = Input.get_axis("Left", "Right")
		velocity.x = direction * speed * dash
		
		if Input.is_action_just_pressed("Left"):
			$Sprite.set_flip_h(true)
		elif Input.is_action_just_pressed("Right"):
			$Sprite.set_flip_h(false)
	
		
	move_and_slide()
