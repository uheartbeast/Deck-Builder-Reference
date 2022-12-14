class_name CardState
extends MarginContainer

const CARD_STYLE := preload("res://Cards/CardStylebox.tres")
const CARD_HIGHLIGHT_STYLE := preload("res://Cards/CardSelectedStylebox.tres")

const BASE_STATE = "res://Cards/States/CardBaseState.gd"
const HOVER_STATE = "res://Cards/States/CardHoverState.gd"
const SELECTED_STATE = "res://Cards/States/CardSelectedState.gd"
const DISABLED_STATE = "res://Cards/States/CardDisabledState.gd"

export(Resource) var card_data setget set_card_data

var info := ""

onready var card_sprite := $"%CardSprite"
onready var card_art := $"%CardArt"

func set_card_data(value: Resource) -> void:
	card_data = value
	if not card_data is CardData: return
	if not is_inside_tree(): return
	update_card()

func _ready() -> void:
	Events.connect("request_disable_other_cards", self, "_on_request_disable_other_cards")
	update_card()
	set_state(BASE_STATE)

func is_mouse_over_self() -> bool:
	var total_rect := get_global_rect().merge($"%CardArt".get_global_rect())
	return total_rect.has_point(get_global_mouse_position())

func enter_state() -> void:
	pass

func exit_state() -> void:
	pass

func set_state(script_path: String) -> void:
	var data = card_data
	exit_state()
	set_script(load(script_path))
	self.card_data = data
	enter_state()

func update_card() -> void:
	$"%CardArt".texture = card_data.art
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

func _on_request_disable_other_cards(exception : CardState) -> void:
	if exception == self: return
	set_state(DISABLED_STATE)
