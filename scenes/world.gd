extends Node2D

@onready var restart_entrance = null

func _on_player_dead():
	$Map.restart_room()
	if restart_entrance != null:
		$Player.restart(restart_entrance.restart_position())

func _on_map_enter_room(room, entrance):
	restart_entrance = entrance
