class_name Mission extends Node2D

var goalCount: int = 0

var thisName: String
var playerInstr: String
var targetObj: String
var objectiveGoal: int
var listDialogue = []
var goalCompleted: bool = false

var missionDic = [
	{
		"Name": "Avenge My Clan",
		"Instructions": "Find and eliminate the goons in the forest.",
		"Target": "Goons",
		"Objective": 5,
		"Dialogue": [
			"My entire village was extinguished by some goons!" # maybe multiple lines of dialogue
		]
	},
	{
		"Name": "Hunting Wabbits",
		"Instructions": "Collect the rabbits",
		"Target": "Rabbits",
		"Objective": 3,
		"Dialogue": [
			"These fucking rabbits are eating all of our crops!" 
		]
	},
	{
		"Name": "Find My Friend",
		"Instructions": "Guide the lost friend to town safely.",
		"Target": "Billy Joe",
		"Objective": 1
	},
	{
		"Name" :"Starving Kid",
		"Instructions": "Bring back berried from the forest.",
		"Target": "Berries",
		"Objective": 4
	},
	{
		"Name": "Happy Birthday?",
		"Instructions": "Deliver cupcakes to the party guests.",
		"Target": "Children",
		"Objective": 7
	}
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
	
	goalCount = 0
	goalCompleted = false
	

func getMissionText():
	return ("Mission: %s" % self.thisName) + ("\n%s" % self.playerInstr)
	
# Returns mission completion based on objectives collected
func getMissionStatus(count:int = self.goalCount) -> bool:
	return !(count < self.objectiveCount)
	
func incrimentCount(inc:int = 1):
	self.goalCount += inc
