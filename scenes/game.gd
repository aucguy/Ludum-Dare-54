extends Node2D

func _ready():
	$World/Player/Health.connect('change', sync_health)
	#$World/Player/Health.connect('dead', player_dead)

func _process(delta):
	$World/Camera.position = $World/Player.position
	
func sync_health():
	$HUD/Health.set_health($World/Player/Health.health)

