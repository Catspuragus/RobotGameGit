extends CharacterBody2D

var hp := 5.0
var sprite = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	match sprite:
		0:
			$Spikes.frame = 0
		1:
			$Spikes.frame = 1

func updateSprite():
	match sprite:
		0:
			$Spikes.frame = 0
		1:
			$Spikes.frame = 1
