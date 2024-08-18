extends CharacterBody2D

@export var speed = 5.0
@export var acceleration = 4.0
@export var deceleration = 4.0
@export var jump_speed = 8.0
@export var gravity = 3.0

@onready var land_ray = $LandRay
@onready var coyote_ray = $CoyoteRay

func _physics_process(delta):
	velocity.y += gravity * delta
	var dir = Input.get_axis("left", "right")
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, deceleration)

	move_and_slide()
	if Input.is_action_just_pressed("jump") and (land_ray.is_colliding() or coyote_ray.is_colliding()):
		velocity.y = jump_speed
	
