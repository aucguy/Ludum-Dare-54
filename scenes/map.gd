extends Node2D

signal enter_room
signal beat_room

@onready var current_room = null

func _ready():
	for child in get_children():
		if 'is_room_instance' in child:
			pass
	
	$"/root/StateManager".map = self

func _process(_delta):
	show()

func enter_room_callback(room, entrance):
	current_room = room
	enter_room.emit(room, entrance)

func beat_room_callback():
	beat_room.emit()

#func restart_room():
#	if current_room != null:
#		current_room.destroy()
		
func fadeout_callback():
	var tween = get_tree().create_tween()
	tween.tween_property(self, 'modulate', Color(0, 0, 0, 1), 2)
	await tween.finished
	modulate = Color(1, 1, 1, 1)
	hide()
