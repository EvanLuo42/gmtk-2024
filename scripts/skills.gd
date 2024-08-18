extends Node
class_name Skills

@export var slots: Array[Skill]
@export var gained: Array[Skill]
var stars: int = 6

func add_remove_slot_skill(skill: Skill):
	if slots.any(func(_skill: Skill): return _skill.name == skill.name):
		slots = slots.filter(func(_skill): return _skill.name != skill.name)
		return
	if stars - skill.stars >= 0:
		slots.append(skill)
		stars += skill.stars

func has_enough_star(skill: Skill) -> bool:
	return stars - skill.stars >= 0
