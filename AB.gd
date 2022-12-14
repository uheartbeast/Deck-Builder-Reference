class_name AB
extends Node2D

onready var health = 10

func change_state(value : Script) -> void:
#	if state is State: state._exit()
#	state = value
#	state._enter(actor)
	set_script(value)
	_ready()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		change_state(load("B.gd"))
	if Input.is_action_just_pressed("ui_cancel"):
		change_state(load("A.gd"))
