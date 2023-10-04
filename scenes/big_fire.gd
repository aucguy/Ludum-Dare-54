extends Area2D

signal dead

@export var enemy: PackedScene = preload('res://scenes/enemy.tscn')
@export var max_spawn_count = 5
@export var spawn_rate = 2
@export var water_damage: int = 1
@onready var group_name = 'enemies_from_spawner_' + str(randi())

func _ready():
	$SpawnTimer.wait_time = spawn_rate
	$SpawnTimer.start()

func _on_spawn_timer_timeout():
	var count = get_tree().get_nodes_in_group(group_name).size()
	if count < max_spawn_count:
		var enemy_instance = enemy.instantiate()
		enemy_instance.add_to_group(group_name)
		add_child(enemy_instance)

func _on_area_entered(area):
	if area.is_in_group('water_particles'):
		$Health.increment(-water_damage)

func _on_health_dead():
	dead.emit()
	disable()

func disable():
	$SpawnTimer.stop()
	$Health.hide()
