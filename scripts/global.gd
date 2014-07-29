extends Node

var hero_positions = [null, null]

func set_hero_pos(index, pos):
	hero_positions[index] = pos
	
func get_hero_pos():
	return hero_positions