@tool

extends Node2D

@export var sprite_frames: SpriteFrames = null:
	set(value):
		$AnimatedSprite2D.sprite_frames = value
		sprite_frames = value

func _ready():
	$AnimatedSprite2D.sprite_frames = sprite_frames
	
func update(velocity):
	if velocity.length() < 1e-5:
		$AnimatedSprite2D.stop()
		return
	
	var angle = velocity.angle()
	if angle < 0:
		angle += 2 * PI
	
	if angle < 1.0 / 8 * PI or angle > 15.0 / 8 * PI:
		$AnimatedSprite2D.play('right')
		$AnimatedSprite2D.flip_h = false
	elif angle < 3.0 / 8 * PI:
		$AnimatedSprite2D.play('downright')
		$AnimatedSprite2D.flip_h = false
	elif angle < 5.0 / 8 * PI:
		$AnimatedSprite2D.play('down')
		$AnimatedSprite2D.flip_h = false
	elif angle < 7.0 / 8 * PI:
		$AnimatedSprite2D.play('downright')
		$AnimatedSprite2D.flip_h = true
	elif angle < 9.0 / 8 * PI:
		$AnimatedSprite2D.play('right')
		$AnimatedSprite2D.flip_h = true
	else: #angle < 15.0 / 8 * PI
		$AnimatedSprite2D.play('up')
		$AnimatedSprite2D.flip_h = false
