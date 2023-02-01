extends Resource
class_name Deck

export(Array, Resource) var cards = []

signal cards_amount_changed(cards_amount)

func empty() -> bool:
	return cards.empty()

func draw_card() -> Resource:
	var card = cards.pop_front()
	emit_signal("cards_amount_changed", cards.size())
	return card

func add_card(card: Resource):
	cards.append(card)
	emit_signal("cards_amount_changed", cards.size())

func shuffle():
	cards.shuffle()

func clear():
	cards = []
	emit_signal("cards_amount_changed", cards.size())

func resource_path_to_name(path):
	var name: String = path
	var end = name.find_last(".")
	name = name.left(end)
	var start = name.find_last("/")
	name = name.right(start+1)
	return name

func print_cards():
	print(to_string())

func to_string():
	var string = resource_path_to_name(resource_path)
	for card in cards:
		string += "\n-"+resource_path_to_name(card.resource_path)
	return string
