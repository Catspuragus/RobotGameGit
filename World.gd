extends Node2D

const Player = preload("res://Player/gronk.tscn")
const Camera = preload("res://camera_2d.tscn")
const Exit = preload("res://door.tscn")

const Gun = preload("res://shotgun.tscn")
const Pistol = preload("res://pistol.tscn")

var borders = Rect2(1,1,100,80)

@onready var tileMap = $Mangrove
@onready var tileMap2 = $"Dirt Path"
@onready var tileMap3 = $"Rock_Path"

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_level()


func _input(event):
	if event.is_action_pressed("ui_accept"):
		reload_level()

func reload_level():
	get_tree().reload_current_scene()

func generate_level():
	randomize()
	var walker = Walker.new(Vector2(50,30), borders)
	var map = walker.walk(150)
	
	var player = Player.instantiate()
	add_child(player)
	player.position = map.front()*32
	player.position.y += 16
	player.position.x += 16
	
	var camera = Camera.instantiate()
	player.add_child(camera)
	
	var exit = Exit.instantiate()
	add_child(exit)
	
	exit.position = walker.get_end_room().position*32
#	exit.connect("leaving_level", self, "reload_level")

	var gun = Gun.instantiate()
	add_child(gun)
	gun.global_position = map.front()*32
	
	var gun2 = Pistol.instantiate()
	add_child(gun2)
	gun2.global_position = walker.path_history[1]*32
	
	var gun3 = Gun.instantiate()
	add_child(gun3)
	gun3.global_position = walker.path_history[2]*32
	
	
	walker.queue_free()
	
	var cells = []
	for location in map:
		cells.append(location)
		
	tileMap2.set_cell(0,map.front(),0,Vector2i(0,0),0)
#	tileMap2.set_cells_terrain_connect(0,cells,0,0)
	tileMap3.set_cells_terrain_connect(0,walker.path_history,0,0)
	tileMap.set_cells_terrain_connect(0,cells,0,-1)
	
#	tileMap.update_bitmask_region(borders.position,borders.end)
