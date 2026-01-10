extends Node3D
class_name Player

@onready var body := $CharacterBody3D
@onready var control_movement := $Control/Movement
@onready var control_camera := $Control/Camera
@onready var control_input := $Control/Input
func _physics_process(delta: float) -> void:
	control_movement.physics_update(delta)
	body.move_and_slide()
