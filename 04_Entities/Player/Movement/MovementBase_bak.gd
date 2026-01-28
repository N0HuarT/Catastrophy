#extends Node
##class_name MovementBase
#
#var status: RulesStatusResource 
#@export var stat_character: StatCharacter
#@export var character_body_3d: CharacterBody3D
#@export var jump : JumpScript
#
## Subclass for Action Intents
#var action_intents: Array[ActionIntent] = []
	##action_state[action_name] = {
	##"hold_time": 0.0,
	##"hold_fired": false
## Tracks the time each action has been held
#var action_state := {} 
#
#class ActionIntent:
	#var name: String
	#var mode: String
	#var priority: int
	#func _to_string() -> String:
		#return "%s [%s] (prio=%d)" % [name, mode, priority]
#
#func _ready() -> void:
	#status = RulesStatusResource.new()
	#jump = JumpScript.new()
#
#enum ACTION_PRIORITY {
	#MOVEMENT = 10,
	#ATTACK = 20,
	#SPECIAL = 30,
	#RELOAD = 40,
	#SKILL = 50,
	#ITEM = 80,
	#JUMP = 90,
	#UTILITY = 100,
	#CANCEL = 9999
#}
#
##------------------
##region Helper Func
##------------------
#func get_action_priority(action_name: String) -> int:
	#match action_name:
		#"input_utility":
			#return ACTION_PRIORITY.UTILITY
		#"input_jump":
			#return ACTION_PRIORITY.JUMP
		#"input_reload":
			#return ACTION_PRIORITY.RELOAD
		#"input_special":
			#return ACTION_PRIORITY.SPECIAL
		#"input_attack":
			#return ACTION_PRIORITY.ATTACK
		#"input_skill1", "input_skill2":
			#return ACTION_PRIORITY.SKILL
		#"input_item1", "input_item2", "input_item3", "input_item4":
			#return ACTION_PRIORITY.ITEM
		#"CANCEL":
			#return ACTION_PRIORITY.CANCEL
		#_:
			#return 9999
##endregion
#
#func PlayerStateMachine(input: InputPackage, delta: float) -> void:
	#if status.is_stunned():
		#input.input_direction = Vector2.ZERO
		#input.look_delta = Vector2.ZERO
		#input.actions.clear()
		#return
	#if status.can_move():
		#PlayerMove(input.input_direction, delta)
#
	#if status.can_look():
		#PlayerLook(input.look_delta, delta)
#
	#if status.can_act():
		#ResolveActionInput(input.actions, delta)
		#ResolveActionIntents()
	#ApplyPhysics(delta)
#
#
#
#func ApplyPhysics(delta: float) -> void:
	#
	#if not character_body_3d.is_on_floor():
		#if character_body_3d.velocity.y > 0: # going up
			#character_body_3d.velocity.y -= GlobalsManager.current.gravity * delta
		#else: # falling
			#character_body_3d.velocity.y -= GlobalsManager.current.gravity * GlobalsManager.current.fall_multiplier * delta
	#else:
		#if character_body_3d.velocity.y < 0:
			#character_body_3d.velocity.y = 0
	#character_body_3d.move_and_slide()
#
#
#func PlayerMove(direction: Vector2, delta: float) -> void:
	#var speed := stat_character.movement_speed
	#var accel_ground := stat_character.movement_ground_acceleration
	#var accel_air := stat_character.movement_air_acceleration
	#var decel := stat_character.movement_deceleration
#
	#var desired := Vector3(direction.x, 0, direction.y) * speed
	#var has_input := direction.length() > 0.001
	#var on_floor := character_body_3d.is_on_floor()
#
	#if has_input:
		#var current_accel := accel_ground if on_floor else accel_air
		#character_body_3d.velocity.x = move_toward(
			#character_body_3d.velocity.x,
			#desired.x,
			#current_accel * delta
		#)
		#character_body_3d.velocity.z = move_toward(
			#character_body_3d.velocity.z,
			#desired.z,
			#current_accel * delta
		#)
#
	#elif on_floor:
		## Only decelerate when grounded
		#character_body_3d.velocity.x = move_toward(
			#character_body_3d.velocity.x,
			#0.0,
			#decel * delta
		#)
		#character_body_3d.velocity.z = move_toward(
			#character_body_3d.velocity.z,
			#0.0,
			#decel * delta
		#)
#
#func PlayerLook(_look: Vector2, _delta: float) -> void: pass
## TODO: apply camera rotation or look logic
#
#
#func ResolveActionInput(actions: Dictionary, delta: float) -> void:#pass
#
	#for action_name:String in actions.keys():
		#if action_name not in GlobalsManager.current.COMBAT_ACTIONS:continue		
		#var intent := ActionIntent.new()
#
		#match actions[action_name]:
			#
			##region TAP
			##Tapped Just pressed: initialize the timer
			##i can remove it but meh,.........
			#InputPackage.ActionState.TAP:
				#if not action_state.has(action_name):
					#action_state[action_name] = {
					#"hold_time": 0.0,
					#"hold_fired": false,
					#"mode": "TAP",
					#
				#}
			##note to self:**********
			## TAP itself is not executed yet — we wait to see if it's held
			##endof note to self: LOL
			##endregion TAP
			#
			##region HOLD 
			##Held: increment timer and fire HOLD if threshold passed
			#InputPackage.ActionState.HOLD:
				#if not action_state.has(action_name):continue
				##sanity just making sure! LOL
				#action_state[action_name].hold_time += delta
				#if action_state[action_name].hold_fired == false and action_state[action_name].hold_time >= GlobalsManager.current.HOLD_THRESHOLD:
					#intent.name = action_name
					#intent.mode = "HOLD"
					#intent.priority = get_action_priority(action_name)
					##action_state[action_name].hold_fired = true
					#action_intents.append(intent)
				#
			##endregion HOLD
			#
			##region RELEASE
			## Released: determine if it was a TAP (HOLD not fired)
			#InputPackage.ActionState.RELEASE:
				#if not action_state.has(action_name):continue
				#
				#if action_state[action_name].hold_fired == false and action_state[action_name].hold_time <= GlobalsManager.current.HOLD_THRESHOLD:
					#intent.name = action_name
					#intent.mode = "TAP"
					#intent.priority = get_action_priority(action_name)
					##action_state[action_name].hold_fired = false
					##action_state[action_name].hold_time = 0.0
				#
				#if action_state[action_name].mode == "HOLD":
					#intent.name = action_name
					#intent.mode = "CANCEL"
					#intent.priority = get_action_priority("CANCEL")
					##action_intents.append(intent)
				#action_intents.append(intent)
				#
				## cleanup
				#action_state.erase(action_name)
				##endregion RELEASE
			 #
#
#
#func ResolveActionIntents() -> void:
	#if action_intents.is_empty():return
	## Sort intents by priority descending (highest first)
	#action_intents.sort_custom(func(a:ActionIntent, b:ActionIntent)-> int:
		#return a.priority > b.priority
	#)
	## Pick the top priority action to execute
	#for i in range(action_intents.size()):
		#var chosen_intent := action_intents[i]
		#if ActionVerify(chosen_intent):
			#ActionExecute(chosen_intent)
			#break
			##return
	#action_intents.clear()
#
#
#
#
#func ActionVerify(intent: ActionIntent) -> bool:
	##SignalBus.debug_print(self, intent.to_string(), "Executed -> Action")
	#match intent.name:
		#"input_attack":
			#pass
		#"input_reload":
			#pass
		#"input_jump":
			##action_state.erase(intent.name)
			#return  jump.is_jump_available(character_body_3d)
		#"input_utility":
			#pass
	#return false
	#
#func ActionExecute(intent:ActionIntent) -> void:
	#match intent.name :
		#"input_attack":
			#match intent.mode:
				#"TAP":
					#pass
					##print("Attack TAP")
				#"HOLD":
					#pass
					##print("Attack HOLD")
		#"input_reload":
			#match intent.mode:
				#"TAP":
					#print("reload TAP") 
				#"HOLD":
					#print("reload HOLD")
		#"input_jump":
			#match intent.mode:
				#"TAP":
					#jump.do_jump(character_body_3d)
				#"HOLD":
					#jump.do_jump(character_body_3d)
		#"input_utility":
			#pass
