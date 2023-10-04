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
