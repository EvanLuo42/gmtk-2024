extends Button

@onready var book = $"../HBoxContainer"


func _process(delta):
	if Input.is_key_pressed(KEY_ESCAPE):
		_on_button_down()


func _on_button_down():
	book.visible = false
	self.visible = false
