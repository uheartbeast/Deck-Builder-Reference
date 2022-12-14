class_name Enemy
extends Area2D

const WHITE_SPRITE_MATERIAL = preload("res://WhiteSpriteMaterial.tres")

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

func take_hit() -> void:
	sprite.material = WHITE_SPRITE_MATERIAL
	yield(Shaker.shake(self, 6), "completed")
	sprite.material = null

func _on_Enemy_input_event(viewport, event, shape_idx):
	if (event.is_action_released("ui_mouse_left")
	or event.is_action_pressed("ui_mouse_left")):
		Events.emit_signal("enemy_selected", self)
