extends CharacterBody2D

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
@onready var man = preload("res://nodes/man.tscn")



@onready var normal_speed = speed
@onready var dash_speed = 2100
@onready var dashable = true
@onready var dash = false
@onready var dash_max_time = 0.2
@onready var dash_timer = 0
@onready var dash_cd = 0.7
@onready var dash_cd_timer = 0

func _ready():
	PlayerSkills.connect("block_builder", _on_block_builder)
	PlayerSkills.connect("gravity_change", _on_gravity_change)
	PlayerSkills.connect("cat", _on_man)
	PlayerSignal.connect("destroy",_on_man)

func _process_dash(delta):
	if dash:
		speed = dash_speed
		dash_timer+=delta
		if dash_timer>=dash_max_time:
			dash_timer = 0
			dash = false
	else:
		speed = normal_speed
	if !dashable and !dash:
		dash_cd_timer += delta
		if dash_cd_timer >= dash_cd:
			dashable = true
		

func _physics_process(delta):
	velocity.y += gravity * gravity_dir * delta
	if dash:
		velocity.y = 0
	animated_sprite.flip_v = gravity_dir < 0
	var dir = 0.0;
	if !dash:
		dir = Input.get_axis("left", "right")
	else:
		dir = -1*float(int(animated_sprite.flip_h)*2-1)
	_process_dash(delta)
	if dir != 0:
		animated_sprite.flip_h = dir < 0
	if Input.is_action_just_pressed("jump") and (land_ray.is_colliding() or (is_on_ceiling() and gravity_dir < 0)):
		velocity.y = gravity_dir * jump_speed
	move_and_slide()

func bool_to_int(value: bool):
	if value:
		return 1
	else:
		return -1
func _on_man():
	queue_free()
	pass
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
