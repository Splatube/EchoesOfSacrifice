extends StaticBody2D

var startPosition
var targetPosition
var forward = true
@export var speed = 490
var slow = 1
var slowed = false
var canSlow = true

var paused = false

func _ready():
	startPosition = position
	targetPosition = position
	targetPosition.x += 175
	
func pause_game(pause):
	paused = pause
	$Sprite.pause()

func _process(delta):
	if !paused:
		$Sprite.play()
		if Input.is_action_pressed("TimeSlow") and canSlow:
			slow = 0.1
			slowed = true
		else:
			slow = 1
		
		if Input.is_action_just_released("TimeSlow"):
			canSlow = false
			
		$Sprite.speed_scale = slow
			
		if forward:
			if position.x >= targetPosition.x:
				forward = false
			else:
				position.x += speed * delta * slow
		else:
			if position.x <= startPosition.x:
				forward = true
			else:
				position.x -= speed * delta * slow
