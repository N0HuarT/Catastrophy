extends Node
class_name InputManager
var input_manager: InputManager
#enum InputEventType { PRESSED, JUST_PRESSED }
@onready var player: Player = $"../.."
@onready var gatherer: InputGatherer = InputGatherer.new()
#region 
#---------------------
#------check_input
#---------------------
#region check_input

var _mouse_look_delta: Vector2 = Vector2.ZERO

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_mouse_look_delta += event.relative

func _process(delta: float) -> void:
	var current_input := player.input_gather.gather_input(delta)
	SignalBus.debug_print(SignalBus.Debug.PLAYER, str(current_input.actions))
	SignalBus.debug_print(SignalBus.Debug.PLAYER, str(current_input.look_delta))
	SignalBus.debug_print(SignalBus.Debug.PLAYER, str(current_input.input_direction))
