extends Control

signal resume_game
signal exit_game

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_resume_button_pressed():
	resume_game.emit()

func _on_exit_button_pressed():
	exit_game.emit()
