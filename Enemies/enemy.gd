extends CharacterBody2D

var hp := 5.0

var speed = 65
@onready var nav_agent: NavigationAgent2D = $Navigation/NavigationAgent2D

@onready var target_node = null
var home_pos = Vector2.ZERO

var aggro := 0
var chase := 0

const max_length = 2000

@onready var ray = $RayCast2D

var max_cast_to = Vector2()
var rot_laser = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	home_pos = self.global_position
	nav_agent.path_desired_distance = 4
	nav_agent.target_desired_distance = 4


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if nav_agent.is_navigation_finished():
		await get_tree().create_timer(1.5).timeout
		chase = 0
	
	if aggro == 1:
		rot_laser = global_position.direction_to(target_node.global_position).angle()
		max_cast_to = Vector2(max_length,0).rotated(rot_laser)
	
		ray.target_position = max_cast_to
		ray.force_raycast_update()
		var coll_id = ray.get_collider()
		
		if coll_id.is_in_group("player"):
			chase = 1
	
	
	if(chase == 1):
		var direction = (nav_agent.get_next_path_position() - global_position).normalized()
		
		if velocity.distance_to(Vector2(0,0)) > 5:
			var dir = rad_to_deg(velocity.angle())
			if dir > -90 and dir < 90:
				$AnimationPlayer.play("Right")
			else:
				$AnimationPlayer.play("Left")
			
		var intended_velocity = direction * speed
		nav_agent.set_velocity(intended_velocity)

func recalc_path():
	if target_node:
		if chase == 1:
			if global_position.distance_to(target_node.position) > 20:
				nav_agent.target_position = target_node.global_position
			else:
				nav_agent.target_position = global_position
	elif chase == 0:
		nav_agent.target_position = home_pos


func _on_recalculate_timeout():
#	print(target_node)
	recalc_path()


func _on_aggro_range_area_entered(area):
	aggro = 1
	target_node = area.owner
#
func _on_de_aggro_area_exited(area):
	aggro = 0
	if area.owner == target_node:
		target_node = null



func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()


