extends Resource
class_name PlayerMovement

var status_character :StatCharacter = StatCharacter.new()

var character_body_3d: CharacterBody3D

func setup(_character_body_3d:CharacterBody3D)->void:
	character_body_3d = _character_body_3d
	
func player_move(direction: Vector2, delta: float) -> void:
	if character_body_3d == null:return
	var speed := status_character.movement_speed
	var accel_ground := GlobalsManager.current.movement_ground_acceleration
	var accel_air := GlobalsManager.current.movement_air_acceleration
	var decel := GlobalsManager.current.movement_deceleration
	var on_floor := character_body_3d.is_on_floor()

	# Apply deadzone
	if direction.length() < SettingsManager.current.input_deadzone:
		direction = Vector2.ZERO

	if direction != Vector2.ZERO:
		# Character local axes
		var _move_dir := (character_body_3d.transform.basis.z * direction.y +
						 character_body_3d.transform.basis.x * direction.x).normalized()
		var _desired_velocity := _move_dir * speed
		var _accel := accel_ground if on_floor else accel_air
		character_body_3d.velocity.x = move_toward(character_body_3d.velocity.x, _desired_velocity.x, _accel * delta)
		character_body_3d.velocity.z = move_toward(character_body_3d.velocity.z, _desired_velocity.z, _accel * delta)
	elif on_floor:
		# Decelerate when grounded and no input
		character_body_3d.velocity.x = move_toward(character_body_3d.velocity.x, 0.0, decel * delta)
		character_body_3d.velocity.z = move_toward(character_body_3d.velocity.z, 0.0, decel * delta)
