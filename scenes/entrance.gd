extends Area2D

signal enter_room

@onready var active = true

func _on_body_entered(body):
	if body.is_in_group('player'):
		enter_room.emit()

func lock():
	if not active:
		return
	
	for child in get_children():
		if child.is_in_group('gates'):
			child.lock()

func unlock():
	active = false
	for child in get_children():
		if child.is_in_group('gates'):
			child.unlock()
