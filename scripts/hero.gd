 
extends KinematicBody2D

export(int, "basic", "super") var weapon = 0
export var speed = 10 # movement multiplier
export var threshold = 0.2 # motions below threshold are ignored
export(int) var hero_number


var lr1 = 0.0
var ud1 = 0.0
var lr2 = 0.0
var ud2 = 0.0

var radius


var bullet = preload("res://scenes/bullet.scn")
var timer

func _ready():
	radius = get_node("Sprite").get_texture().get_width() / 2
	timer = get_node("Timer")
	set_process_input(true)
	set_fixed_process(true)
	
func _fixed_process(delta):
	var change = Vector2(lr1, ud1) * speed * delta
	change = move(change)
	
	if is_colliding():
		change = get_collision_normal().slide(change)
		move(change)
		
	get_node("/root/global").set_hero_pos(hero_number, get_pos())
	
	if abs(lr2) > 0 or abs(ud2) > 0:
		set_rot(get_angle(lr2, ud2))
		
		if timer.get_time_left() <= 0:
			fire_weapon()
			timer.start()
	else:
		timer.stop()
		
	
func _input(event):
	if event.is_action("ud_1"):
		ud1 = normal(event.value)
	elif event.is_action("lr_1"):
		lr1 = normal(event.value)
	elif event.is_action("ud_2"):
		ud2 = normal(event.value)
	elif event.is_action("lr_2"):
		lr2 = normal(event.value)
		
func normal(num):
	if abs(num) >= threshold:
		return num * 10
	return 0.0
	
func get_angle(x, y):
	return atan2(x, y)
	
func fire_weapon():
	if weapon == 0: #basic
		var blt = bullet.instance()
		blt.set_pos(get_bullet_pos())
		blt.set("angle", get_rot())
		blt.set("speed", 500)
		get_node("/root").add_child(blt)
		PS2D.body_add_collision_exception(get_rid(), blt.get_rid())
		PS2D.body_add_collision_exception(blt.get_rid(), get_rid())
		
		
func get_bullet_pos():
	return Vector2(0, radius).rotated(get_rot()) + get_pos()
	
	


