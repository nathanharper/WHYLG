
extends KinematicBody2D

export var speed = 100
export var hits = 2

var bullet = preload("res://scripts/bullet.gd")
var hero = preload("res://scripts/hero.gd")

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	var positions = get_node("/root/global").get_hero_pos()
	if positions.size() == 0:
		return
		
	var curr = get_pos()
	var closest = 1000
	var hero_pos = null
	for pos in positions:
		if curr.distance_to(pos) < closest:
			hero_pos = pos
			
	var magnitude = delta * speed
	var vdiff = hero_pos - get_pos()
	var angle = atan2(vdiff.x, vdiff.y)
	var mov_vect = Vector2(0, magnitude).rotated(angle)
	
	var sprite = get_node("Sprite")
	if mov_vect.x > 0 and ! sprite.is_flipped_h():
		sprite.set_flip_h(true)
	elif mov_vect.x < 0 and sprite.is_flipped_h():
		sprite.set_flip_h(false)
	
	var motion = move(mov_vect)
	
	if is_colliding():
		var norm = get_collision_normal()
		motion = norm.slide(motion)
		move(motion)




func _on_Area2D_body_enter( body ):
	if body extends bullet:
		body.queue_free()
		hits -= 1
		if hits == 0:
			queue_free()
	elif body extends hero:
		print("YOU DEAD")
