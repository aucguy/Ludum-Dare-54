@tool
extends Area2D

signal enter_room

var instance = null
var rect = null
var active = false
var big_fires_beaten
var total_big_fires

@export var room: PackedScene:
	set(value):
		room = value
		if Engine.is_editor_hint():
			if instance != null:
				instance.queue_free()
			instance = value.instantiate()
			add_child(instance)

func _ready():
	if Engine.is_editor_hint():
		return
	
	big_fires_beaten = 0
	total_big_fires = 0
	active = false
	instance = room.instantiate()
	var tilemap = instance.get_node('TileMap')
	var tile_size = tilemap.tile_set.tile_size
	rect = tilemap.get_used_rect()
	#rect = Rect2(
		#rect.position - rect.size * tile_size / 2,
		#rect.position * tile_size,
	#	Vector2.ZERO,
	#	rect.size * tile_size
	#)
	$CollisionShape2D.position = Vector2(rect.position * tile_size) + \
		Vector2(rect.size) / 2.0 * Vector2(tile_size)
	$CollisionShape2D.shape.size = rect.size * tile_size
	
	for child in instance.get_children():
		if child.is_in_group('entrances'):
			instance.remove_child(child)
			child.connect('enter_room', enter_room_callback)
			add_child(child)
		elif child.is_in_group('big_fire'):
			child.connect('dead', beat_big_fire)
			total_big_fires += 1

#func __draw():
#	if Engine.is_editor_hint() and rect != null and not active:
#		return

#	draw_rect(rect, Color(0, 1, 0))

#func __process(delta):
#	if Engine.is_editor_hint() or rect == null or active:
#		return
	
#	var player = get_tree().get_first_node_in_group('player')
#	if player == null:
#		return
	
#	var global_rect = Rect2(
#		rect.position + global_position,
#		rect.size
#	)
	
#	if rect.has_point(player.position):
#		active = true
#		add_child(instance)
#		queue_redraw()

func _on_body_entered(body):
	return
	if Engine.is_editor_hint():
		return
	
	if body.is_in_group('player'):
		active = true
		add_child(instance)
		move_child(instance, 0)
		queue_redraw()
		collision_layer = 0

func enter_room_callback(entrance):
	if Engine.is_editor_hint():
		return
	
	enter_room.emit(self, entrance)
	
	active = true
	add_child(instance)
	move_child(instance, 0)
	queue_redraw()
	collision_layer = 0
	
	for child in get_children():
		if child.is_in_group('entrances'):
			child.lock()

func beat_big_fire():
	big_fires_beaten += 1
	if big_fires_beaten == total_big_fires:
		beat_room()

func beat_room():
	for child in get_children():
		if child.is_in_group('entrances'):
			child.unlock()
	
	for child in instance.get_children():
		if child.is_in_group('fire'):
			child.disable()
			
	get_tree().call_group('enemies', 'queue_free')
	
func destroy():
	instance.queue_free()
	
	for child in get_children():
		if child.is_in_group('entrances'):
			child.queue_free()
			
	_ready()
