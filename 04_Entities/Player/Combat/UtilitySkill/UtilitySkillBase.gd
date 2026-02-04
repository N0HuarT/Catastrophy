extends Node
class_name UtilitySkill

@export var cooldown := 1.0
@export var stamina_cost := 0.0

var cooldown_timer := 0.0

func can_execute(context) -> bool:
	if cooldown_timer > 0:
		return false
	if context.stamina < stamina_cost:
		return false
	return true

func execute(input: InputPackage, context) -> void:
	# override in child
	pass

func update(delta: float):
	if cooldown_timer > 0:
		cooldown_timer -= delta
