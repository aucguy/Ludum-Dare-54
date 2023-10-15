extends Node2D

signal beat_big_fire

func _ready():
	for child in get_children():
		if child.is_in_group('big_fire'):
			child.connect('dead', beat_big_fire_callback)
	
	reset()

func reset():
	process_mode = Node.PROCESS_MODE_DISABLED
	hide()
	
	for child in get_children():
		if child.is_in_group('fire'):
			child.reset()

func beat_big_fire_callback():
	beat_big_fire.emit()

func start():
	process_mode = Node.PROCESS_MODE_PAUSABLE
	show()
	
	for child in get_children():		
		if child.is_in_group('fire'):
			child.start()
	
func disable():
	for child in get_children():
		if child.is_in_group('fire'):
			child.disable()

func get_total_big_fires():
	var result = 0
	
	for child in get_children():
		if child.is_in_group('big_fire'):
			result += 1
			
	return result
