extends CharacterBody2D

var hp := 5.0

var speed = 50
@onready var nav_agent: NavigationAgent2D = $Navigation/NavigationAgent2D

@onready var target_position = Vector2(-100,-100)

var aggro := 0
var chase := 0
var fed := false

# Called when the node enters the scene tree for the first time.
func _ready():
	nav_agent.path_desired_distance = 30
	nav_agent.target_desired_distance = 30


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	
	if aggro == 1:
		if fed:
			chase = 1
		elif Input.is_action_pressed("ordE"):
			fed = true
			chase = 1
	
	
	
	var direction = (nav_agent.get_next_path_position() - global_position).normalized()
	var intended_velocity = direction * speed
	nav_agent.set_velocity(intended_velocity)

func recalc_path():
	if chase == 1:
		nav_agent.target_position = target_position
	elif chase == 0:
		nav_agent.target_position = global_position


func _on_recalculate_timeout():
	recalc_path()


func _on_aggro_range_area_entered(area):
	aggro = 1

#
func _on_navigation_agent_2d_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()


func _on_aggro_range_area_exited(area):
	aggro = 0
	await get_tree().create_timer(1).timeout
	if aggro == 0:
		chase = 0