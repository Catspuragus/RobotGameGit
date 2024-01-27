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
	

	if firing == 1:
		rot_laser = get_local_mouse_position().angle()
		max_cast_to = Vector2(max_length,0).rotated(rot_laser)
	
		ray.target_position = max_cast_to
		ray.force_raycast_update()
		var raycastcoll = ray.get_collision_point()
		var coll_id = ray.get_collider()
		
		
		
		line.add_point(global_position)
		if ray.is_colliding() && coll_id != null:
#			print("ayup")
			var coll_obj = coll_id
			if coll_id.get_parent().is_in_group("kill"):
				coll_obj = coll_id.get_parent()
			
			line.add_point(raycastcoll)
			if coll_obj.is_in_group("kill"):
				coll_obj.hp -= 30 * delta
				if coll_obj.hp <= 0:
					coll_obj.queue_free()
				print(coll_obj.hp)
