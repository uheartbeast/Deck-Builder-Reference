class_name CardInfo
extends ColorRect

var is_visible := false

onready var info_label := $"%InfoLabel"
onready var timer := $Timer

func _ready() -> void:
	modulate.a = 0.0
	Events.connect("request_show_card_info", self, "show_card_info")
	Events.connect("request_hide_card_info", self, "hide_card_info")

func show_card_info(info : String) -> void:
	self.is_visible = true
	info_label.bbcode_text = info
	var tween := create_tween()
	tween.tween_property(self, "modulate", Color.white, 0.25).from_current()

func hide_card_info() -> void:
	self.is_visible = false
	timer.start(0.1)
	yield(timer, "timeout")
	if not is_visible:
		var tween := create_tween()
		tween.tween_property(self, "modulate", Color.transparent, 0.25).from_current()
