extends CharacterBody2D

## Variables ##

@export_category("Speed")
@export var speed := 150
@export var climb_speed := 100
@export var jump_speed := 300
@export var dash_speed := 2.0
var dash = 1

@export_category("Limbs")
@export var head = true
@export var arms = true
@export var hands = true
@export var legs = true
@export var feet = true

var gameoverScene: PackedScene = load("res://Scenes/game_over.tscn")

var climbed = false
var slowed = false
var canSlow = true

var paused = false

# Get the gravity from the project settings so you can sync with rigid body nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	get_tree().call_group("UI", "limit_vision", 0.2)

func _process(_delta):
	if Input.is_action_just_pressed("Reset"):
		get_tree().change_scene_to_file("res://Scenes/level.tscn")
	
	if !head and !arms and !legs:
		player_texture("res://Assets/Dummy-Head-Legs-Arms.png")
		player_collision(0.5, 0)
	elif !head and !hands and !legs:
		player_texture("res://Assets/Dummy-Head-Legs-Hands.png")
		player_collision(0.5, 0)
	elif !head and !arms and !feet:
		player_texture("res://Assets/Dummy-Head-Feet-Arms.png")
		player_collision(0.5,1)
	elif !head and !hands and !feet:
		player_texture("res://Assets/Dummy-Head-Feet-Hands.png")
		player_collision(0.5,1)
	elif !head and !arms:
		player_texture("res://Assets/Dummy-Head-Arms.png")
		player_collision(0.7,4)
	elif !head and !hands:
		player_texture("res://Assets/Dummy-Head-Hands.png")
		player_collision(0.7,4)
	elif !head and !legs:
		player_texture("res://Assets/Dummy-Head-Legs.png")
		player_collision(0.4,1)
	elif !head and !feet:
		player_texture("res://Assets/Dummy-Head-Feet.png")
		player_collision(0.5,1.5)
	elif !head:
		player_texture("res://Assets/Dummy-Head.png")
		player_collision(0.7,4)
	elif !arms and !legs:
		player_texture("res://Assets/Dummy-Legs-Arms.png")
		player_collision(0.8,-4.25)
	elif !arms and !feet:
		player_texture("res://Assets/Dummy-Feet-Arms.png")
		player_collision(0.9,-3.75)
	elif !hands and !feet:
		player_texture("res://Assets/Dummy-Feet-Hands.png")
		player_collision(0.9,-3.75)
	elif !hands and !legs:
		player_texture("res://Assets/Dummy-Legs-Hands.png")
		player_collision(0.4,1)
	elif !arms:
		player_texture("res://Assets/Dummy-Arms.png")
		player_collision(1,0)
	elif !legs:
		player_texture("res://Assets/Dummy-Legs.png")
		player_collision(0.8,-4.25)
	elif !hands:
		player_texture("res://Assets/Dummy-Hands.png")
		player_collision(1,0)
	elif !feet:
		player_texture("res://Assets/Dummy-Feet.png")
		player_collision(0.9,-3.75)
	else:
		player_texture("res://Assets/Dummy.png")
		player_collision(1,0)

func pause_game(pause):
	paused = pause

func _physics_process(delta):
	# Pause menu
	if Input.is_action_just_pressed("Pause"):
		get_tree().call_group("pausable", "pause_game", !$"../Pause".is_visible())
	
	if !paused:
		get_tree().call_group("UI", "update_limbs", {
			"head": head,
			"arms": arms,
			"hands": hands,
			"legs": legs,
			"feet": feet
			})
		
		# Add the gravity.
		velocity.y += gravity * delta

		# Slow time
		if Input.is_action_pressed("TimeSlow") and canSlow:
			slowed = true
			head = false
			get_tree().call_group("UI", "limit_vision", 1.5)
		if Input.is_action_just_released("TimeSlow") and slowed:
			canSlow = false
			slowed = false
			
		# Jump
		if Input.is_action_just_pressed("Jump") and is_on_floor() and (feet):
			velocity.y = -jump_speed
			feet = false

		# Dash
		if Input.is_action_just_pressed("Dash") and legs:
			dash = dash_speed
			legs = false
			feet = false
			await get_tree().create_timer(0.25).timeout
			dash = 1

		# Climb
		if (Input.is_action_just_pressed("Jump") and is_on_wall() and hands) or climbed:
			var direction = Input.get_axis("Up", "Down")
			velocity.y = direction * climb_speed
			climbed = true
		if climbed and !is_on_wall():
			hands = false
			climbed = false

		else:
			# Get the input direction.
			var direction = Input.get_axis("Left", "Right")
			velocity.x = direction * speed * dash
			
			# Face input direction
			if Input.is_action_just_pressed("Left"):
				$Sprite.set_flip_h(true)
			elif Input.is_action_just_pressed("Right"):
				$Sprite.set_flip_h(false)
		
		move_and_slide()
		
		# Death collision
		for i in get_slide_collision_count():
			var collision = get_slide_collision(i)
			var collider = collision.get_collider()
			if collider.name.contains("Kill"):
				if is_inside_tree():
					get_tree().change_scene_to_packed(gameoverScene)

##  Subroutines  ##

# Set player sprite
func player_texture(texture: String) -> void:
	$Sprite.texture = load(texture)

func player_collision(size, pos):
	$Collision.scale.y = size
	$Collision.position.y = pos
