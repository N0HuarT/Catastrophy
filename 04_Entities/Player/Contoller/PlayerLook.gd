extends Resource
class_name PlayerLook

var character_body_3d: CharacterBody3D
var spring_arm_3d: SpringArm3D

func setup(_character_body_3d:CharacterBody3D, _spring_arm_3d:SpringArm3D)->void:
	character_body_3d = _character_body_3d
	spring_arm_3d = _spring_arm_3d
	
func player_look(_look: Vector2, _delta: float) -> void:
	if _look.length() < SettingsManager.current.input_deadzone:return
	# ----------------------------
	# Horizontal Look (Yaw ←→)
	# ----------------------------
	var _yaw :float= -_look.x * SettingsManager.current.horizontal_mouse_sensitivity
	character_body_3d.rotate_y(_yaw)
	# ----------------------------
	# Vertical Look (Pitch ↑↓)
	# ----------------------------
	var pitch :float= -_look.y * SettingsManager.current.vertical_mouse_sensitivity
	var min_pitch :float= deg_to_rad(SettingsManager.current.vertical_min)
	var max_pitch :float= deg_to_rad(SettingsManager.current.vertical_max)
	spring_arm_3d.rotation.x = clamp(
		spring_arm_3d.rotation.x + pitch,
		min_pitch,
		max_pitch
	)
