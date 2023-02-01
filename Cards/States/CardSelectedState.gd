extends CardState

func enter_state() -> void:
	set_physics_process(true)
	set_process_input(true)
	Events.emit_signal("request_disable_other_cards", self)
	Events.connect("enemy_selected", self, "_on_enemy_selected")

func exit_state() -> void:
	ReferenceStash.card_arc.points = []
	Events.emit_signal("request_enable_other_cards", self)
	Events.disconnect("enemy_selected", self, "_on_enemy_selected")

func _physics_process(_delta : float) -> void:
	if get_local_mouse_position().y < $"%CardSprite".rect_position.y:
		ReferenceStash.card_arc.points = get_points()
	else:
		ReferenceStash.card_arc.points = []

func _input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_mouse_right"):
		set_state(BASE_STATE)

func _on_enemy_selected(enemy : Enemy) -> void:
	set_physics_process(false)
	ReferenceStash.card_arc.points = []
	Events.emit_signal("request_enable_other_cards", self)
	Events.emit_signal("request_hide_card_info")
	play_card([enemy])

func get_points() -> Array:
	var points := []
	var start := Vector2(rect_size.x/2, card_sprite.rect_position.y)
	var target = get_local_mouse_position()
	var pts = 8.0
	var distance = (target - start)
	for i in range(pts):
		var t = (1.0 / pts) * i
		var x = start.x + (distance.x / pts) * i
		var y = start.y + ease_out_cubic(t) * distance.y
		points.append(Vector2(x, y) + rect_global_position)
	points.append(target + rect_global_position)
	return points

func ease_out_cubic(number : float) -> float:
	return 1.0 - pow(1.0 - number, 3.0)
