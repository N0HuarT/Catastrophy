extends Node
class_name CharacterController


var status: RulesStatusResource = RulesStatusResource.new()

@export var stat_character: StatCharacter
@export var spring_arm_3d: SpringArm3D
@export var character_body_3d: CharacterBody3D
#var jump_component: JumpScript
var action_intents: Array[ActionIntent] = [] 

@onready var jump_component: JumpAbility = %JumpComponent


class ActionIntent:
	var name: String
	var mode: String
	var priority: int
	func _to_string() -> String:
		return "%s [%s] (prio=%d)" % [name, mode, priority]

func _ready() -> void:pass
	#jump_component =JumpScript.new()
	#print("jump is null? ", jump_component == null)
	#assert(status != null) 

enum ACTION_PRIORITY {
	MOVEMENT = 10,
	ATTACK = 20,
	SPECIAL = 30,
	RELOAD = 40,
	SKILL = 50,
	ITEM = 80,
	JUMP = 90,
	UTILITY = 100,
	CANCEL = 9999
}

#------------------
#region Helper Func
#------------------
func get_action_priority(action_name: String) -> int:
	match action_name:
		"input_utility":
			return ACTION_PRIORITY.UTILITY
		"input_jump":
			return ACTION_PRIORITY.JUMP
		"input_reload":
			return ACTION_PRIORITY.RELOAD
		"input_special":
			return ACTION_PRIORITY.SPECIAL
		"input_attack":
			return ACTION_PRIORITY.ATTACK
		"input_skill1", "input_skill2":
			return ACTION_PRIORITY.SKILL
		"input_item1", "input_item2", "input_item3", "input_item4":
			return ACTION_PRIORITY.ITEM
		"CANCEL":
			return ACTION_PRIORITY.CANCEL
		_:
			return 9999
#endregion

func PlayerStateMachine(input: InputPackage, delta: float) -> void:
	if status.is_stunned():
		input.input_direction = Vector2.ZERO
		input.look_delta = Vector2.ZERO
		input.actions.clear()
		return
	
	if status.can_move():
		PlayerMove(input.input_direction, delta)

	if status.can_look():
		PlayerLook(input.look_delta, delta)

	if status.can_act():
		ResolveActionInput(input.actions, delta)
		ResolveActionIntents()
	ApplyPhysics(delta)



func ApplyPhysics(delta: float) -> void:
	
	if not character_body_3d.is_on_floor():
		if character_body_3d.velocity.y > 0: # going up
			character_body_3d.velocity.y -= GlobalsManager.current.gravity * delta
		else: # falling
			character_body_3d.velocity.y -= GlobalsManager.current.gravity * GlobalsManager.current.fall_multiplier * delta
	else:
		if character_body_3d.velocity.y < 0:
			character_body_3d.velocity.y = 0
	character_body_3d.move_and_slide()


func PlayerMove(direction: Vector2, delta: float) -> void:
	var speed := stat_character.movement_speed
	var accel_ground := stat_character.movement_ground_acceleration
	var accel_air := stat_character.movement_air_acceleration
	var decel := stat_character.movement_deceleration
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

func PlayerLook(_look: Vector2, _delta: float) -> void:
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



func ResolveActionInput(actions: Dictionary, _delta: float) -> void:#pass

	for action_name:String in actions.keys():
		if action_name not in GlobalsManager.current.COMBAT_ACTIONS:continue		
		var _intent := ActionIntent.new()
		_intent.name = action_name
		_intent.priority  = get_action_priority(action_name) 

		match actions[action_name]:
			InputPackage.ActionState.PRESSED:
				_intent.mode = "PRESSED"
				#pressed took like 2-3 frame to be considered help 
				#i dont know if this a correct approach
				actions[action_name] = InputPackage.ActionState.HELD
			InputPackage.ActionState.HELD:
				_intent.mode = "HELD"
			InputPackage.ActionState.RELEASED:
				_intent.mode = "RELEASED"
				#cleaningcrew, just to free some RAM XD
				actions.erase(action_name)
				
		#-------------------------------		
		action_intents.append(_intent)
			
func ResolveActionIntents() -> void:
	if action_intents.is_empty():return
	# Sort intents by priority descending (highest first)
	action_intents.sort_custom(func(a:ActionIntent, b:ActionIntent)-> int:
		return a.priority > b.priority
	)
	# Pick the top priority action to execute
	for i in range(action_intents.size()):
		var _chosen_intent := action_intents[i]
		if ActionVerify(_chosen_intent):
			ActionExecute(_chosen_intent)
			break
			#return
	action_intents.clear()
	
func ActionVerify(intent: ActionIntent) -> bool:
	#SignalBus.debug_print(self, intent.to_string(), "Executed -> Action")
	match intent.name:
		"input_attack":
			pass
		"input_reload":
			pass
		"input_jump":
			return  jump_component.can_jump()
		"input_utility":
			pass
	return false
	
func ActionExecute(intent:ActionIntent) -> void:
	match intent.name :
		"input_attack":
			pass
		"input_reload":
			pass
		"input_jump": jump_component.handle_jump_input(intent.mode)
		"input_utility":
			pass
