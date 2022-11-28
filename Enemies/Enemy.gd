extends Node2D

export(Resource) var enemy_stats setget set_enemy_stats

onready var sprite := $Sprite

func set_enemy_stats(value: EnemyStats) -> void:
	enemy_stats = value
	update_enemy()

func _ready() -> void:
	update_enemy()

func update_enemy() -> void:
	if not is_inside_tree(): return
	if not enemy_stats is EnemyStats: return
	sprite.texture = enemy_stats.art
