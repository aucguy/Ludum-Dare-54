extends Node2D

signal enter_room
signal beat_room

@onready var current_room = null

func _ready():
	for child in get_children():
		if child.is_in_group('room_containers'):
			child.connect('enter_room', enter_room_callback)
			child.connect('beat_room', beat_room_callback)
			
func enter_room_callback(room, entrance):
	current_room = room
	enter_room.emit(room, entrance)

func beat_room_callback():
	beat_room.emit()

func restart_room():
	if current_room != null:
		current_room.destroy()
