class_name Card
extends MarginContainer

export(Resource) var card_data setget set_card_data
export(Resource) var card_style
export(Resource) var card_selected_style

var is_hovered := false setget set_is_hovered
var is_selected := false setget set_is_selected
var is_disabled := false
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
	if is_hovered:
		card_sprite.rect_position.y = -8
		Events.emit_signal("request_show_card_info", info)
	else:
		card_sprite.rect_position.y = 0
		Events.emit_signal("request_hide_card_info")

func set_is_selected(value : bool) -> void:
	is_selected = value
	update_style()

func _ready() -> void:
	update_card()

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
