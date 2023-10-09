extends Node2D

const parameters = preload('res://parameters.gd')

@export var particle_scene: PackedScene
#@export var spawn_rate: int = parameters.spray_particle_rate
#@export var velocity: int = parameters.spray_particle_velocity
#@export var max_distance: int = parameters.spray_particle_max_distance

@onready var particles = []
@onready var clock = 0
@onready var total_spawned = 0
@onready var spraying = false
@onready var direction = null

func _process(delta):
	if not spraying:
		return
	clock += delta
	while clock * parameters.spray_particle_rate > total_spawned:
		var angle = randf() * 1 / 4 * PI - 1.0 / 8 * PI
		var velocity_vec = Vector2(parameters.spray_particle_velocity, 0).rotated(angle + direction.angle())
		var particle = particle_scene.instantiate()
		particle.init(velocity_vec, parameters.spray_particle_max_distance, global_position)
		add_child(particle)
		total_spawned += 1

func start_spray(direction):
	spraying = true
	self.direction = direction
	$"/root/SoundManager".play_sound('WaterSpray')

func end_spray():
	spraying = false
	direction = null
	$"/root/SoundManager".stop_sound('WaterSpray')

func restart():
	end_spray()
	get_tree().call_group('water_particles', 'queue_free')
