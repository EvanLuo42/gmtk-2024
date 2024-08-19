extends CharacterBody2D

@export var speed: float
@export var gravity: float

var gravity_dir = 1

func _physics_process(delta):
	velocity.y += gravity * gravity_dir * delta
	
	if is_on_ceiling() or is_on_floor() or is_on_wall():
		velocity = Vector2.ZERO
	move_and_slide()
	
