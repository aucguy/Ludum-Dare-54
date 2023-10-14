extends Node2D

const parameters = preload('res://parameters.gd')

func _ready():
	parameters.load_params()
	if parameters.debug:
		$ParameterReloadTimer.start()
	$World/Player/Health.connect('change', sync_health)
	#$World/Player/Health.connect('dead', player_dead)
	$"/root/SoundManager".play_sound('Music')

func _process(delta):
	$World/Camera.position = $World/Player.position
	
func sync_health():
	$HUD/Health.set_health($World/Player/Health.health)

func _on_timer_timeout():
	parameters.reload_params()
