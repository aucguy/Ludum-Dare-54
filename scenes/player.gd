extends CharacterBody2D

@onready var parameters = $"/root/Parameters"

@onready var direction = Vector2(1, 0)
var is_dead = false

func _ready():
	$"/root/StateManager".connect('beat_room_signal', full_heal)

func _physics_process(delta):
	if is_dead:
		$WaterSpray.end_spray()
		return
	
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
		if $"/root/StateManager".is_in_room():
			$Health.increment(-delta * parameters.spray_health_change)
	else:
		$WaterSpray.end_spray()

func hurt(amount):
	$Health.increment(-amount)

func _on_health_dead():
	if parameters.player_invincible:
		return
	is_dead = true
	$GPUParticles2D.emitting = true
	$"/root/SoundManager".play_sound('Death')
	$AnimatedSprite2D.hide()
	await get_tree().create_timer($GPUParticles2D.lifetime).timeout
	restart($"/root/StateManager".restart_position)
	$"/root/StateManager".restart()
	
func restart(restart_position):
	is_dead = false
	$AnimatedSprite2D.show()
	global_position = restart_position
	$WaterSpray.restart()
	$Health.restart()
	
func full_heal():
	$Health.restart()
