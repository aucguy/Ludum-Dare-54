extends Node2D

@export var map: PackedScene

const parameters = preload('res://parameters.gd')

func _ready():
	parameters.load_params()
	var instance = map.instantiate()
	add_child(instance)
