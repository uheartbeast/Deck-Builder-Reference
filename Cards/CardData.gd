class_name CardData
extends Resource

enum TargetType {
	SINGLE_TARGET,
	MULTI_TARGET,
}

export(String) var name := ""
export(int) var mana_cost := 1
export(int) var damage := 0
export(int) var hits := 1
export(int) var block := 0
export(TargetType) var target_type
export(Texture) var art
