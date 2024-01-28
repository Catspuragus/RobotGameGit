class_name Mission extends Node2D

var goalCount: int = 0
var dialogueCount: int = 0

var thisName: String
var playerInstr: String
var targetObj
var objectiveGoal: int
var listDialogue = []
var goalCompleted: bool = false

var missionDic = [
	{
		"Name": "DANGER: SPIKES!!1",
		"Instructions": "Use LASER EYES to destroy the SPIKES scattered around the area.",
		"Target": 
			{
				"Name": "Spikes",
				"Object": preload("res://Enemies/spikes.tscn")
			},
		"Objective": 6,
		"Dialogue": [
			"LEA:\tDANGER: DETECTED. Hazards present in area. Must destroy.",
			"Mission: COMPLETE\n...........
			Seeking new mission......"
		]
	},
	{
		"Name": "WHO'S WATCHING??",
		"Instructions": "Use LASER EYES to destroy guard towers.",
		"Target": 
			{
				"Name": "Spikes", # ****************** CHANGE ************************
				"Object": preload("res://Enemies/spikes.tscn")
			},
		"Objective": 3,
		"Dialogue": [
			"LEA:\tDANGER: DETECTED.... Guard towers identified. Destruction initiated.",
			"Mission: COMPLETE
			.........
			[Invalid Querie]..........
			[System Check]........ Fucntion is true. Resuming protocol: LEA
			Seeking new mission......"
		]
	},
	{
		"Name": "Hunting Wabbits",
		"Instructions": "Use LASER EYES to destroy Rab-bots.",
		"Target": 
			{
				"Name": "Rabbots",
				"Object": preload("res://Enemies/enemy.tscn")
			},
		"Objective": 4,
		"Dialogue": [
			"LEA:\tDANGER: DETECTED. Rab-bots must be destroyed",
			"Mission: ...?...
			[Invalid Querie]....Unregistered Input......?
			[SYNTAX ERROR] >> [REBOOT]
			[System Check]........ Fucntion is true. Resuming protocol: LEA
			Mission: COMPLETE."
		]
	},
	{
		"Name": "$$p1K3$",
		"Instructions": "Use LASER EYES to destroy the SPIKES scattered around the area.",
		"Target": 
			{
				"Name": "Spikes",
				"Object": preload("res://Enemies/spikes.tscn")
			},
		"Objective": 7,
		"Dialogue": 
		[
			"LEA:\tDANGER: ..uncertain.....Destruction... unnecessary?
			[SYNTAX ERROR] >> [REBOOT]
			[System Check]........ Fucntion is true. Resuming protocol: LEA",
			"Mission: COMPLETE. \t[Response('Uncomfortable'): SUBMITTED] >> [Status: QUEUED]
			Seeking new mission......"
		]
	},
	{
		"Name": "An empty forest",
		"Instructions": "Investigate TOWERS around the area.",
		"Target": 
			{
				"Name": "Rabbots", # ****************** CHANGE ************************
				"Object": preload("res://Enemies/enemy.tscn")
			},
		"Objective": 5,
		"Dialogue": 
		[
			"LEA:\tDANGER: Undetected
			[PROTOCOL: UPDATED] >> [REBOOT]
			[START PROTOCOL]: Investigate",
			"No danger detected. Mission: COMPLETE
			[SYSTEM // CREATE: PROTOCOL(###)]
			Seeking new mission......"
		]
	},
	{
		"Name": "Flipping bits",
		"Instructions": "Collect the Rab-bots.",
		"Target": 
			{
				"Name": "Bunny",
				"Object": preload("res://Enemies/cutebunny.tscn")
			},
		"Objective": 4,
		"Dialogue": 
		[
			"DANGER: ..Unlikely?
			[Invalid Querie] ....Unregistered Protocol....
			[System Check]........ Fucntion is true. Resuming protocol: LEA
			Lasers engaged. Kill mode..... [ERROR] >> [REBOOT]
			LEA:\tDANGER: ...Possible??
			[PROTOCOL: UPDATED] >> [REBOOT]
			[START PROTOCOL]: Investigate",
			"Mission: COMPLETE\n.........
			[Response('Comfy'): SUBMITTED] >> [Status: COMPLETED]"
		]
	},
	{
		"Name": "It smells like spring time",
		"Instructions": "Use WATER EYES to water the FL around the area.",
		"Target": 
			{
				"Name": "Flowers",
				"Object": preload("res://Enemies/spikes.tscn")
			},
		"Objective": 4,
		"Dialogue": 
		[
			"DANGER: Absent. No threats detected.
			My programming does not include a protocol for this.
			..............
			[SYSTEM // UTITLITIES: UPDATED] >> [PROTOCOL: UPDATED] >> [REBOOT]",
			"Mission: COMPLETE. \t[Response('Wonderful!'): SUBMITTED]
			Seeking new mission......"
		]
	},
	{
		"Name": "Shawty Gardening",
		"Instructions": "Use WATER EYES to grow SEEDS around the area.",
		"Target": 
			{
				"Name": "Spikes", # ****************** CHANGE ************************
				"Object": preload("res://Enemies/spikes.tscn")
			},
		"Objective": 4,
		"Dialogue": 
		[
			"DANGER: Absent. GROWTH: Imminent. NURTURE: Required.",
			"Mission: COMPLETE. \t[Response('I Feel Fantastic!'): SUBMITTED]
			Seeking new mission......"
		]
	},
	{
		"Name": "Prarie Bot",
		"Instructions": "Use LASER EYES to fences surrounding the bunnies.",
		"Target": 
			{
				"Name": "Bunny",
				"Object": preload("res://Enemies/cutebunny.tscn")
			},
		"Objective": 4,
		"Dialogue": 
		[
			"DANGER: Undetected. HAPPINESS: Possible.
			[SYSTEM // UTITLITIES: UPDATED] >> [PROTOCOL: UPDATED] >> [REBOOT]",
			"Laughter: Engaged\tHappiness: Activated
			Perhaps this was Life’s Ultimate Victory all along.
			[SYSTEM // Protocol(LUV): COMPLETED]"
		]
	},
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _init(missionNum: int):
	thisName = missionDic[missionNum]["Name"]
	playerInstr = missionDic[missionNum]["Instructions"]
	targetObj = missionDic[missionNum]["Target"]
	objectiveGoal = missionDic[missionNum]["Objective"]
	listDialogue = missionDic[missionNum]["Dialogue"]

	dialogueCount = 0
	goalCount = 0
	goalCompleted = false
	

func getMissionText():
	return ("Mission: %s" % self.thisName) + ("\n%s" % self.playerInstr)
	
# Returns mission completion based on objectives collected
func getMissionComplete(count:int = self.goalCount) -> bool:
	return !(count < self.objectiveGoal)
	
# Returns target object
func getTargetObject():
	return [self.targetObj["Name"], self.targetObj["Object"]]

func getObjectiveGoal():
	return self.objectiveGoal
	
func getDialogue(thisD: int = self.dialogueCount):
	# verify if there is any more dialogue
	if thisD >= self.listDialogue.size():
		return "There is nothing left to say"
	
	self.dialogueCount+=1
	return self.listDialogue[thisD].split("\n")

func incrimentCount(inc:int = 1):
	self.goalCount += inc
	

func completeMission():
	pass
	
	
