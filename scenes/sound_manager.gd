extends Node

const FADE_VOLUME = -10
const FADE_INTERVAL = 2

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

func stop_all_sounds():
	for child in get_children():
		child.stop()
		child.seek(0)
		
func fade_sound(sound_name):
	var stream = get_node(sound_name)
	if stream == null:
		print('unknown sound ' + sound_name)
		return
	
	var original_volume = stream.volume_db
	var tween = get_tree().create_tween()
	tween.tween_property(stream, 'volume_db', FADE_VOLUME, FADE_INTERVAL)
	await tween.finished
	stream.stop()
	stream.seek(0)
	stream.volume_db = original_volume

func set_repeating(sound_name):
	var stream = get_node(sound_name)
	if stream == null:
		print('unknown sound ' + sound_name)
		return
		
	stream.connect('finished', func(): play_sound(sound_name))	

func _ready():
	set_repeating('Music')
