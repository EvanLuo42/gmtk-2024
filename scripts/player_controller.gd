extends Node2D

@onready var man = preload("res://nodes/man.tscn")
@onready var cat = preload("res://nodes/cat.tscn")
@onready var ball = preload("res://nodes/ball.tscn")
@onready var camera = $"../PhantomCamera2D"
@onready var now_char	
@onready var status = 0
@onready var start_cnt = 0.2
@onready var is_start = 0
@onready var grav = 1

func _ready():
	_on_man()
	PlayerSkills.connect("cat", _cat)


func _process(delta):
	position = Vector2(now_char.position.x, now_char.position.y)
	grav = now_char.gravity_dir
	if !is_start:
		start_cnt -= delta
		if start_cnt<=0:
			_cat()
			is_start = true
	if Input.is_action_just_pressed("change_ball") and status == 0:
		PlayerSignal.destroy.emit()
		_on_ball()
	elif Input.is_action_just_released("change_ball") and status == 0:
		PlayerSignal.destroy.emit()
		_on_cat()


func _cat():
	if status == 0:
		_on_man()
		status = 1
	else:
		_on_cat()
		status = 0
		

func _on_cat():
	var _cat = cat.instantiate()
	now_char = _cat
	$"..".add_child(_cat)
	_cat.position = Vector2(position.x, position.y)
	_cat.gravity_dir = grav
	
func _on_man():
	var _man = man.instantiate()
	now_char = _man
	$"..".add_child(_man)
	_man.position = Vector2(position.x, position.y)
	_man.gravity_dir = grav

func _on_ball():
	var _ball = ball.instantiate()
	now_char = _ball
	$"..".add_child(_ball)
	_ball.position = Vector2(position.x, position.y)
	_ball.gravity_dir = grav
