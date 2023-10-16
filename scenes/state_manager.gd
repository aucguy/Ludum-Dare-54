extends Node2D

signal beat_room_signal
signal win_signal
var map = null
var game = null
var won = false

@onready var current_room = null
@onready var restart_position = null

func enter_room(room, entrance):
	if current_room != null:
		return
	
	current_room = room
	restart_position = entrance.restart_position()
	room.reset()
	room.start()

func beat_room(room):
	room.beat_room()
	beat_room_signal.emit()
	get_tree().call_group('enemies', 'queue_free')
	current_room = null
	
func is_in_room():
	return current_room != null
	
func restart():
	if current_room == null:
		return
	
	await fadeout()
	get_tree().call_group('enemies', 'queue_free')
	current_room.reset()
	current_room = null

func fadeout():
	if map != null:
		await map.fadeout_callback()

func end_restart():
	if game != null:
		game.restart_callback()

func win():
	if won:
		return
	
	won = true
	$"/root/SoundManager".play_sound('BeatRoom')
	$"/root/SoundManager".fade_sound('Music')
	await fadeout()
	win_signal.emit()
	won = false
