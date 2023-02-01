extends CardState

var hand : Hand
var offset : Vector2

func enter_state() -> void:
	set_physics_process(true)
	set_process_input(true)
	Events.emit_signal("request_disable_other_cards", self)
	offset = rect_size/2.0
	hand = get_parent()
	mouse_filter = MOUSE_FILTER_IGNORE
	reparent(get_tree().current_scene)
	Events.connect("card_dropped", self, "_on_card_dropped")

func exit_state() -> void:
	ReferenceStash.card_arc.points = []
	reparent(hand)
	mouse_filter = MOUSE_FILTER_STOP
	Events.emit_signal("request_enable_other_cards", self)
	Events.disconnect("card_dropped", self, "_on_card_dropped")

func reparent(new_parent : Node) -> void:
	get_parent().remove_child(self)
	new_parent.add_child(self)

func _physics_process(_delta : float) -> void:
	rect_global_position = get_parent().get_local_mouse_position() - offset

func _input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_mouse_right"):
		set_state(BASE_STATE)

func _on_card_dropped() -> void:
	set_physics_process(false)
	Events.emit_signal("request_enable_other_cards", self)
	Events.emit_signal("request_hide_card_info")
	play_card(get_tree().get_nodes_in_group("Enemies"))
