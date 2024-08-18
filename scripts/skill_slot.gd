extends Control

@export var index: int

var skill: Skill

@onready var key_label = $KeyBorder/Key
@onready var icon = $Icon
@onready var key = "slot_" + str(index)

func _ready():
	key_label.text = get_key(key)
	
func _process(delta):
	if len(PlayerSkills.slots) >= index:
		skill = PlayerSkills.slots[index - 1]
	else:
		skill = null
	if skill:
		icon.texture = skill.icon
	else:
		icon.texture = null
		
	if Input.is_action_just_pressed(key) and skill:
		PlayerSkills.emit_signal(skill.signal_name)


func get_key(action: String):
	match action:
		"slot_1":
			return "G"
		"slot_2":
			return "H"
		"slot_3":
			return "J"
		"slot_4":
			return "K"
		"slot_5":
			return "L"
		
