#script/player/StatusRules
extends Resource
class_name RulesStatus


func _init() -> void:
	SignalBus.debug_print(SignalBus.Debug.STATS_RULES, "Loaded: StatRules")
	run_Status_debug()

#region Debug
func run_Status_debug() -> void:
	if not SignalBus: return
	if SignalBus.debug_control_status:
		print(GameGlobals.slow_diminish)
		add_status(RulesStatus.STATUSES.SLOW, 0.5, 3.0)
		print("Added 1 slow:", character_status)
		add_status(RulesStatus.STATUSES.SLOW, 0.3, 3.0)
		print("Added 2nd slow:", character_status)
		add_status(RulesStatus.STATUSES.STUNNED, 1.0, 2.0)
		print("Added stun:", character_status)
		add_status(RulesStatus.STATUSES.STUNNED, 1.0, 5.0)
		print("Refreshed stun:", character_status)
		print("Slow multiplier:", get_slow_multiplier())
#endregion

var character_status: Dictionary = {} # enum -> Array of {value, timer}
enum STATUSES { STUNNED, ROOT, SLOW }

func add_status(status_name: STATUSES, value := 0.5, duration := 3.0) -> void:
	if SignalBus.debug_control_status: print(status_name,value,duration)
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

func _physics_process(delta: float) -> void:
	for status_name: int in character_status.keys():
		var status_name_typed: int = status_name
		var status_list: Array = character_status[status_name_typed]
		for i in range(status_list.size() - 1, -1, -1):
			status_list[i]["timer"] -= delta
			if status_list[i]["timer"] <= 0:
				remove_status((status_name_typed), i)
