# GameSettings.gd
extends Resource
class_name GameSettings
# ===== CAMERA =====
@export_group("Camera")

@export_subgroup("Vertical Look (Pitch ↑↓)")
@export var vertical_mouse_sensitivity := 0.002
@export_range(-90, 0, 5) var vertical_min := -75.0
@export_range(0, 90, 5) var vertical_max := 45.0

@export_subgroup("Horizontal Look (Yaw ←→)")
@export var horizontal_mouse_sensitivity := 0.002


# ===== INPUT =====
@export_group("Input", "input_")
@export var input_deadzone := 0.15
