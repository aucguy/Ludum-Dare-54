extends CharacterBody2D

signal dead

const parameters = preload("res://parameters.gd")

#@export var input_velocity: int = parameters.player_speed
#@export var spray_amount: int = parameters.spray_health_change
#@export var invincible: bool = parameters.player_invincible
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
		$"/root/SoundManager".play_sound('Walk')
		velocity = velocity.normalized()
		direction = velocity
		velocity *= parameters.player_speed
		move_and_slide()
		if velocity.y < 0:
			$AnimatedSprite2D.play('up')
			$AnimatedSprite2D.flip_h = false
		elif velocity.x > 0:
			if velocity.y > 0.01:
				$AnimatedSprite2D.play('downright')
			else:
				$AnimatedSprite2D.play('right')
			$AnimatedSprite2D.flip_h = false
		elif velocity.x < 0:
			if velocity.y > 0.01:
				$AnimatedSprite2D.play('downright')
			else:
				$AnimatedSprite2D.play('right')
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.play('down')
			$AnimatedSprite2D.flip_h = false
	else:
		velocity = Vector2(0, 0)
		$AnimatedSprite2D.stop()
	
	if Input.is_action_pressed('spray_water'):
		$WaterSpray.start_spray(direction)
		$Health.increment(-delta * parameters.spray_health_change)
	else:
		$WaterSpray.end_spray()

func hurt(amount):
	$Health.increment(-amount)

func _on_health_dead():
	if parameters.player_invincible:
		return
	dead.emit()
	$"/root/SoundManager".play_sound('Death')
	
func restart(restart_position):
	global_position = restart_position
	$WaterSpray.restart()
	$Health.restart()
	
func full_heal():
	$Health.restart()
