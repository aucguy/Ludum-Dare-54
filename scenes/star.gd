extends Node2D

func _on_node_2d_body_entered(body):
	if body.is_in_group('player'):
		$"/root/StateManager".win()
