extends WorldEnvironment

@onready var World = self.environment
# Called when the node enters the scene tree for the first time.
func _ready():
	match Global.Level:
		0:
			World.set_adjustment_saturation(0)
			World.set_adjustment_contrast(1.3)
		1:
			World.set_adjustment_saturation(.4)
			World.set_adjustment_contrast(1)
		2:
			World.set_adjustment_saturation(.6)
			World.set_adjustment_contrast(1)
		3:
			World.set_adjustment_saturation(.7)
			World.set_adjustment_contrast(1)
		4:
			World.set_adjustment_saturation(1)
			World.set_adjustment_contrast(1)
