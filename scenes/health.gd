@tool
extends Node2D

@export var max_health: float = 100.0

@export var width: int = 200:
	set(value):
		width = value
		queue_redraw()
		
@export var height: int = 30:
	set(value):
		height = value
		queue_redraw()
		
@export var fill_color: Color = Color(1, 0, 0, 1):
	set(value):
		fill_color = value
		queue_redraw()
		
#@export var stroke_color: Color = Color(0, 0, 0, 1):
#	set(value):
#		stroke_color = value
#		queue_redraw()
		
#@export var stroke_width: int = 1:
#	set(value):
#		stroke_width = value
#		queue_redraw()

@export var can_die: bool = true

@onready var health = max_health
@onready var is_dead = false

signal dead
signal change

func increment(amount):
	if is_dead and can_die:
		return
	health += amount
	if health < 0:
		health = 0
		is_dead = true
		dead.emit()
	elif health > max_health:
		health = max_health
	queue_redraw()
	change.emit()

func set_health(amount):
	if is_dead and can_die:
		return
	health = amount
	if health < 0:
		health = 0
		is_dead = true
		dead.emit()
	elif health > max_health:
		health = max_health
	queue_redraw()
	change.emit()

func set_max_health(amount):
	max_health = amount
	health = max_health

func restart():
	is_dead = false
	set_health(max_health)

func _draw():
	$Filled.size = Vector2(width * health / max_health, height)
	$Filled.modulate = Color(fill_color)
	$Empty.size = Vector2(width, height)
	$Empty.modulate = Color(fill_color, 0.5)
	#var rect = Rect2(-width / 2, -height / 2, width * health / max_health, height)
	#draw_rect(rect, fill_color)
	#draw_line(Vector2(-width / 2, -height / 2), Vector2(width / 2, -height / 2), stroke_color, stroke_width)
	#draw_line(Vector2(width / 2, -height / 2), Vector2(width / 2, height / 2), stroke_color, stroke_width)
	#draw_line(Vector2(width / 2, height / 2), Vector2(-width / 2, height / 2), stroke_color, stroke_width)
	#draw_line(Vector2(-width / 2, height / 2), Vector2(-width / 2, -height / 2), stroke_color, stroke_width)
