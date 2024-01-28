extends Node

var Level = 0
var Volume = .2

func _ready():
	AudioServer.set_bus_volume_db(0,linear_to_db(Volume))
