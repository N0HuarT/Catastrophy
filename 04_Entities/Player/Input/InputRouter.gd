extends Node
class_name InputRouter

@onready var player: Player = $"../.."
@onready var movement_base: MovementBase


var _mouse_look_delta: Vector2 = Vector2.ZERO
func _ready() -> void:
	movement_base =  $"../Movement" 
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_mouse_look_delta += event.relative
func _process(delta: float) -> void:
	#if player.input_gather.current_input == null: returnd
	var current_input := player.input_gather.current_input
	movement_base.PlayerStateMachine(current_input,delta)
	# Always update the input package look delta
	current_input.look_delta = _mouse_look_delta
	_mouse_look_delta = Vector2.ZERO  # reset after applying

	match GlobalsManager.current.current_InputMode:
		GlobalsManager.current.InputPriority.UI:
			return
		GlobalsManager.current.InputPriority.CUTSCENE:
			current_input.input_direction = Vector2.ZERO
			current_input.actions.clear()
			for action_name:String in current_input.actions.keys():
				if current_input.actions[action_name] == InputPackage.ActionState.PRESSED:
					break
		GlobalsManager.current.InputPriority.GAMEPLAY:
			#pass
			movement_base.PlayerStateMachine(current_input, delta)
		GameGlobals.InputPriority.AI:
			# AI input handled elsewhere
			pass
