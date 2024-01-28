class_name Level extends Node2D

var worldNum: int
var mission = '' # temporary string (TODO: mission class) // if a world has more than one mission
var missions = [] # maybe just int
var completedMissions = 0 # ^^
var levelComplete: bool = false # condition to progress to next level
var worldType # color scheme (or overlay) mayhaps
var worldSize # for generation in walker script
var worldEnemies # ^^
var worldDescription = Array() # in case I won't to send it all at once (or could be use for narrative // just str)

var thePlayer
var currMission
@onready var tb = preload("res://elijah_temp/text_box.tscn")
@onready var newTB = tb.instantiate()

# I don't know how to make nor parse a JSON lmfao
var levelsList = {
	1:
		{
			"Type": 1,
			"Size": 8,
			#"Enemies": 0,
			# Dialouge? probably will be a part of missions class
			"Missions":
				[
					0,1,2
				]
		},
	2:
		{
			"Type": 1,
			"Size": 1,
			#"Enemies": 0,
			# Dialouge? probably will be a part of missions class
			"Missions":
				[
					3,4,5
				]
		},	
	3:
		{
			"Type": 0,
			"Size": 0,
			#"Enemies": 0,
			# Dialouge? probably will be a part of missions class
			"Missions":
				[
					6,7,8
				]
		},	
}
	
	
func _init(levNum = 1):#, type = 0, size = 0, enemies = 0, m = []):
	self.worldNum = levNum
	self.worldType = self.levelsList[levNum]["Type"]
	self.worldSize = self.levelsList[levNum]["Size"]
	#self.worldEnemies = self.levelsList[levNum]["Enemies"]	
	self.worldDescription = [self.worldType, self.worldSize, self.worldEnemies]
	self.missions = self.levelsList[levNum]["Missions"]
	
	completedMissions = 0
	levelComplete =  false
	currMission = Mission.new(missions[completedMissions])

func getLevelStatus() -> bool:
	if self.completedMissions < missions.size():
		return false
	return true

func getObjective():
	return self.currMission.getTargetObject()
	
func getObjectiveGoal():
	return self.currMission.getObjectiveGoal()
	
func setPlayer(player):
	self.thePlayer = player

func getPlayer():
	return self.thePlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	#startText()
	add_child(newTB)
	sendText()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if currMission.getMissionComplete():
		print("Entering sleep move") # queue in textbox
		self.incrimentMissions()

func incrimentMissions():
	if self.completedMissions < self.missions.size():
		self.completedMissions+=1
		self.currMission = Mission.new(missions[completedMissions])
	else:
		self.levelComplete = true

func startText():
	#tb.queueText("This came from the level")
	pass

func sendText(this = newTB):
	print(currMission.getDialogue())
	for str in currMission.getDialogue():
		this.queueText(str)
	
	
func getLevelComplete():
	return self.levelComplete
