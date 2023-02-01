class_name CardState
extends MarginContainer

const CARD_STYLE := preload("res://Cards/CardStylebox.tres")
const CARD_HIGHLIGHT_STYLE := preload("res://Cards/CardSelectedStylebox.tres")

const BASE_STATE = "res://Cards/States/CardBaseState.gd"
const HOVER_STATE = "res://Cards/States/CardHoverState.gd"
const SELECTED_STATE = "res://Cards/States/CardSelectedState.gd"
const DISABLED_STATE = "res://Cards/States/CardDisabledState.gd"
const CARRY_STATE = "res://Cards/States/CardCarryState.gd"

var playerStats = ReferenceStash.playerStats

export(Resource) var card_data

var info := ""

onready var card_sprite := $"%CardSprite"
onready var card_art := $"%CardArt"

func _ready() -> void:
	if not Events.is_connected("request_disable_other_cards", self, "_on_request_disable_other_cards"):
		Events.connect("request_disable_other_cards", self, "_on_request_disable_other_cards")
	if not Events.is_connected("request_enable_other_cards", self, "_on_request_enable_other_cards"):
		Events.connect("request_enable_other_cards", self, "_on_request_enable_other_cards")
	update_card()

func play_card(targets : Array) -> void:
	if targets.empty(): return
	for target in targets:
		assert(target is Enemy)
		if card_data.damage > 0: target.take_hit(card_data)
	playerStats.block += card_data.block
	print(playerStats.block)
	queue_free()

func is_mouse_over_self() -> bool:
	var total_rect := get_global_rect().merge(card_art.get_global_rect())
	return total_rect.has_point(get_global_mouse_position())

func enter_state() -> void:
	pass

func exit_state() -> void:
	pass

func set_state(script_path: String) -> void:
	exit_state()
	var properties = store_properties()
	set_script(load(script_path))
	retrieve_properties(properties)
	enter_state()

func store_properties() -> Dictionary:
	var properties = {}
	for property in get_script().get_script_property_list():
		properties[property.name] = get(property.name)
	return properties

func retrieve_properties(properties : Dictionary) -> void:
	for property in properties:
		set(property, properties[property])

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

func _on_request_disable_other_cards(exception : CardState) -> void:
	if exception == self: return
	set_state(DISABLED_STATE)

func _on_request_enable_other_cards(exception : CardState) -> void:
	if exception == self: return
	set_state(BASE_STATE)
