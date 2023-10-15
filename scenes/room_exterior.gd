extends Node2D

const is_room_exterior_instance = true

signal enter_room

func _ready():
	for child in get_children():
		if child.is_in_group('entrances'):
			child.connect('enter_room', func(): enter_room.emit(child))

func lock():
	for child in get_children():
		if child.is_in_group('entrances'):
			child.lock()

func unlock():
	for child in get_children():
		if child.is_in_group('entrances'):
			child.unlock()
