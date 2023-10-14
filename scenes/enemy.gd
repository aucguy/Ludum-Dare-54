extends Area2D

const parameters = preload("res://parameters.gd")

@export var speed: int = parameters.enemy_speed
@export var water_damage: int = parameters.enemy_particle_damage
@export var player_damage: int = parameters.player_enemy_damage

var is_dead = false

func _process(delta):
	if is_dead:
		return
	
	var players = get_tree().get_nodes_in_group('player')
	if players.size() != 0:
		await get_tree().physics_frame
		$NavigationAgent2D.target_position = players[0].global_position

#func _physics_process(delta):
	#if $NavigationAgent2D.is_navigation_finished():
	#	return
		
	var velocity = $NavigationAgent2D.get_next_path_position() - global_position
	velocity = velocity.normalized()
	velocity *= speed
	#move_and_slide()
	position += delta * velocity
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
	elif velocity.y > 0:
		$AnimatedSprite2D.play('down')
		$AnimatedSprite2D.flip_h = false
	
	#for i in get_slide_collision_count():
	#	var collision = get_slide_collision(i)
	#	if collision.get_collider().is_in_group('player'):
	#		queue_free()

func _on_body_entered(body):
	if body.is_in_group('player'):
		body.hurt(player_damage)
		die()

func _on_area_entered(area):
	if area.is_in_group('water_particles'):
		$Health.increment(-water_damage)

func _on_health_dead():
	die()
	
func die():
	is_dead = true
	$AnimatedSprite2D.hide()
	$Health.hide()
	$GPUParticles2D.emitting = true
	collision_layer = 0
	$"/root/SoundManager".play_sound('Death')
	await get_tree().create_timer($GPUParticles2D.lifetime).timeout
	queue_free()
