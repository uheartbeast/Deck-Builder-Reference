extends Node2D

var playerStats = ReferenceStash.playerStats

onready var enemies = $"%Enemies"
onready var hand = $"%Hand"
onready var end_turn_button = $"%EndTurnButton"
onready var red_flash = $"%RedFlash"
onready var flash_timer = $FlashTimer
onready var camera = $Camera

func _ready():
	VisualServer.set_default_clear_color(Color.black)
	Events.connect("player_hit", self, "_on_player_hit")
	for i in 5:
		var card_data : CardData = playerStats.deck.draw_card()
		if not card_data is CardData: return
		hand.add_card(card_data)

func flash():
	red_flash.color.a = 0.2
	flash_timer.start()
	yield(flash_timer, "timeout")
	red_flash.color.a = 0.0

func _input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()

func _on_player_hit():
	flash()
	Shaker.shake(camera, 2, 0.1)

func _on_EndTurnButton_button_down():
	hand.hide()
	end_turn_button.hide()
	var enemy_list = enemies.get_children()
	for enemy in enemy_list:
		yield(enemy.attack(), "completed")
	hand.show()
	end_turn_button.show()
