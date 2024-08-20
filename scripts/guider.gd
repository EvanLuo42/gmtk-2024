extends Node2D


func _on_body_entered(body: Node2D) -> void:
	if Dialogic.current_timeline != null:
		return

	Dialogic.start('tutorial')
