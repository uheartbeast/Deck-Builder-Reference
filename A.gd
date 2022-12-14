extends AB

onready var fsm := $FSM

func _init():
	print("A")

func _ready():
	fsm.health -= 1
	print("A Ready")
	print(fsm.health)
