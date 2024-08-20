extends Control

var character_tween: Tween
var cat_tween: Tween

@onready var cat = $Cat
@onready var character = $Character
@onready var timer = $Timer

var level = preload("res://main.tscn")

func _ready() -> void:
	if character_tween and character_tween.is_running():
		character_tween.kill()
	character_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	character_tween.tween_property(character, "position:y", character.position.y - 600, 0.8)
	timer.start()


func _on_timer_timeout() -> void:
	if cat_tween and cat_tween.is_running():
		cat_tween.kill()
	cat_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	cat_tween.tween_property(cat, "position:y", cat.position.y - 400, 0.8)
	timer.stop()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(level)
