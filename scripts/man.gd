extends CharacterBody2D
class_name Character

@export var speed = 5.0
@export var acceleration = 4.0
@export var deceleration = 4.0
@export var jump_speed = 8.0
@export var gravity = 3.0

var gravity_dir = 1

@onready var land_ray = $LandRay
@onready var coyote_ray = $CoyoteRay
@onready var animated_sprite = $AnimatedSprite2D
@onready var camera = $"../PhantomCamera2D"

@onready var block = preload("res://nodes/block.tscn")
@onready var cat = preload("res://nodes/cat.tscn")

func _ready():
	PlayerSkills.connect("block_builder", _on_block_builder)
	PlayerSkills.connect("gravity_change", _on_gravity_change)
	PlayerSkills.connect("cat", _on_cat)

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
	if Input.is_action_just_pressed("jump") and (land_ray.is_colliding() or (is_on_ceiling() and gravity_dir < 0) or is_on_floor()):
		velocity.y = gravity_dir * jump_speed
		
	if (is_on_floor() or is_on_ceiling()) and dir != 0:
		animated_sprite.play("walk")
	elif is_on_floor() and dir == 0:
		animated_sprite.play("idle")
	elif (is_on_floor() or is_on_ceiling()) and velocity.y < 0:
		animated_sprite.play("jump")
	elif velocity.y > 0:
		animated_sprite.play("fall")
	else:
		animated_sprite.play("idle")
		

func _on_block_builder():
	var _block = block.instantiate()
	$"../".add_child(_block)
	_block.position = Vector2(position.x + -bool_to_int(animated_sprite.flip_h) * 100, position.y)
	var dir_x = Input.get_axis("left", "right")
	var dir_y = Input.get_axis("up", "down")
	var dir = Vector2.RIGHT * -bool_to_int(animated_sprite.flip_h)
	if dir_x != 0 or dir_y != 0:
		dir = Vector2(dir_x, dir_y)
	
	_block.gravity_dir = gravity_dir
	_block.velocity = dir * _block.speed
	
	
func _on_gravity_change():
	gravity_dir = gravity_dir * -1


func _on_cat():
	queue_free()
	pass

func bool_to_int(value: bool):
	if value:
		return 1
	else:
		return -1
