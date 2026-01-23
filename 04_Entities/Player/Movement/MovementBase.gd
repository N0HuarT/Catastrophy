extends Node
class_name MovementBase
@onready var status: RulesStatus = $"../Status"
var status_rules: RulesStatus = RulesStatus.new()
# Tracks the time each action has been held
var action_hold_times: Dictionary[String, float] = {}
var action_hold_fired: Dictionary[String, bool] = {}

#For now a Subclass that holds the Action Intent
#forgot about the priority
var action_intents: Array[ActionIntent] = []

class ActionIntent:
	var name: String
	var mode: String 
	var priority: int
enum ACTION_PRIORITY {
	MOVEMENT = 10,
	ATTACK = 20,
	SPECIAL = 30,
	RELOAD = 40,
	SKILL = 50,
	ITEM = 80,
	JUMP = 90,
	UTILITY = 100,
}
#------------------
#region Helper Func
#------------------

func get_action_priority(action_name: String) -> int:
#Set Return the Action Priority
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
		_:
			return 0
#endregion
func PlayerStateMachine(input: InputPackage, delta:float) -> void:
	# Process each input Types
	if status_rules.is_stunned():
		input.input_direction = Vector2.ZERO
		input.look_delta= Vector2.ZERO
		input.actions.clear()
		return
	if status_rules.can_move():
		PlayerMove(input.input_direction,delta)
	if status_rules.can_look():
		PlayerLook(input.look_delta,delta)
	if status_rules.can_act():
		ResolveActionInput(input.actions, delta)
		ResolveActionIntents()
		
	#SignalBus.debug_print(self, str(input.actions), "Actions")
	#SignalBus.debug_print(self, str(input.input_direction), "Direction")
	#SignalBus.debug_print(self, str(input.look_delta), "Look_Delta")


func PlayerMove(direction: Vector2,delta: float) -> void:
	# TODO: apply movement logic here
	SignalBus.debug_print(self,str(delta) ,str(direction))


func PlayerLook(look: Vector2,delta:float) -> void:
	# TODO: apply camera rotation or look logic
	SignalBus.debug_print(self,str(delta) ,str(look))
#This Solves the Tap/Hold thingy
func ResolveActionInput(actions: Dictionary, delta:float) -> void:
	for intent in action_intents:
		print(intent.name, intent.mode, intent.priority)
	# combat_actions: only valid action names
	var combat_actions: Array[String] = [
		"input_jump",
		"input_attack",
		"input_special",
		"input_utility",
		"input_skill1",
		"input_skill2",
		"input_action",
		"input_item1",
		"input_item2",
		"input_item3",
		"input_item4",
		"input_reload"
	]

	for action_name:String in actions.keys():
		if action_name not in combat_actions:continue
		match actions[action_name]:
			#region Tap
			InputPackage.ActionState.TAP:
				pass
			#endregion
			#region Hold				
			InputPackage.ActionState.HOLD:
				#making sure it is hold\
				if not action_hold_times.has(action_name):
					action_hold_times[action_name] = 0.0
					action_hold_fired[action_name] = false
				#increment
				action_hold_times[action_name] += delta
				
				if action_hold_times[action_name] > GameGlobals.HOLD_THRESHOLD and action_hold_times[action_name] - delta < GameGlobals.HOLD_THRESHOLD:
					#execute_action(action_name, "HOLD")
					action_hold_fired[action_name] = true
			

			#endregion
			#region Release
			InputPackage.ActionState.RELEASE:
				var held_time :float= action_hold_times.get(action_name, 0.0)
				var hold_fired: bool = action_hold_fired.get(action_name, false)

				if not hold_fired and held_time <= GameGlobals.HOLD_THRESHOLD:
					var intent := ActionIntent.new()
					intent.name = action_name
					intent.mode = "TAP"
					intent.priority = get_action_priority(action_name)
					action_intents.append(intent)
				else:
					var intent := ActionIntent.new()
					intent.name = action_name
					intent.mode = "HOLD"
					intent.priority = get_action_priority(action_name)
					action_intents.append(intent)
				for intent in action_intents:
					print(intent.name, intent.mode, intent.priority)
			#endregion
		
			
			
			
			
			

			
			
			
			
#func execute_action(action_name: String, mode: String) -> void:
	## TODO: handle the actual action logic here
	#SignalBus.debug_print(self,action_name,mode)
	#match action_name:
		#"input_jump":
			#pass
		#"input_attack":
			#pass
		#"input_special":
			#pass
		#"input_utility":
			#pass
		#"input_skill1":
			#pass
		#"input_skill2":
			#pass
		#"input_action":
			#pass
		#"input_item1":
			#pass
		#"input_it[=3
		#em2":
			#pass
		#"input_item3":
			#pass
		#"input_item4":
			#pass
		#"input_reload":
			#pass
			#
func ResolveActionIntents() -> void:
	if action_intents.is_empty():
		return

	action_intents.sort_custom(func(a, b):
		return a.priority > b.priority
	)
	var chosen_intent := action_intents[0]
	TryExecuteIntent(chosen_intent)

	action_intents.clear()
func TryExecuteIntent(intent: ActionIntent) -> void:
	match intent.name:
		"input_attack":
			pass
		"input_reload":
			pass
		"input_jump":
			pass
		"input_utility":
			pass
