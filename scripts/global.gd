extends Node

var hero_positions = Vector2Array([null, null])

func set_hero_pos(index, pos):
	hero_positions.set(index, pos)
	
func get_hero_pos():
	return hero_positions