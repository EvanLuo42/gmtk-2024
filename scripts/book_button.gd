extends Button

@onready var book = $"../HBoxContainer"

func _on_button_down():
	book.visible = true


func _process(delta):
	if Input.is_action_just_pressed("open_book"):
		book.visible = !book.visible
