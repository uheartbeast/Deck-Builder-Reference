class_name Stats
extends Resource

export(int) var max_health := 1

var health := 1 setget set_health
var block := 0 setget set_block

signal stats_changed()

func set_health(value : int) -> void:
	health = clamp(value, 0, max_health)
	emit_signal("stats_changed")

func set_block(value : int) -> void:
	block = max(value, 0)
	emit_signal("stats_changed")

func take_damage(damage : int) -> void:
	if damage <= 0: return
	var previous_damage = damage
	damage -= block
	self.block -= previous_damage
	self.health -= damage

func heal(amount : int) -> void:
	self.health += amount

func create_instance() -> Resource:
	var instance = self.duplicate()
	instance.health = max_health
	return instance
