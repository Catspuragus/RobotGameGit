extends Node
class_name Walker

const DIRECTION = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]

var position = Vector2.ZERO
var direction = Vector2.RIGHT
var borders = Rect2()

var step_history = [] #for ALL
var path_history = [] #for only the digging path, not rooms

var steps_since_turn = 0
var steps_since_turn_max = 8
#var steps_since_turn_max = 4
var rooms = []

func _init(starting_position, new_borders):
	assert(new_borders.has_point(starting_position))
	position = starting_position
	step_history.append(position)
	borders = new_borders
	
func walk(steps):
	place_room(position)
	for step in steps:
#		if randf() <= 0.35 || steps_since_turn >= steps_since_turn_max:
		if steps_since_turn >= steps_since_turn_max:
			change_direction()
		
		if step():
			step_history.append(position)
			path_history.append(position)
		else:
			change_direction()
	return step_history

func step():
	var target_position = position + direction
	if borders.has_point(target_position):
		steps_since_turn += 1
		position = target_position
		return true
	else:
		return false

func change_direction():
	place_room(position)
	steps_since_turn = 0
	var directions = DIRECTION.duplicate()
	directions.erase(direction)
	directions.shuffle()
	direction = directions.pop_front()
	while not borders.has_point(position + direction):
		direction = directions.pop_front()


func create_room(position, size):
		return {position = position, size = size}


	
func place_room(position):
	var size = Vector2(randi() % 4+4, randi() % 4+4)
	var top_left_corner = (position - size/2).ceil()
	rooms.append(create_room(position, size))
	for y in size.y:
		for x in size.x:
			var new_step = top_left_corner + Vector2(x,y)
			if borders.has_point(new_step):
				if !step_history.has(new_step):
					step_history.append(new_step)
	
func get_end_room():
	var end_room = rooms.front()
	var starting_position = step_history.front()
	for room in rooms:
		if starting_position.distance_to(room.position) > starting_position.distance_to(end_room.position):
			end_room = room
	return end_room

func random_room(final_room):
	var temp_rooms = rooms
	var starting_room_temp = temp_rooms.pop_front()
	
	temp_rooms.remove_at(temp_rooms.find(final_room))
	temp_rooms.shuffle()
	return temp_rooms
