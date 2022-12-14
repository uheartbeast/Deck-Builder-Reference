class_name Deck
extends Resource

export (Array, Resource) var card_stack := []

func is_empty() -> bool:
	return card_stack.empty()
