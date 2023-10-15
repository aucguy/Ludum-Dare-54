extends Node2D

@onready var parameters = $"/root/Parameters"

func _ready():
	process_mode = Node.PROCESS_MODE_DISABLED
	hide()
	parameters.load_params()
	if parameters.debug:
		$ParameterReloadTimer.start()
	$HUD.hide()
	$MapContainer/Map/Player/Health.connect('change', sync_health)
	$"/root/StateManager".game = self

func _process(_delta):
	$Camera.position = $MapContainer/Map/Player.global_position

func restart_callback():
	$Camera.position = $MapContainer/Map/Player.global_position

func sync_health():
	$HUD/Health.set_health($MapContainer/Map/Player/Health.health)

func _on_timer_timeout():
	parameters.reload_params()

func start():
	process_mode = Node.PROCESS_MODE_PAUSABLE
	get_tree().paused = false
	modulate.a = 1
	$HUD/Health.modulate.a = 1
	show()
	$HUD.show()
	var timer = get_tree().create_timer(1)
	await timer.timeout
	$"/root/SoundManager".play_sound('Music')

func pause():
	get_tree().paused = true
	modulate.a = 0.5
	$HUD/Health.modulate.a = 0.5
	
func resume():
	get_tree().paused = false
	modulate.a = 1
	$HUD/Health.modulate.a = 1
	
func exit():
	process_mode = Node.PROCESS_MODE_DISABLED
	hide()
	$HUD.hide()
