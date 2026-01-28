# InputGatherer.gd
extends Node
class_name InputGatherer

var _mouse_look_delta: Vector2 = Vector2.ZERO
var  current_input: InputPackage

func _ready() -> void:
	#if current_input == null: 
	current_input = InputPackage.new()
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_mouse_look_delta += event.relative

func _process(delta: float) -> void:
	current_input = gather_input(delta)
	#SignalBus.debug_print(self,"Current Input Package:")
	#region DEBUG
	SignalBus.debug_print(self,str(current_input.actions),"Actions")
	SignalBus.debug_print(self,str(current_input.input_direction),"Direction")
	SignalBus.debug_print(self,str(current_input.look_delta),"Look_Delta")
	#endregion DEBUG
func gather_input(_delta:float) -> InputPackage:
	var new_input := InputPackage.new()
	#*************
	#** Actions **
	#*************
	for action: String in GlobalsManager.current.COMBAT_ACTIONS:
		if Input.is_action_just_pressed(action):
			new_input.actions[action] = InputPackage.ActionState.PRESSED
		elif Input.is_action_pressed(action):
			new_input.actions[action] = InputPackage.ActionState.HELD
		elif Input.is_action_just_released(action):
			new_input.actions[action] = InputPackage.ActionState.RELEASED


	new_input.input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#****************
	#** Mouse Look **
	#****************
	new_input.look_delta = _mouse_look_delta
	_mouse_look_delta = Vector2.ZERO
	
	return new_input
