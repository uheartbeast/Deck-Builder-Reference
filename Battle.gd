extends Node2D

var playerStats = ReferenceStash.playerStats
var deck = ReferenceStash.deck
var discard = ReferenceStash.discard

onready var enemies = $"%Enemies"
onready var hand = $"%Hand"
onready var end_turn_button = $"%EndTurnButton"
onready var red_flash = $"%RedFlash"
onready var flash_timer = $FlashTimer
onready var camera = $Camera

func _ready() -> void:
	VisualServer.set_default_clear_color(Color.black)
	Events.connect("player_hit", self, "_on_player_hit")
	for i in 5:
		var card_data : CardData = playerStats.deck.draw_card()
		if not card_data is CardData: return
		hand.add_card(card_data)

func flash() -> void:
	red_flash.color.a = 0.2
	flash_timer.start()
	yield(flash_timer, "timeout")
	red_flash.color.a = 0.0

func draw_cards(amount) -> void:
	fill_deck_from_discard()
	while not deck.empty() and amount > 0:
		hand.add_card(deck.draw_card())
		amount -= 1
		fill_deck_from_discard()

func fill_deck_from_discard() -> void:
	if deck.empty():
		discard.shuffle()
		while not discard.empty():
			deck.add_card(discard.draw_card())

func _input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_player_hit():
	flash()
	Shaker.shake(camera, 2, 0.1)

func _on_EndTurnButton_button_down() -> void:
	Events.emit_signal("request_disable_other_cards", null)
	end_turn_button.disabled = true
	if not hand.is_empty():
		yield(hand.discard_all_cards(), "completed")
	var enemy_list = enemies.get_children()
	for enemy in enemy_list:
		yield(enemy.attack(), "completed")
	end_turn_button.disabled = false
	draw_cards(2)
