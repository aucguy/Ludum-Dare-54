extends Node2D

var is_room_instance = true

var total_big_fires
var big_fires_beaten = 0
var beaten = false

func _ready():
	for child in get_children():
		if child.is_in_group('RoomExteriors'):
			child.connect('enter_room', func(entrance): enter_room_callback(entrance))
		elif child.is_in_group('RoomInteriors'):
			child.connect('beat_big_fire', on_beat_big_fire)
			total_big_fires = child.get_total_big_fires()

func on_beat_big_fire():
	big_fires_beaten += 1
	if big_fires_beaten >= total_big_fires:
		$"/root/StateManager".beat_room(self)

func reset():
	$RoomInterior.reset()
	$RoomExterior.unlock()
	
func start():
	$RoomInterior.start()
	$RoomExterior.lock()

func beat_room():
	beaten = true
	$RoomInterior.disable()
	$RoomExterior.unlock()

func enter_room_callback(entrance):
	if not beaten:
		$"/root/StateManager".enter_room(self, entrance)
