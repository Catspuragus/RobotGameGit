extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$VSlider.set_value_no_signal(Global.Volume)
	$VBoxContainer/StartButton.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://UI/Menu.tscn")


func _on_quit_button_pressed():
	get_tree().quit()


func _on_v_slider_value_changed(value):
	Global.Volume = value
	AudioServer.set_bus_volume_db(0,linear_to_db(value))
