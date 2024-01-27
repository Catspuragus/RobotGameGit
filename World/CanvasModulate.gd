extends CanvasModulate

const NIGHT_COLOR = Color("d5e800")
const DAY_COLOR = Color("ffffff")

var time = 0

func _process(delta:float) -> void:
	self.time += delta	
	self.color = NIGHT_COLOR.lerp(DAY_COLOR, (sin((PI/2)*cos(time/5))+1)/2)
