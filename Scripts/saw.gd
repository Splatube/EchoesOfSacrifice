extends TileMap

var startPosition
var targetPosition
var forward = true
@export var speed = 500
var slow = 1
var slowed = false
var canSlow = true

func _ready():
	startPosition = position
	targetPosition = position
	targetPosition.x += 175
	

func _process(delta):
	if Input.is_action_pressed("TimeSlow") and canSlow:
		slow = 0.1
		slowed = true
	else:
		slow = 1
	
	if Input.is_action_just_released("TimeSlow"):
		canSlow = false
	
	if int(position.x) % 4 == 0:
		scale.x *= -1
		
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
