extends Button

@onready var book = $"../HBoxContainer"
@onready var close_button = $"../CloseButton"

var tween_close: Tween

func _on_button_down():
	if tween_close and tween_close.is_running():
			tween_close.kill()
	tween_close = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	tween_close.tween_property(book, "position:y", 70, 0.2)
	tween_close.tween_property(close_button, "position:y", 155, 0.3)
	
	
func _process(delta):
	if Input.is_action_just_pressed("open_book"):
		_on_button_down()
