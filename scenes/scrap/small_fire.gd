extends Area2D

#signal dead

const parameters = preload('res://parameters.gd')

@export var enemy: PackedScene = preload('res://scenes/enemy.tscn')
#@export var max_spawn_count = parameters.big_fire_max_spawn_count
#@export var spawn_rate = parameters.big_fire_spawn_rate
#@export var water_damage: int = parameters.big_fire_particle_damage
@onready var group_name = 'enemies_from_spawner_' + str(randi())

func _ready():
	$SpawnTimer.wait_time = parameters.small_fire_spawn_rate
	reset()

func start():
	$SpawnTimer.start()

func reset():
	$SpawnTimer.stop()
	$AnimatedSprite2D.play('on')
	$Health.restart()

func _on_spawn_timer_timeout():
	var count = get_tree().get_nodes_in_group(group_name).size()
	if count < parameters.small_fire_max_spawn_count:
		var enemy_instance = enemy.instantiate()
		enemy_instance.add_to_group(group_name)
		add_child(enemy_instance)

func _on_area_entered(area):
	if area.is_in_group('water_particles'):
		$Health.increment(-parameters.big_fire_particle_damage)

func _on_health_dead():
	#dead.emit()
	disable()
	$"/root/SoundManager".play_sound('Death')

func disable():
	$AnimatedSprite2D.play('off')
	$SpawnTimer.stop()
	$Health.hide()
	$GPUParticles2D.emitting = true
