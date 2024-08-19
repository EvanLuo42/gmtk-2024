extends Button

@onready var book = $"../HBoxContainer"


func _on_button_down():
	book.visible = false
	self.visible = false
