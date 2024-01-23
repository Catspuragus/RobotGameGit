extends CharacterBody2D

@export var speed = 90 #max speed
@export var acceleration = 30
@export var friction = 15
@export var roll_speed = 120

@onready var gun = 0 #if you're going to start gronk off with something, you must set its state to pickedup

var can_pick_up = false
var weapon_can_be_picked = 0

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE
var roll_vector = Vector2.DOWN

@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true

func move_state():
	var input_direction = Input.get_vector("ordA", "ordD", "ordW", "ordS")
	
	if input_direction != Vector2.ZERO:
		roll_vector = input_direction
		
		animationTree.set("parameters/Idle/blend_position",input_direction)
		animationTree.set("parameters/Run/blend_position",input_direction)
		animationTree.set("parameters/Dodge/blend_position",input_direction)
		animationState.travel("Run")
		
		velocity += input_direction * acceleration
		velocity = velocity.limit_length(speed)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO,friction)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("L_Click"):
#		state = ATTACK
		pass
		
	if Input.is_action_just_pressed("ordE"):
		if can_pick_up == true:
			pickup_weapon()
			can_pick_up == false
			
	if Input.is_action_just_pressed("ordP"):
		drop_weapon()
	
	if Input.is_action_just_pressed("vk_Space"):
		state = ROLL

func attack_state():
	state = MOVE

func drop_weapon():
	if get_children().has(gun):
		
		remove_child(gun)
		get_tree().get_root().add_child(gun)
		
		gun.global_position = global_position
		gun.global_position.y -= 4
		
		gun.state = gun.DROPPED
		
		gun = 0

func pickup_weapon():
	if get_children().has(gun) == false:
		gun = weapon_can_be_picked
		
		gun.get_parent().remove_child(gun)
		add_child(gun)
		gun.global_position = global_position
		gun.global_position.y -= 4
		
		gun.state = gun.PICKEDUP
		
		can_pick_up = false
		weapon_can_be_picked = 0

func roll_state():
	animationState.travel("Dodge")
	if $RollTime.time_left >= .2:
		velocity = roll_vector * roll_speed
	else:
		velocity = roll_vector * 75
	move_and_slide()
	if $RollTime.is_stopped() == true:
		$RollTime.start(.6)
	
	
func _physics_process(_delta):
	do_animation(_delta)
	match state:
		MOVE:
			move_state()
		ROLL:
			roll_state()
		ATTACK:
			attack_state()

func do_animation(_delta):
	$AnimationTree.advance(_delta*.7)

func _on_roll_time_timeout():
	state = MOVE
	velocity = roll_vector * speed
	print("OK")
	$RollTime.stop()
	pass # Replace with function body.
	

