# InputGatherer.gd
extends Node
class_name InputGatherer

var _mouse_look_delta: Vector2 = Vector2.ZERO
var current_input: InputPackage


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		_mouse_look_delta += event.relative

func _process(delta: float) -> void:
	current_input = gather_input(delta)
	SignalBus.debug_print(
	SignalBus.Debug.INPUT_GATHER,
	"Current Input Package:\n" +
	"  Actions: " + str(current_input.actions) + "\n" +
	"  Direction: " + str(current_input.input_direction) + "\n" +
	"  Look Delta: " + str(current_input.look_delta))

	
func gather_input(_delta:float) -> InputPackage:
	var actions := [
		"input_jump",
		"input_attack",
		"input_special",
		"input_utility",
		"input_skill1",
		"input_skill2",
		"input_item1",
		"input_item2",
		"input_item3",
		"input_item4",
        "input_reload"
	]

	var new_input := InputPackage.new()	
	for action: String in actions:
		if Input.is_action_just_pressed(action):
			new_input.actions[action] = InputPackage.ActionState.TAP
		elif Input.is_action_pressed(action):
			new_input.actions[action] = InputPackage.ActionState.HOLD
		elif Input.is_action_just_released(action):
			new_input.actions[action] = InputPackage.ActionState.RELEASE


	new_input.input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	## Mouse look
	new_input.look_delta = _mouse_look_delta
	_mouse_look_delta = Vector2.ZERO
	return new_input
