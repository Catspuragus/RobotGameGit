class_name Level extends Node2D

var worldNum: int
var mission = '' # temporary string (TODO: mission class) // if a world has more than one mission
var missions = [] # maybe just int
var completedMissions = 0 # ^^
var levelComplete: bool = false # condition to progress to next level
var worldType # color scheme (or overlay) mayhaps
var worldSize # for generation in walker script
var worldIntro # ^^
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
			"Introduction": 
					"DANGER: Imminent. Lasers engaged. Kill Mode activated. 
					MISSION will be achieved.",
			"Missions":
				[
					0,1,2
				]
		},
	2:
		{
			"Type": 1,
			"Size": 1,
			"Introduction": 
					"Systems re-calibrated... 
					Time to carry out my purpose and achieve the ultimate victory.",
			"Missions":
				[
					3,4,5
				]
		},	
	3:
		{
			"Type": 0,
			"Size": 0,
			"Introduction": 
					"Systems re-calibrated... 
					Time to carry out my purpose. 
					Ultimate victory feels imminent."
				,
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
	self.worldIntro = self.levelsList[levNum]["Introduction"]	
	#self.worldDescription = [self.worldType, self.worldSize, self.worldEnemies]
	self.missions = self.levelsList[levNum]["Missions"]
	
	completedMissions = 0
	levelComplete =  false
	#if levNum != 0:
	#startText()
	currMission = Mission.new(missions[completedMissions])
	
	#print(self.currMission.getObjectiveGoal())
	
	#print(self.currMission.getTargetObject())
	

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
	add_child(newTB)
	startText() # Level Intro
	displayMission()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if currMission.getMissionComplete():
		sendText()
#		self.incrimentMissions()

func incrimentMissions():
	self.completedMissions+=1
	if !self.getLevelComplete():
		#print(self.missions.size())
		#print(self.completedMissions)
		self.currMission = Mission.new(missions[completedMissions])
		displayMission()

func startText():
	sendText(self.worldIntro.split("\n"))
		
func sendText(mes = currMission.getDialogue()):
	for str in mes:
		newTB.queueText(str)
	#newTB.queueText(currMission.getMissionText())
	
func displayMission():
	sendText()
	newTB.queueText(currMission.getMissionText())

func incrGoalCount():
	currMission.incrimentCount()

func getLevelComplete():
	return !(self.completedMissions < self.missions.size())
