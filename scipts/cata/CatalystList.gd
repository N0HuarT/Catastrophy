# CatalystList.gd
extends RefCounted
class_name CatalystList

enum Catalyst { WRATH, GREED, PRIDE, ENVY, LUST, GLUTTONY, SLOTH }

static func get_name(type: int) -> String:
	var names := ["Wrath", "Greed", "Pride", "Envy", "Lust", "Gluttony", "Sloth"]
	return names[type]
