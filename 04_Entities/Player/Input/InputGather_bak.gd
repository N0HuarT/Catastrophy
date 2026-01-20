## Control/Input.gd
#extends Node
#class_name ControlInput
#
#@export var variables: GameMagicNumbers = preload("res://scipts/core/GameMagicNumbers.tres")
#@export var settings: GameSettings = preload("res://scipts/core/GameSettings.tres")
#
#@onready var movement_controller: ControlMovement = $"../Movement" as ControlMovement
#@onready var camera_controller: ControlCamera = $"../Camera" as ControlCamera
#@onready var body: PhysicsBody3D = $"../../CharacterBody3D"
#@onready var status := $"../Status" as RulesStatus
		#
#func _ready() -> void:
	##status.add_status(RulesStatus.STATUSES.STUNNED, 9.0, 9.0)
	#assert(movement_controller != null, "Input: Movement controller not found!")
	#assert(camera_controller != null, "Input: Camera controller not found!")
##
##func _input(event: InputEvent) -> void:
	##if event is InputEventMouseMotion and camera_controller.mouse_captured:
	### Mouse pitch control
		##if not status.STATUSES.STUNNED:
			##camera_controller.handle_mouse_pitch(event.relative)
			###movement_controller.handle_mouse_yaw(event.relative)
	##if event is InputEventScreenDrag:
	### Touch pitch control
		##camera_controller.handle_touch_pitch(event.relative)
		###movement_controller.handle_touch_yaw(event.relative)
	### ESC to toggle mouse capture
	##if event is InputEventKey and event.pressed and event.keycode == KEY_ESCAPE:
		##camera_controller.toggle_mouse_capture()
		##
##
##func _process(_delta: float) -> void:
	##if not movement_controller or not camera_controller:
		##return
	### Get combined keyboard + controller movement input
	##var move_input := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	### Apply deadzone
	##if move_input.length() < settings.input_deadzone:
		##move_input = Vector2.ZERO
	### Send to movement controller
	##movement_controller.move_input = move_input
	### Jump input
#
	#
