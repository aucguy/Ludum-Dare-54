extends Area2D

@export var speed: int = 50
@export var water_damage: int = 5
@export var player_damage: int = 5

func _process(delta):
	var players = get_tree().get_nodes_in_group('player')
	if players.size() != 0:
		await get_tree().physics_frame
		$NavigationAgent2D.target_position = players[0].position

#func _physics_process(delta):
	#if $NavigationAgent2D.is_navigation_finished():
	#	return
		
	var velocity = $NavigationAgent2D.get_next_path_position() - global_position
	velocity = velocity.normalized()
	velocity *= speed
	#move_and_slide()
	position += delta * velocity
	
	#for i in get_slide_collision_count():
	#	var collision = get_slide_collision(i)
	#	if collision.get_collider().is_in_group('player'):
	#		queue_free()

func _on_body_entered(body):
	if body.is_in_group('player'):
		queue_free()
		body.hurt(player_damage)

func _on_area_entered(area):
	if area.is_in_group('water_particles'):
		$Health.increment(-water_damage)

func _on_health_dead():
	queue_free()
