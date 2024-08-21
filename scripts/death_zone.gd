extends Area2D

func _on_body_exited(body: Node2D) -> void:
	if body is Character:
		body.position = GameState.respawn_position
		body.velocity = Vector2.ZERO
