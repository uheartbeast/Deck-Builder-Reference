extends VBoxContainer

var playerStats = ReferenceStash.playerStats

onready var mana_label = $"%ManaLabel"
onready var health_label = $"%HealthLabel"
onready var block_label = $"%BlockLabel"

func _ready() -> void:
	playerStats.connect("stats_changed", self, "_on_player_stats_changed")

func _on_player_stats_changed() -> void:
	health_label.text = "HP: "+str(playerStats.health)
	if playerStats.health <= 0: get_tree().quit()
