extends Node2D

@export var particle_scene: PackedScene
@export var spawn_rate: int = 50
@export var velocity: int = 250
@export var max_distance: int = 100

@onready var particles = []
@onready var clock = 0
@onready var total_spawned = 0
@onready var spraying = false
@onready var direction = null

func _process(delta):
	if not spraying:
		return
	clock += delta
	while clock * spawn_rate > total_spawned:
		var angle = randf() * 1 / 4 * PI - 1.0 / 8 * PI
		var velocity_vec = Vector2(velocity, 0).rotated(angle + direction.angle())
		var particle = particle_scene.instantiate()
		particle.init(velocity_vec, max_distance, global_position)
		add_child(particle)
		total_spawned += 1

func start_spray(direction):
	spraying = true
	self.direction = direction

func end_spray():
	spraying = false
	direction = null

func restart():
	end_spray()
	get_tree().call_group('water_particles', 'queue_free')
