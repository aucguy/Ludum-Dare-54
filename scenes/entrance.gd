extends Area2D

signal enter_room

@export var orientation:  = 'left'
@onready var active = true

func _ready():
	$Gate.set_orientation(orientation)

func _on_body_entered(body):
	if body.is_in_group('player'):
		enter_room.emit(self)

func lock():
	if not active:
		return
	
	for child in get_children():
		if child.is_in_group('gates'):
			child.lock()
	
	$Semicircle.hide()

func unlock():
	active = false
	for child in get_children():
		if child.is_in_group('gates'):
			child.unlock()
			
func restart_position():
	return $RestartPosition.global_position
