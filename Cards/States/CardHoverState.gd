extends CardState

func enter_state() -> void:
	card_sprite.rect_position.y = -8 
	card_sprite.set("custom_styles/panel", CARD_HIGHLIGHT_STYLE)
	connect("gui_input", self, "_on_gui_input")
	Events.emit_signal("request_show_card_info", info)
	set_physics_process(true)

func exit_state() -> void:
	disconnect("gui_input", self, "_on_gui_input")

func _physics_process(_delta):
	if not is_mouse_over_self():
		set_state(BASE_STATE)

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_mouse_left"):
		set_state(SELECTED_STATE)
		force_drag({}, null) # This allows the enemy to capture the mouse input while dragging
