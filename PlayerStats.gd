class_name PlayerStats
extends Stats

func take_damage(damage: int) -> void:
	.take_damage(damage)
	Events.emit_signal("player_hit")
