extends AB

onready var fsm := $FSM

# Called when the node enters the scene tree for the first time.
func _init():
	print("B")

func _ready():
	print("B Ready")
	print(fsm)
	print(fsm.health)
