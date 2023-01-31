extends Control

var is_hovered := false

func _on_CardDrop_mouse_entered() -> void:
	self.is_hovered = true
	self_modulate.a = 0.0

func _on_CardDrop_mouse_exited() -> void:
	self.is_hovered = false
	self_modulate.a = 0.0

func _input(event : InputEvent) -> void:
	if not is_hovered: return
	if (event.is_action_released("ui_mouse_left")
	or event.is_action_pressed("ui_mouse_left")):
		Events.emit_signal("card_dropped")
