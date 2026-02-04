extends Resource
class_name JumpAbility

var character_body_3d: CharacterBody3D
var air_jump_count := 0

func setup(_character_body_3d: CharacterBody3D) -> void:
	character_body_3d = _character_body_3d

func can_jump() -> bool:
	if character_body_3d.is_on_floor():
		return true
	return air_jump_count < GlobalsManager.current.max_air_jumps

func handle_jump_input(mode: String) -> void:
	match mode:
		"PRESSED":
			if character_body_3d.is_on_floor():
				character_body_3d.velocity.y = GlobalsManager.current.jump_force
				air_jump_count = 0
			elif air_jump_count == 0:
				air_jump_count += 1
				character_body_3d.velocity.y = GlobalsManager.current.jump_force
		"HELD":
			pass
		"RELEASED":
			character_body_3d.velocity.y *= 0.6
