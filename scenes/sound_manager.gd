extends Node

func play_sound(name):
	var stream = get_node(name)
	if stream == null:
		print('unknown sound ' + name)
		return
	
	if not stream.playing:
		stream.play()

func stop_sound(name):
	var stream = get_node(name)
	if stream == null:
		print('unknown sound ' + name)
		return
	
	stream.stop()
