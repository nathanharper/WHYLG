
extends KinematicBody2D

export var angle = 0.0
export var speed = 100

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	var change = get_movement_vector(delta)
	
	if ! get_node("/root").get_rect().has_point(get_pos()):
		queue_free()
	
	if is_colliding():
		queue_free()
		
	var motion = move(change)
	

func get_movement_vector(delta):
	return Vector2(0, speed * delta).rotated(angle)


