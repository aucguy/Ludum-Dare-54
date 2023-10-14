extends Node2D

@onready var restart_entrance = null

func _ready():
	var map = get_node_or_null('MapContainer/Map')
	if map != null:
		map.connect('enter_room', _on_map_enter_room)
		map.connect('beat_room', _on_map_beat_room)

func _on_player_dead():
	if restart_entrance != null:
		$Player.restart(restart_entrance.restart_position())
	$MapContainer/Map.restart_room()

func _on_map_enter_room(room, entrance):
	restart_entrance = entrance
	$Player.full_heal()

func _on_map_beat_room():
	$Player.full_heal()
