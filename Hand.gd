class_name Hand
extends HBoxContainer

const CardScene = preload("res://Cards/Card.tscn")

signal empty()

func remove_child(node) -> void:
	.remove_child(node)
	if get_child_count() == 0: emit_signal("empty")

func add_card(card_data : CardData) -> void:
	var card = CardScene.instance()
	card.card_data = card_data
	add_child(card)

func is_empty() -> bool:
	return get_child_count() == 0

func discard_all_cards() -> void:
	var cards = get_children()
	for card in cards:
		card.discard()
		yield(get_tree().create_timer(0.2), "timeout")
