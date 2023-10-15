extends Area2D

@onready var parameters = $"/root/Parameters"

@onready var speed: int = parameters.enemy_speed
@onready var water_damage: int = parameters.enemy_particle_damage
@onready var player_damage: int = parameters.player_enemy_damage

var is_dead = false

func _process(delta):
	if is_dead:
		return
	
	var players = get_tree().get_nodes_in_group('player')
	if players.size() != 0:
		await get_tree().physics_frame
		$NavigationAgent2D.target_position = players[0].global_position
	
	var velocity = $NavigationAgent2D.get_next_path_position() - global_position
	velocity = velocity.normalized()
	velocity *= speed
	position += delta * velocity
	
	$WalkAnimation.update(velocity)

func _on_body_entered(body):
	if is_dead:
		return
	
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
	$WalkAnimation.hide()
	$Health.hide()
	$GPUParticles2D.emitting = true
	collision_layer = 0
	collision_mask = 0
	$"/root/SoundManager".play_sound('Death')
	await get_tree().create_timer($GPUParticles2D.lifetime).timeout
	queue_free()
