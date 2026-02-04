extends Node
class_name CharacterController

var player_look : PlayerLook = PlayerLook.new()
var status : RulesStatusResource = RulesStatusResource.new()
var player_movement: PlayerMovement = PlayerMovement.new()
var jump_script: JumpAbility = JumpAbility.new()

@onready var character_body_3d: CharacterBody3D = %CharacterBody3D
@onready var spring_arm_3d: SpringArm3D = %SpringArm3D

@export var stat_character: StatCharacter
var action_intents: Array[ActionIntent] = [] 

class ActionIntent:
	var name: String
	var mode: String
	var priority: int
	func _to_string() -> String: 
		return "%s [%s] (prio=%d)" % [name, mode, priority]

func _ready() -> void:
	jump_script.setup(character_body_3d)
	player_look.setup(character_body_3d,spring_arm_3d)
	player_movement.setup(character_body_3d)
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


func player_state_machine(input: InputPackage, delta: float) -> void:
	if status.is_stunned():
		input.input_direction = Vector2.ZERO
		input.look_delta = Vector2.ZERO
		input.actions.clear()
		return
	if status.can_move():
		player_movement.player_move(input.input_direction, delta)
	if status.can_look():
		player_look.player_look(input.look_delta, delta)
	if status.can_act():
		resolve_action_input(input.actions, delta)
		resolve_action_intents()
	apply_physics(delta)
	
func apply_physics(delta: float) -> void:
	if not character_body_3d.is_on_floor():
		if character_body_3d.velocity.y > 0: # going up
			character_body_3d.velocity.y -= GlobalsManager.current.gravity * delta
		else: # falling
			character_body_3d.velocity.y -= GlobalsManager.current.gravity * GlobalsManager.current.fall_multiplier * delta
	else:
		if character_body_3d.velocity.y < 0:
			character_body_3d.velocity.y = 0
	character_body_3d.move_and_slide()



func resolve_action_input(actions: Dictionary, _delta: float) -> void:#pass

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
			
func resolve_action_intents() -> void:
	if action_intents.is_empty():return
	# Sort intents by priority descending (highest first)
	action_intents.sort_custom(func(a:ActionIntent, b:ActionIntent)-> int:
		return a.priority > b.priority
	)
	# Pick the top priority action to execute
	for i in range(action_intents.size()):
		var _chosen_intent := action_intents[i]
		if action_verify(_chosen_intent):
			action_execute(_chosen_intent)
			break
			#return
	action_intents.clear()
	
func action_verify(intent: ActionIntent) -> bool:
	match intent.name:
		"input_attack":
			pass
		"input_reload":
			pass
		"input_jump":
			return  jump_script.can_jump()
		"input_utility":
			pass
	return false
	
func action_execute(intent:ActionIntent) -> void:
	match intent.name :
		"input_attack":
			pass
		"input_reload":
			pass
		"input_jump":
			jump_script.handle_jump_input(intent.mode)
		"input_utility":
			pass
