extends Character

func _physics_process(delta):
	velocity.y += gravity * gravity_dir * delta
	animated_sprite.flip_v = gravity_dir < 0
	var dir = Input.get_axis("left", "right")
	if dir != 0:
		animated_sprite.flip_h = dir < 0
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, deceleration)

	move_and_slide()
	if Input.is_action_just_pressed("jump") and (land_ray.is_colliding() or (is_on_ceiling() and gravity_dir < 0)):
		velocity.y = gravity_dir * jump_speed
