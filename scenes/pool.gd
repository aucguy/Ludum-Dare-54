extends Area2D

@onready var parameters = $"/root/Parameters"

func _ready():
	$Health.set_max_health(parameters.pool_capacity)

func _process(delta):
	$Health.increment(delta * parameters.pool_refill_speed)

func _on_body_entered(body):
	if body.is_in_group('player'):
		body.hurt(-$Health.health)
		$Health.set_health(0)
		$"/root/SoundManager".play_sound('Heal')
