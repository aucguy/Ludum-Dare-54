extends Node2D

signal start_play

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_play_button_pressed():
	start_play.emit()

func _on_exit_button_pressed():
	get_tree().quit()
