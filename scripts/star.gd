extends TextureRect

@export var index: int

@onready var full: Texture2D = preload("res://sprites/ui/ui_star_full.png")
@onready var empty: Texture2D = preload("res://sprites/ui/ui_star_empty.png")

func _process(delta):
	if index <= PlayerSkills.stars:
		texture = full
	else:
		texture = empty
