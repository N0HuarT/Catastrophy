# GameSettings.tres
extends Resource
class_name GameSettings


# ===== MOVEMENT =====
@export_group("Movement", "move_")
@export var move_speed_walk: float = 3.0
@export var move_speed_sprint: float = 5.0 

@export var move_jump_force: float = 7.0 
@export var move_gravity: float = 9.8

@export var acceleration_ground: float = 50.0
@export var acceleration_air: float = 35.0


# ===== CAMERA =====
@export_group("Camera")

# Vertical look (pitch - up/down)
@export_subgroup("Vertical Look (Pitch ↑↓)")
@export var vertical_mouse_sensitivity: float = 0.002
@export var vertical_controller_sensitivity: float = 1.5
@export var vertical_touch_sensitivity: float = 0.01
@export var is_vertical_mouse_invert: bool = false
@export var is_vertical_controller_invert: bool = false
@export var is_vertical_touch_invert: bool = false
@export_range(0, 90, 5)  var vertical_max: float = 45.0#aiming to sky
@export_range(-90, 0, 5) var vertical_min: float = -75.0#aiming to feet LOL

# Horizontal look (yaw - left/right)
@export_subgroup("Horizontal Look (Yaw  ←→)")
@export var horizontal_mouse_sensitivity: float = 0.002
@export var horizontal_controller_sensitivity: float = 1.5
@export var horizontal_touch_sensitivity: float = 0.01
@export var is_horizontal_mouse_invert: bool = false
@export var is_horizontal_controller_invert: bool = false
@export var is_horizontal_touch_invert: bool = false

# ===== INPUT =====
@export_group("Input", "input_")
@export var input_deadzone: float = 0.15
#@export var input_touch_deadzone: float = 0.2
@export var input_touch_sensitivity: float = 0.01
@export var input_joystick_size: float = 100.0
@export var input_double_tap_time: float = 0.3
#@export var deadzone: float = 0.15
@export var vertical_controller_deadzone: float = 0.15
@export var horizontal_controller_deadzone: float = 0.15
