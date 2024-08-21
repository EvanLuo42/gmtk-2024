extends StaticBody2D

func _on_body_entered(body: Node) -> void:
	if body is Character:
		body.position = GameState.respawn_position
