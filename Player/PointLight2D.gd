extends PointLight2D

const NIGHT_ENERGY = 1.0
const DAY_ENERGY = 0.0

var time = 0

func _process(delta:float) -> void:
	self.time += delta
	set_energy(lerp(NIGHT_ENERGY,DAY_ENERGY, (sin((PI/2)*cos(time/5))+1)/2,))
