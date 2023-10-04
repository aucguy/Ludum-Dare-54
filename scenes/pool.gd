extends Area2D

@export var refill_speed: int = 10
@export var capacity: int = 25

func _ready():
	$Health.set_max_health(capacity)

func _process(delta):
	$Health.increment(delta * refill_speed)

func _on_body_entered(body):
	if body.is_in_group('player'):
		body.hurt(-$Health.health)
		$Health.set_health(0)
