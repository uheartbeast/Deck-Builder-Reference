class_name Enemy
extends Area2D

const WHITE_SPRITE_MATERIAL = preload("res://WhiteSpriteMaterial.tres")

export(Resource) var enemy_stats setget set_enemy_stats

var tasks := AsyncTaskManager.new()

onready var sprite := $Sprite
onready var health_label := $HealthLabel

func set_enemy_stats(value: EnemyStats) -> void:
	enemy_stats = value.create_instance()
	update_enemy()

func _ready() -> void:
	update_enemy()
	enemy_stats.connect("health_changed", self, "_on_health_changed")

func update_enemy() -> void:
	if not is_inside_tree(): return
	if not enemy_stats is EnemyStats: return
	sprite.texture = enemy_stats.art
	update_health()

func update_health() -> void:
	if enemy_stats.health <= 0: health_label.hide()
	health_label.text = str(enemy_stats.health)

func take_hit(card_data : CardData) -> void:
	sprite.material = WHITE_SPRITE_MATERIAL
	enemy_stats.health -= card_data.damage
	yield(Shaker.shake(self, 6), "completed")
	sprite.material = null
	if has_no_health():
		queue_free()

func _on_health_changed(new_health: int) -> void:
	update_health()

func has_no_health() -> bool:
	return enemy_stats.health <= 0

func _on_Enemy_input_event(_viewport, event, _shape_idx):
	if (event.is_action_released("ui_mouse_left")
	or event.is_action_pressed("ui_mouse_left")):
		Events.emit_signal("enemy_selected", self)
