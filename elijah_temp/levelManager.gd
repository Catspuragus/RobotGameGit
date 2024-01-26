class_name Level extends Node2D

var worldNum: int
var mission = '' # temporary string (TODO: mission class) // if a world has more than one mission
var missions = [mission] # maybe just int
var completedMissions = 0 # ^^
var levelComplete: bool = false # condition to progress to next level
var worldType # color scheme (or overlay) mayhaps
var worldSize # for generation in walker script
var worldEnemies # ^^
var worldDescription = Array() # in case I won't to send it all at once (or could be use for narrative // just str)

# I don't know how to make nor parse a JSON lmfao
var levelsList = {
	1:
		{
			"Type:": 0,
			"Size": 0,
			"Enemies": 0,
			# Dialouge? probably will be a part of missions class
			"Missions":
				[
					# List of missions (string)
					1	# "Hunting wabbits"
				]
		},
	2:
		{
			"Type:": 0,
			"Size": 0,
			"Enemies": 0,
			# Dialouge? probably will be a part of missions class
			"Missions":
				[
					# List of missions (string)
					3 # "Collectig berries"	
				]
		},	
	3:
		{
			"Type:": 0,
			"Size": 0,
			"Enemies": 0,
			# Dialouge? probably will be a part of missions class
			"Missions":
				[
					# List of missions (string)
					4 # "Serving cupcakes"	
				]
		},	
}
	
	
func _init(levNum = 0):#, type = 0, size = 0, enemies = 0, m = []):
	self.worldNum = levNum
	self.worldType = self.levelsList[levNum]["Type"]
	self.worldSize = self.levelsList[levNum]["Size"]
	self.worldEnemies = self.levelsList[levNum]["Enemies"]	
	self.worldDescription = [self.worldType, self.worldSize, self.worldEnemies]
	
	missions = levelsList[levNum]["Missions"]
	for m in self.levelsList[levNum]["Missions"]:
		missions.append(Mission.new(m))
		
	completedMissions = 0
	levelComplete =  false

func levelStatus() -> bool:
	if self.completedMissions < missions.size():
		return false
	return true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

