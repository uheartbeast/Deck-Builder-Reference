class_name Card
extends MarginContainer

var card_arc = ReferenceStash.card_arc

export(Resource) var card_data setget set_card_data
export(Resource) var card_style
export(Resource) var card_selected_style

var is_hovered := false setget set_is_hovered
var is_selected := false setget set_is_selected
var is_disabled := false setget set_is_disabled
var info := ""

onready var card_sprite := $"%CardSprite"
onready var card_name := $"%CardName"
onready var card_art := $"%CardArt"
onready var card_description := $"%CardDescription"

func set_card_data(value: Resource) -> void:
	card_data = value
	if not card_data is CardData: return
	if not is_inside_tree(): return
	update_card()

func set_is_hovered(value : bool) -> void:
	is_hovered = value
	if not is_inside_tree(): return
	if is_disabled: return
	if is_hovered:
		card_sprite.rect_position.y = -8
		Events.emit_signal("request_show_card_info", info)
	else:
		card_sprite.rect_position.y = 0
		Events.emit_signal("request_hide_card_info")

func set_is_selected(value : bool) -> void:
	is_selected = value
	if not is_inside_tree(): return
	if is_disabled: return
	if is_selected:
#		var main = get_tree().current_scene
#		get_parent().remove_child(self)
#		main.add_child(self)
		Events.emit_signal("request_disable_all_cards")
		mouse_filter = MOUSE_FILTER_IGNORE
	else:
		Events.emit_signal("request_enable_all_cards")
	update_style()

func set_is_disabled(value : bool) -> void:
	is_disabled = value

func _ready() -> void:
	Events.connect("request_disable_all_cards", self, "set_is_disabled", [true])
	Events.connect("request_enable_all_cards", self, "set_is_disabled", [false])
	update_card()

func _process(delta : float) -> void:
	if not ReferenceStash.card_arc is CardArc: return
	if is_selected:
#		rect_global_position = get_tree().current_scene.get_local_mouse_position()-rect_size/2
		ReferenceStash.card_arc.points = get_points()
	else:
		ReferenceStash.card_arc.points = []

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

func _input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_mouse_right"):
		var hand = get_tree().current_scene.find_node("Hand")
		if hand:
#			get_parent().remove_child(self)
#			hand.add_child(self)
			Events.emit_signal("request_enable_all_cards")
			self.is_selected = false
			ReferenceStash.selected_card = null
			Events.emit_signal("request_hide_card_info")

func update_style() -> void:
	if is_selected:
		card_sprite.set("custom_styles/panel", card_selected_style)
	else:
		card_sprite.set("custom_styles/panel", card_style)

func update_card() -> void:
	card_art.texture = card_data.art
	var description := ""
	description += "[center]"
	description += card_data.name+"\n"
	if card_data.damage > 0:
		description += "Deal " + str(card_data.damage) + " [color=red]damage[/color]"
		if card_data.block > 0:
			description += "\n"
	if card_data.block > 0:
		description += "Gain " + str(card_data.block) + " [color=teal]block[/color]"
	description += "[/center]"
	info = description

func _on_Card_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_mouse_left"):
		if ReferenceStash.selected_card:
			ReferenceStash.selected_card.is_selected = false
		self.is_selected = true
		ReferenceStash.selected_card = self

func _on_Card_mouse_entered():
	self.is_hovered = true

func _on_Card_mouse_exited():
	self.is_hovered = false
