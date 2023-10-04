extends CharacterBody2D

@export var input_velocity: int = 100
@export var spray_amount: int = 5.0
@onready var direction = Vector2(1, 0)

func _physics_process(delta):
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed('move_left'):
		velocity.x -= 1
	if Input.is_action_pressed('move_right'):
		velocity.x += 1
	if Input.is_action_pressed('move_up'):
		velocity.y -= 1
	if Input.is_action_pressed('move_down'):
		velocity.y += 1
	
	if velocity.length() >= 1e-5:
		velocity = velocity.normalized()
		direction = velocity
		velocity *= input_velocity
		move_and_slide()
	else:
		velocity = Vector2(0, 0)
	
	if Input.is_action_pressed('spray_water'):
		$WaterSpray.start_spray(direction)
		$Health.increment(-delta * spray_amount)
	else:
		$WaterSpray.end_spray()

func hurt(amount):
	$Health.increment(-amount)
