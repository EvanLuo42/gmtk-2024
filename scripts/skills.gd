extends Node
class_name Skills

signal block_builder

var slots: Array[Skill] = []
var gained: Array[Skill] = [preload("res://skills/block_builder.tres")]
var selected: Array[Skill] = []
var stars: int = 6

func add_remove_slot_skill(skill: Skill):
	if is_skill_in_slots(skill):
		slots = slots.filter(func(_skill): return _skill.name != skill.name)
		stars += skill.stars
		return
	if has_enough_star(skill):
		slots.append(skill)
		stars -= skill.stars

func has_enough_star(skill: Skill) -> bool:
	return stars - skill.stars >= 0

func is_skill_in_slots(skill: Skill) -> bool:
	return slots.any(func(_skill: Skill): return _skill.name == skill.name)
