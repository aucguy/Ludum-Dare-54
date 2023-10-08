extends StaticBody2D

func _ready():
	hide()
	set_collision_layer_value(1, false)
	
func lock():
	show()
	set_collision_layer_value(1, true)

func unlock():
	hide()
	set_collision_layer_value(1, false)
	
func set_orientation(orientation):
	if orientation == 'left':
		$AnimatedSprite2D.flip_v = false
	elif orientation == 'right':
		$AnimatedSprite2D.flip_v = true
