extends CardState

func enter_state() -> void:
	$"%CardSprite".rect_position.y = 0
	$"%CardSprite".set("custom_styles/panel", CARD_STYLE)
	Events.emit_signal("request_hide_card_info")
	set_physics_process(true)

func _physics_process(delta):
	if is_mouse_over_self():
		set_state(HOVER_STATE)
