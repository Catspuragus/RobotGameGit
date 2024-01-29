extends Node2D

const Player = preload("res://Player/gronk.tscn")
const Camera = preload("res://Player/camera_2d.tscn")
const Exit = preload("res://World/Objects/door.tscn")

const Gun = preload("res://Weapons/Old_Weapons/shotgun.tscn")
const Pistol = preload("res://Weapons/Old_Weapons/pistol.tscn")
const Enemy = preload("res://Enemies/enemy.tscn")
const Bunny = preload("res://Enemies/cutebunny.tscn")
const Spikes = preload("res://Enemies/spikes.tscn")

var borders = Rect2(1,1,100,80)

var playerHealth = 10
var currLevel
var temp_rooms = []
var objectivesMet = 0
var listObjects = []
var exitPP: Vector2

@onready var healthText = $UI/HP
@onready var countText = $UI/Count
@onready var tileMap = $Mangrove
@onready var tileMap2 = $"Dirt Path"
@onready var tileMap3 = $"Rock_Path"
@onready var Navigation = $Navigation_Path

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_level()


func _input(event):
	if event.is_action_pressed("vk_backslash"):
		incriment_level()

	if event.is_action_pressed("ordE"):
		forceMission()
	pass
	
func incriment_level():
	if(Global.Level < 3 - 1): #i put -1 cause it starts off at 0 and i dont want to do math (3)
		Global.Level += 1
		reload_level()
	else:
		get_tree().change_scene_to_file("res://credits.tscn")
	
func reload_level():
	get_tree().reload_current_scene()

func generate_level():
	currLevel = Level.new(Global.Level + 1)
	add_child(currLevel)
	randomize()
	var walker = Walker.new(Vector2(50,30), borders) # starting posistion, room size
	var map = walker.walk(100) # total steps (level size basically)?
	
	var player = Player.instantiate()
	add_child(player)
	player.position = map.front()*32
	player.position.y += 16
	player.position.x += 16
	
	var camera = Camera.instantiate()
	player.add_child(camera)
	
	currLevel.setPlayer(player) # give player to level
	
	var exit = Exit.instantiate()
	add_child(exit)
	
	var end_room = walker.get_end_room()
	exitPP = end_room.position*32
	exit.position = exitPP
#	exit.connect("leaving_level", self, "reload_level")
	temp_rooms = (walker.random_room(end_room))
	

#	var gun2 = Pistol.instantiate()
#	add_child(gun2)
#	gun2.global_position = walker.path_history[1]*32
#
#	var gun3 = Gun.instantiate()
#	add_child(gun3)
#	gun3.global_position = walker.path_history[2]*32
	
	
	walker.queue_free()
	
	var cells = []
	for location in map:
		cells.append(location)
		
#	tileMap2.set_cell(0,map.front(),0,Vector2i(0,0),0) #DIRT
#	tileMap2.set_cells_terrain_connect(0,cells,0,0)
	tileMap3.set_cells_terrain_connect(0,walker.path_history,0,0) #ROCK PATH
	
	Navigation.set_cells_terrain_connect(0,cells,0,0) #NAVIGATION PATHs
	tileMap.set_cells_terrain_connect(0,cells,0,-1) #WALLS
	
#	tileMap.update_bitmask_region(borders.position,borders.end)
	
#	*** SPAWNING THINGS ***
#	var bunny_spawnz = 0
#	var max_bunz = 5
#
#	var enemy_spawnz = 0
#	var max_enemyz = 5
#
#	var spike_spawnz = 0
#	var max_spikez = 5
#

#
#	while bunny_spawnz < max_bunz && enemy_spawnz < max_enemyz && spike_spawnz < max_spikez:
#		for room in temp_rooms:
#			var top_left_corner = (room.position - room.size/2).ceil()
#			for y in room.size.y:
#				for x in room.size.x:
#					var new_step = top_left_corner + Vector2(x,y)
#					var new_step2 = new_step*32
#					if borders.has_point(new_step) && new_step2.distance_to(player.global_position) > 150:
#						if randf() <= .05 && enemy_spawnz < max_enemyz:
#							var enemy = Enemy.instantiate()
#							add_child(enemy)
#							enemy.home_pos = new_step2 + Vector2(16,16)
#							enemy.global_position = new_step2 + Vector2(16,16)
#							enemy_spawnz += 1
#
#						elif randf() <= .05 && bunny_spawnz < max_enemyz:
#							var bunny = Bunny.instantiate()
#							add_child(bunny)
#							bunny.global_position = new_step2 + Vector2(16,16)
#							bunny.target_position = exit.global_position + Vector2(randi_range(55,-55), randi_range(55,-55))
#							bunny_spawnz += 1
#
#						elif randf() <= .05 && spike_spawnz < max_spikez:
#							var spikes = Spikes.instantiate()
#							add_child(spikes)
#							spikes.global_position = new_step2 + Vector2(16,16)
#							spike_spawnz += 1
	playerHealth = 10
	spawnObjectives()

func forceMission():
	#listObjects.clear()
	if currLevel.getLevelComplete():
		currLevel.sendText(["Entering sleep mode"])
		incriment_level()
	else:
		currLevel.incrimentMissions()
		objectivesMet = 0
		spawnObjectives()

func hurtPlayer():
	playerHealth -= 1 
	
func incrGoalCount():
	objectivesMet += 1
	currLevel.incrGoalCount()
	
func spawnObjectives():
	var spawnedObjectives = 0
	var maxSpawns = currLevel.getObjectiveGoal()
	var objectiveType = currLevel.getObjective()
	#var objName = objectiveType[0]
	#var objObject = objectiveType[1]
	var pp = currLevel.getPlayer()
	while spawnedObjectives < maxSpawns:
		for room in temp_rooms:
			#print(room)
			var top_left_corner = (room.position - room.size/2).ceil()
			for y in room.size.y:
				for x in room.size.x:
					var new_step = top_left_corner + Vector2(x,y)
					var new_step2 = new_step*32
					if borders.has_point(new_step) && new_step2.distance_to(pp.global_position) > 150:
						if randf() <= .05 && spawnedObjectives < maxSpawns:
							var obj = objectiveType[1].instantiate() # object preload from level class
							add_child(obj)
							spawnedObjectives+=1
							#listObjects.append(obj)
							match objectiveType[0]: # object name from level class
								"Rabbots":
									obj.home_pos = new_step2 + Vector2(16,16)
									obj.global_position = new_step2 + Vector2(16,16)
									#spawnedObjectives += 1
								
								"Bunny":
									obj.global_position = new_step2 + Vector2(16,16)
									obj.target_position = exitPP + Vector2(randi_range(55,-55), randi_range(55,-55))
									#spawnedObjectives += 1
									
								"Spikes":
									obj.global_position = new_step2 + Vector2(16,16)
									obj.sprite = 1
									obj.updateSprite()
									#spawnedObjectives += 1
								"Flowers":
									obj.global_position = new_step2 + Vector2(16,16)
									obj.sprite = 0
									obj.updateSprite()
									#spawnedObjectives += 1
								
								"Towers":
									obj.global_position = new_step2 + Vector2(16,16)
								
								"Trees":
									obj.global_position = new_step2 + Vector2(16,16)
								
func _physics_process(delta):
	healthText.text = "HP: " + str(playerHealth)
	countText.text = "REMAINING: " + str(currLevel.getObjectiveGoal() - objectivesMet)
	if playerHealth <= 0:
		reload_level()
		
	if objectivesMet >= currLevel.getObjectiveGoal():
		forceMission()
