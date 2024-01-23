extends Node2D

var firing := 0
var bounces = 1
const max_length = 2000

@onready var line = $Line2D
@onready var ray = $RayCast2D
var max_cast_to = Vector2()
var rot_laser = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	max_cast_to = Vector2(max_length,0).rotated(rot_laser)
	ray.target_position = max_cast_to
	$Line2D.set_as_top_level(true)
	$Line2D.antialiased = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	line.clear_points()
	rot_laser = get_local_mouse_position().angle()
	max_cast_to = Vector2(max_length,0).rotated(rot_laser)
	var raycastcoll = ray.get_collision_point()
	ray.target_position = max_cast_to
		
	if firing == 1:
		line.add_point(global_position)
		if ray.is_colliding():
			line.add_point(raycastcoll)
