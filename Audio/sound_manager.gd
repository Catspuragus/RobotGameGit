extends Node2D

@onready var song1 = $Level1
@onready var song2 = $Level2
@onready var song3 = $Level3

# Called when the node enters the scene tree for the first time.
func _ready():
	match Global.Level:
		0:
			song1.play()
		1:
			song2.play()
		2:
			song3.play()



