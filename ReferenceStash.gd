extends Node

var playerStats = load("res://PlayerStats.tres").create_instance()
var deck = playerStats.deck
var discard = playerStats.discard

var selected_card : CardState
var card_arc : CardArc
