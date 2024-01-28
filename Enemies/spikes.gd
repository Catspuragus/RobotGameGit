extends CharacterBody2D

var hp := 5.0

# Called when the node enters the scene tree for the first time.
func _ready():
	match Global.Level:
		0:
			$Spikes.frame = 0
		1:
			$Spikes.frame = 0
		2:
			$Spikes.frame = 1
		3:
			$Spikes.frame = 1
		4:
			$Spikes.frame = 1
