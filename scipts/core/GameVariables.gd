extends Resource
class_name GameVariables

#region debug
var debug_control_status := false
var debug_stats_affinnity := false
var debug_control_movement := false
var debug_control_camera := false
var debug_control_input:= false
#var debug_control_status := false

#endregion



#region Utility Skills
	#region Utility Skill - Slide
var slide_speed := 18.0
var slide_duration := 0.3
var slide_distance :=10.0
var slide_cooldown :=1.5


	#endregion
#endregion

#region RulesStatus
var slow_diminish: float = 0.5
#endregion
