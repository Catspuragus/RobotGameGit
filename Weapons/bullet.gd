extends RigidBody2D


func _on_body_entered(body):
	if !body.is_in_group("player"):
		queue_free()

func _physics_process(delta):
	if abs(linear_velocity) <= Vector2(10,10):
		modulate.a -= 1 * delta
	if(modulate.a <= .1):
		queue_free()

