class_name PlayerStats
extends Stats

export(Resource) var deck
export(Resource) var discard

var mana = 3 setget set_mana

func set_mana(value: int) -> void:
	mana = value
	emit_signal("stats_changed")

func take_damage(damage: int) -> void:
	.take_damage(damage)
	Events.emit_signal("player_hit")
