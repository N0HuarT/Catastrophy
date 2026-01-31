extends Node
class_name InputRouter

@onready var player: Player = $"../.."
@onready var character_controller: CharacterController  = $"../CharacterController"

var _mouse_look_delta: Vector2 = Vector2.ZERO


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_mouse_look_delta += event.relative
		
func _process(delta: float) -> void:
	var _current_input := player.input_gather.current_input
	_current_input.look_delta = _mouse_look_delta
	_mouse_look_delta = Vector2.ZERO  # reset after applying

	match GlobalsManager.current.current_InputMode:
		GlobalsManager.current.InputPriority.UI:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		GlobalsManager.current.InputPriority.CUTSCENE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			_current_input.input_direction = Vector2.ZERO
			_current_input.actions.clear()
			for action_name:String in _current_input.actions.keys():
				if _current_input.actions[action_name] == InputPackage.ActionState.PRESSED:
					break
					
		GlobalsManager.current.InputPriority.GAMEPLAY:
			#Input.MOUSE_MODE_VISIBLE 
			character_controller.PlayerStateMachine(_current_input, delta)
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		GameGlobals.InputPriority.AI:
			# AI input handled elsewhere
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
