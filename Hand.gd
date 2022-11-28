class_name Hand
extends HBoxContainer

signal empty()

func remove_child(node) -> void:
	.remove_child(node)
	if get_child_count() == 0: emit_signal("empty")

func add_card(card_scene):
	assert(card_scene is PackedScene)
	var card = card_scene.instance()
	add_child(card)
