extends Node
#region debug
enum Debug {
	PLAYER,
	CONTROL_MOVEMENT,
	CONTROL_CAMERA,
	CONTROL_INPUT,
	CONTROL_STATUS,
	INPUT_GATHER,
	INPUT_MANAGER,
	STATS_AFFINNITY,
	STATS_RESOURCES,
	STATS_CHARACTER,
	STATS_COMBAT,
	STATS_RULES
}

const DEBUG_FLAGS := {
	Debug.PLAYER: true,
	Debug.CONTROL_MOVEMENT: true,
	Debug.CONTROL_CAMERA: true,
	Debug.CONTROL_INPUT: true,
	Debug.CONTROL_STATUS: true,
	Debug.INPUT_GATHER: false,
	Debug.INPUT_MANAGER: true,
	Debug.STATS_AFFINNITY: true,
	Debug.STATS_RESOURCES: true,
	Debug.STATS_CHARACTER: true,
	Debug.STATS_COMBAT: true,
	Debug.STATS_RULES:true
}
#const debug_control_status := false
#endregion
func debug_print(flag: int, message: String) -> void:
	if DEBUG_FLAGS.get(flag, false):
		print(message)
#
#signal day_night_cycle(current_time)
#signal day_changed(new_day)
#signal game_speed_state(new_state)
