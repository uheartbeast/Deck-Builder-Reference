extends VBoxContainer

var playerStats = ReferenceStash.playerStats

onready var mana_label = $"%ManaLabel"
onready var health_label = $"%HealthLabel"
onready var block_label = $"%BlockLabel"

func _ready() -> void:
	playerStats.connect("stats_changed", self, "_on_player_stats_changed")
	update_stats()

func update_stats() -> void:
	health_label.text = "HP: "+str(playerStats.health)
	block_label.text = "Block: "+str(playerStats.block)
	mana_label.text = "Mana: "+str(playerStats.mana)

func _on_player_stats_changed() -> void:
	update_stats()
	if playerStats.health <= 0: get_tree().quit() # TODO: MOVE THIS
