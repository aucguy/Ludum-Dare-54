extends Node2D

@onready var parameters = $"/root/Parameters"

func _ready():
	parameters.load_params()
	if parameters.debug:
		$ParameterReloadTimer.start()
	$MapContainer/Map/Player/Health.connect('change', sync_health)
	$"/root/SoundManager".play_sound('Music')

func _process(_delta):
	$Camera.position = $MapContainer/Map/Player.global_position
	
func sync_health():
	$HUD/Health.set_health($MapContainer/Map/Player/Health.health)

func _on_timer_timeout():
	parameters.reload_params()
