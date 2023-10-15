extends Node2D

@export var map: PackedScene

@onready var parameters = $"/root/Parameters"

func _ready():
	parameters.load_params()
	var instance = map.instantiate()
	add_child(instance)
