extends Area2D

var velocity
var max_distance
var pos
@onready var distance = 0

func init(velocity, max_distance, origin):
	self.velocity = velocity
	self.max_distance = max_distance
	pos = origin
	scale = Vector2(2, 2)
	add_to_group('water_particles')

func _process(delta):
	pos += delta * velocity
	global_position = pos
	distance += delta * velocity.length()
	if distance > max_distance:
		queue_free()

func _on_body_entered(body):
	queue_free()

func _on_area_entered(area):
	queue_free()
