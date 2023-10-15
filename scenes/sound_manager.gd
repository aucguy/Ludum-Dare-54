extends Node

func play_sound(sound_name):
	var stream = get_node(sound_name)
	if stream == null:
		print('unknown sound ' + sound_name)
		return
	
	if not stream.playing:
		stream.play()

func stop_sound(sound_name):
	var stream = get_node(sound_name)
	if stream == null:
		print('unknown sound ' + sound_name)
		return
	
	stream.stop()


func set_repeating(sound_name):
	var stream = get_node(sound_name)
	if stream == null:
		print('unknown sound ' + sound_name)
		return
		
	stream.connect('finished', func(): play_sound(sound_name))	

func _ready():
	set_repeating('Music')
