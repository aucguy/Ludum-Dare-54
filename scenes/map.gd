extends Node2D

signal enter_room
signal beat_room

@onready var current_room = null

func _ready():
	for child in get_children():
		if 'is_room_instance' in child:
			pass
			
func enter_room_callback(room, entrance):
	current_room = room
	enter_room.emit(room, entrance)

func beat_room_callback():
	beat_room.emit()

func restart_room():
	if current_room != null:
		current_room.destroy()
