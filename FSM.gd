class_name FSM
extends Node

var health = 10

onready var actor : Node = get_parent()
#var state : State

#func change_state(value : Script) -> void:
##	if state is State: state._exit()
##	state = value
##	state._enter(actor)
#	actor.set_script(value)
#	actor._ready()

#func _process(delta):
#	if Input.is_action_just_pressed("ui_down"):
#		health -= 5
#		change_state(load("res://B.gd"))
