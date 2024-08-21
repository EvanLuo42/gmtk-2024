extends AspectRatioContainer

var index = 0
var selected_skill: Skill = PlayerSkills.gained[0]

@onready var button = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer2/HBoxContainer/Control/Button
@onready var description = $PanelContainer/MarginContainer/VBoxContainer/Description
@onready var title = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/Title
@onready var consume_star = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/ConsumeStar
@onready var icon = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/PanelContainer/Icon

var tween_hover: Tween


func _process(delta):
	if PlayerSkills.is_skill_in_slots(selected_skill):
		button.text = "Remove"
	else:
		button.text = "Add"
	
	button.disabled = !(PlayerSkills.stars >= 0)
	
	description.text = selected_skill.description
	title.text = selected_skill.name
	consume_star.text = "Consume " + str(selected_skill.stars) + " stars"
	icon.texture = selected_skill.icon


func _on_button_button_down():
	PlayerSkills.add_remove_slot_skill(selected_skill)


func _on_arrow_left_button_down():
	if index != 0:
		index -= 1
		selected_skill = PlayerSkills.gained[index]


func _on_arrow_right_button_down():
	if index + 1 < len(PlayerSkills.gained):
		index += 1
		selected_skill = PlayerSkills.gained[index]


func _on_button_mouse_entered():
	button.pivot_offset = button.size / 2
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(button, "scale", Vector2(1.2, 1.2), 0.5)


func _on_button_mouse_exited():
	button.pivot_offset = button.size / 2
	if tween_hover and tween_hover.is_running():
		tween_hover.kill()
	tween_hover = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_ELASTIC)
	tween_hover.tween_property(button, "scale", Vector2(1, 1), 0.5)
