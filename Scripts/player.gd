extends CharacterBody2D

@export_category("Speed")
@export var speed := 150
@export var climb_speed := 100
@export var jump_speed := 300
@export var dash_speed := 2
var dash = 1

@export_category("Limbs")
@export var head = true
@export var arms = true
@export var hands = true
@export var legs = true

# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _process(_delta):
	if !head and !arms and !legs:
		player_texture("res://Assets/Dummy-Head-Feet-Arms.png")
	elif !head and !arms:
		player_texture("res://Assets/Dummy-Head-Arms.png")
	elif !head and !legs:
		player_texture("res://Assets/Dummy-Head-Feet.png")
	elif !head:
		player_texture("res://Assets/Dummy-Head.png")
	elif !arms and !legs:
		player_texture("res://Assets/Dummy-Feet-Arms.png")
	elif !arms:
		player_texture("res://Assets/Dummy-Arms.png")
	elif !legs:
		player_texture("res://Assets/Dummy-Feet.png")
	else:
		player_texture("res://Assets/Dummy.png")
		
	if !legs:
		$Collision.scale.y = 0.5
	else:
		$Collision.scale.y = 1
		
func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = -jump_speed

	if Input.is_action_just_pressed("Dash"):
		dash = dash_speed
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

func player_texture(texture: String) -> void:
	$Sprite.texture = load(texture)
