# Control/Camera.gd 
extends Node
class_name ControlCamera

#@export var settings: GameSettings = preload("res://03_Config/GameSettings.tres")
#@export var variables: GameMagicNumbers = preload("res://03_Config/GameMagicNumbers.tres")
@onready var spring_arm: SpringArm3D = $"../../CharacterBody3D/SpringArm3D"


var mouse_captured: bool = true
func _ready() -> void:
	pass
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(_delta: float) -> void:
	if not spring_arm: return
	#handle_controller_look(look)
	
#func handle_mouse_pitch(mouse_delta: Vector2) -> void:
	#spring_arm.rotation.x += mouse_delta.y * settings.vertical_mouse_sensitivity * (1 if settings.is_vertical_mouse_invert else -1)
	#clamp_pitch()
#
#func handle_controller_pitch(look_delta: Vector2, delta: float) -> void:
	#var controller_look := Input.get_vector("look_left", "look_right", "look_up", "look_down")
	#if controller_look.length() >settings.input_deadzone:
		#handle_controller_pitch(controller_look, delta)
	#spring_arm.rotation.x += look_delta.y * settings.vertical_controller_sensitivity * (1 if settings.is_vertical_controller_invert else -1)
	#clamp_pitch()
#
#func handle_touch_pitch(touch_delta: Vector2) -> void:
	#spring_arm.rotation.x += touch_delta.y * settings.vertical_touch_sensitivity * (1 if settings.is_vertical_touch_invert else -1)
	#clamp_pitch()
#
#func clamp_pitch() -> void:
	#spring_arm.rotation.x = clamp(
		#spring_arm.rotation.x,
		#deg_to_rad(settings.vertical_min),
		#deg_to_rad(settings.vertical_max)
	#)
#
#func toggle_mouse_capture() -> void:
	#mouse_captured = !mouse_captured#toggle Mouse Capture
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if mouse_captured else Input.MOUSE_MODE_VISIBLE
