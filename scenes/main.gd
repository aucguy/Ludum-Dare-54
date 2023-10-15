extends Node

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	$"/root/StateManager".connect('win_signal', win_callback)

func _process(_delta):
	if Input.is_action_just_released('pause_menu'):
		if $Menus/PauseMenu.visible:
			$Menus/PauseMenu._on_resume_button_pressed()
		else:
			$Menus/PauseMenu.show()
			$Game.pause()

func _on_main_menu_start_play():
	$Menus/MainMenu.hide()
	$Game.start()

func _on_pause_menu_resume_game():
	$Menus/PauseMenu.hide()
	$Game.resume()

func _on_pause_menu_exit_game():
	$"/root/SoundManager".stop_all_sounds()
	$Game.exit()
	$Menus/PauseMenu.hide()
	$Menus/MainMenu.show()
	get_tree().paused = true

func win_callback():
	$"/root/SoundManager".stop_all_sounds()
	$Game.exit()
	$Menus/PauseMenu.hide()
	$Menus/MainMenu.show()
	get_tree().paused = true
