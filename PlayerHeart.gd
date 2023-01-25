extends Node2D

var playerStats = ReferenceStash.playerStats

onready var health_label = $"%HealthLabel"

func _ready():
	playerStats.connect("stats_changed", self, "_on_player_stats_changed")

func _on_player_stats_changed():
	health_label.text = str(playerStats.health)
