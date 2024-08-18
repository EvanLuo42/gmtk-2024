extends Control

@export_enum("Slot 1:G", "Slot 2:H", "Slot 3:J", "Slot 4:K", "Slot 5:L") 
var slot_index: String = "G"

var skill: Skill

@onready var key = $Key
@onready var icon = $Icon

func _ready():
	key.text = slot_index
	
func _process(delta):
	if skill:
		icon.texture = skill.icon
