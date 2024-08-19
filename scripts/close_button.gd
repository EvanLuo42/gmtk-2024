extends Button

@onready var book = $"../HBoxContainer"

var tween_close: Tween


func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		_on_button_down()


func _on_button_down():
	if tween_close and tween_close.is_running():
		tween_close.kill()
	tween_close = create_tween().set_trans(Tween.TRANS_QUAD)
	tween_close.tween_property(book, "position:y", -700, 0.2)
	tween_close.tween_property(self, "position:y", -500, 0.3)
