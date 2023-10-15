extends Node

func _ready():
	get_tree().paused = true

func _process(_delta):
	if Input.is_action_just_released('pause_menu'):
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
