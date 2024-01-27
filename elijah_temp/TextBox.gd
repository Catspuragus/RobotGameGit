extends CanvasLayer

const CRR: float = 0.05  # char read rate
@onready var tbContainer = $TextboxContainer
@onready var startSymb = $TextboxContainer/MarginContainer/HBoxContainer/Start
@onready var endSymb = $TextboxContainer/MarginContainer/HBoxContainer/End
@onready var label = $TextboxContainer/MarginContainer/HBoxContainer/Label

@onready var tween: Tween = create_tween()

enum State {
	READY,
	READING,
	FINISHED
}

var currState = State.READY
var textQueue = []
# Called when the node enters the scene tree for the first time.
func _ready():
	hideTB()
	queueText("This text should be the third in queue")
	queueText("The quick brown fox jumped over the lazy dog.")
	for text in textQueue:
		print(text)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		match currState:
			State.READY:
				if !textQueue.is_empty():
					displayText()
					changeState(State.READING)
					
			State.READING:
				if Input.is_action_just_pressed("ui_accept"):
					label.visible_ratio = 1.0
					tween.kill()
					tween = create_tween()
					endSymb.text = "v"
					changeState(State.FINISHED)
					
			State.FINISHED:
				if Input.is_action_just_pressed("ui_accept"):
					print("Input accepted")
					changeState(State.READY)
					hideTB()

func queueText(newText):
	textQueue.push_back(newText)
	
func hideTB():
	startSymb.text = ""
	endSymb.text = ""
	label.text = ""
	tbContainer.hide()
	
func showTB():
	print("Show TB")
	startSymb.text = "*"
	tbContainer.show()
	
func displayText():
	print("Display Text")
	var newText = textQueue.pop_front()
	label.text = newText
	label.visible_ratio = 0.0
	showTB()
	tween = create_tween()
	tween.tween_property(label, "visible_ratio", 1.0, len(newText) * CRR).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_LINEAR)
	tween.connect("finished", _on_Tween_tween_finished)

func _on_Tween_tween_finished():
	endSymb.text = "v"
	changeState(State.FINISHED)
	
func changeState(newState):
	currState = newState
	match currState:
		State.READY:
			print("Textbox is READY")
		State.READING:
			print("Textbox is READING")
		State.FINISHED:
			print("Textbox is FINISHED")