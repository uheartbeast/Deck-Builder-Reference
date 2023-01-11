extends Node2D

func _ready():
	VisualServer.set_default_clear_color(Color.black)
#	OS.window_fullscreen = true

func _input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

