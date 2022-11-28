class_name Stats
extends Resource

export(int) var max_health := 1

var health := 1 setget set_health

signal health_changed(health)

func set_health(value: int) -> void:
	health = value
	emit_signal("health_changed", health)

func create_instance() -> Resource:
	var instance = self.duplicate()
	health = max_health
	return instance
