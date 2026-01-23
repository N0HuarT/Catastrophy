extends Node
class_name RulesStatus


func _init() -> void:
	#SignalBus.debug_print(SignalBus.Debug.STATS_RULES, "Loaded: StatRules")
	run_Status_debug()

#region Debug
func run_Status_debug() -> void:
	pass
	#add_status(RulesStatus.STATUSES.SLOW, 0.5, 3.0)
	#add_status(RulesStatus.STATUSES.SLOW, 0.3, 3.0)
	#add_status(RulesStatus.STATUSES.STUNNED, 1.0, 2.0)
	#add_status(RulesStatus.STATUSES.STUNNED, 1.0, 5.0)
#endregion

var character_status: Dictionary = {} # enum -> Array of {value, timer}
enum STATUSES { STUNNED, ROOT, SLOW }

func add_status(status_name: STATUSES, value := 0.5, duration := 3.0) -> void:
	#SignalBus.debug_print(self,"test","test")
	if status_name in [STATUSES.STUNNED, STATUSES.ROOT]:
		# Non-stackable CC: only refresh
		character_status[status_name] = [{"value": value, "timer": duration}]
	elif status_name == STATUSES.SLOW:
		if status_name in character_status:
			character_status[status_name].append({"value": value, "timer": duration})
		else:
			character_status[status_name] = [{"value": value, "timer": duration}]

func remove_status(status_name: STATUSES, index: int = 0) -> void:
	if status_name in character_status:
		character_status[status_name].remove_at(index)
		if character_status[status_name].size() == 0:
			character_status.erase(status_name)

func get_slow_multiplier() -> float:
	if STATUSES.SLOW in character_status:
		var stacks: Array = character_status[STATUSES.SLOW]
		var multiplier: float = 1.0
		for i in range(stacks.size()):
			multiplier *= (1.0 - stacks[i]["value"] * GameGlobals.slow_diminish ** i) # diminishing return
		return multiplier
	return 1.0

func tick(delta: float) -> void:
	for status_name: int in character_status.keys():
		var status_name_typed: int = status_name
		var status_list: Array = character_status[status_name_typed]
		for i in range(status_list.size() - 1, -1, -1):
			status_list[i]["timer"] -= delta
			if status_list[i]["timer"] <= 0:
				remove_status((status_name_typed), i)



func is_stunned() -> bool:
	return STATUSES.STUNNED in character_status

func is_rooted() -> bool:
	return STATUSES.ROOT in character_status

func can_move() -> bool:
	return not is_rooted() and not is_stunned()

func can_look() -> bool:
	return not is_stunned()

func can_act() -> bool:
	return not is_stunned()
