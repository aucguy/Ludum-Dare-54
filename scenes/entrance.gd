extends Area2D

signal enter_room

@export var orientation:  = 'left'

func _ready():
	$Gate.set_orientation(orientation)

func _on_body_entered(body):
	if body.is_in_group('player'):
		enter_room.emit()

func lock():
	for child in get_children():
		if child.is_in_group('gates'):
			child.lock()
	
	$Semicircle.hide()

func unlock():
	for child in get_children():
		if child.is_in_group('gates'):
			child.unlock()
			
func restart_position():
	return $RestartPosition.global_position
