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
		velocity *= parameters.player_speed
		direction = velocity
		move_and_slide()
	else:
		velocity = Vector2.ZERO
	
	$WalkAnimation.update(velocity)
	
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
	$WalkAnimation.hide()
	$"/root/SoundManager".play_sound('Death')
	await get_tree().create_timer($GPUParticles2D.lifetime).timeout
	
	await $"/root/StateManager".restart()

	is_dead = false
	$WalkAnimation.show()
	global_position = $"/root/StateManager".restart_position
	$WaterSpray.restart()
	$Health.restart()
	$"/root/StateManager".end_restart()
	
func full_heal():
	$Health.restart()
