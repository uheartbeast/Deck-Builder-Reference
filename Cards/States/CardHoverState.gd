extends CardState

func enter_state() -> void:
	$"%CardSprite".rect_position.y = -8  # Raise the card a bit on hover
	$"%CardSprite".set("custom_styles/panel", CARD_HIGHLIGHT_STYLE) #Highlight the card
	connect("gui_input", self, "_on_gui_input")
	Events.emit_signal("request_show_card_info", info) # Show the cards description
	set_physics_process(true)

func exit_state() -> void:
	disconnect("gui_input", self, "_on_gui_input")

func _physics_process(delta):
	if not is_mouse_over_self():
		set_state(BASE_STATE) # If the mouse is no longer hovering, swap back to the base state

#func get_drag_data(position : Vector2) -> Dictionary:
#	set_state(SELECTED_STATE)
#	return {}

func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_mouse_left"):
		set_state(SELECTED_STATE) # If clicked, change to the selected state
		get_tree().set_input_as_handled()
	pass
