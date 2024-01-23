extends Sprite2D
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotation = -get_parent().rotation * get_parent().scale.y
	global_position = get_parent().global_position + (Vector2(1,0).rotated(get_parent().rotation) * 6)
	global_position.y = get_parent().global_position.y - 17
	scale.y = get_parent().scale.y
