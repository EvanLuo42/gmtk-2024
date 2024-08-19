extends AspectRatioContainer

var index = 0
var selected_skill: Skill = PlayerSkills.gained[0]

@onready var button = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer2/HBoxContainer/Button
@onready var description = $PanelContainer/MarginContainer/VBoxContainer/Description
@onready var title = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/Title
@onready var consume_star = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/VBoxContainer/ConsumeStar
@onready var icon = $PanelContainer/MarginContainer/VBoxContainer/MarginContainer/HBoxContainer/PanelContainer/Icon

func _process(delta):
	if PlayerSkills.is_skill_in_slots(selected_skill):
		button.text = "Remove"
	else:
		button.text = "Add"
	
	button.disabled = !(PlayerSkills.stars >= 0)
	
	description.text = selected_skill.description
	title.text = selected_skill.name
	consume_star.text = str(selected_skill.stars)
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
