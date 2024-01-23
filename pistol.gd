extends CharacterBody2D

const bulletPath = preload('res://bullet.tscn')
var direction = Vector2.ZERO

var fire_rate = .3
var can_fire = true

enum {
	DROPPED,
	PICKEDUP
}

var state = DROPPED

func _ready():
	$Epopup.visible = false

func _process(_delta):
	if state == PICKEDUP:
		look_at(get_global_mouse_position())
#		direction = global_position.angle_to_point(get_global_mouse_position())
#		rotation = direction

func _physics_process(_delta):
	match state:
		PICKEDUP:
			position = position.move_toward(Vector2(0,-4),.5)
			z_index = 0
			
			if Input.is_action_pressed('L_Click') and can_fire:
				shoot()
				cooldown()
			
			do_rotation()
			
		DROPPED:
			z_index = -1
			pass

func do_rotation():
	if rotation_degrees > 360:
		rotation_degrees -= 360
	if rotation_degrees < 0:
		rotation_degrees += 360
		
	if(rotation_degrees > 90 && rotation_degrees < 270):
			scale.y = -1
	else:
			scale.y = 1


func shoot():
	position = position + Vector2(1,0).rotated(rotation) * -3
	var bullet_speed = randi_range(350,250)
	var ranDir = randi_range(2,-2)
	var bullet = bulletPath.instantiate()
	
	get_tree().get_root().add_child(bullet)
	bullet.position = $Marker2D.global_position
	bullet.rotation_degrees = rotation_degrees + ranDir
	bullet.set_linear_velocity(Vector2(bullet_speed,0).rotated(deg_to_rad(rotation_degrees+ranDir)))

func cooldown():
	can_fire = false
	await get_tree().create_timer(fire_rate).timeout
	can_fire = true



func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if state == DROPPED:
		var body_owner = body.name
		body.can_pick_up = true
		body.weapon_can_be_picked = self
		if !is_instance_valid(body.gun):
			$Epopup.visible = true

func _on_area_2d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if state == DROPPED and is_instance_valid(body.weapon_can_be_picked) and body.weapon_can_be_picked == self:
		var body_owner = body.name
		body.can_pick_up = false
		body.weapon_can_be_picked = 0
	$Epopup.visible = false
	
