extends Control

var is_hovered := false

func _on_CardDrop_mouse_entered():
	self.is_hovered = true
	self_modulate.a = 0.0

func _on_CardDrop_mouse_exited():
	self.is_hovered = false
	self_modulate.a = 0.0
