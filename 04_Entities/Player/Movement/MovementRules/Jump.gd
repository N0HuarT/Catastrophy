extends Node
class_name JumpAbility

@onready var body: CharacterBody3D = %CharacterBody3D

#@export var max_hover_time := 0.5
#@export var max_hover_force := 5.0
#@export var hover_accel := 20.0
#@export var max_air_jumps := 1

@export var air_jump_count := 0
var hover_elapsed := 0.0

var is_hovering := false
var has_left_ground := false
var can_hover := false
var current_hover_boost := 0.0


func _physics_process(delta: float) -> void:
	if body.is_on_floor():
		reset_air_state()
	elif is_hovering:
		hover_elapsed += delta

		if hover_elapsed >= GlobalsManager.current.max_hover_time:
			stop_hover()
		else:
			current_hover_boost = min(
				current_hover_boost + GlobalsManager.current.hover_accel * delta,
				GlobalsManager.current.max_hover_force
			)


func reset_air_state() -> void:
	is_hovering = false
	has_left_ground = false
	can_hover = false
	hover_elapsed = 0.0
	current_hover_boost = 0.0
	air_jump_count = 0


func begin_hover() -> void:
	is_hovering = true
	hover_elapsed = 0.0
	current_hover_boost = 0.0


func stop_hover() -> void:
	is_hovering = false
	can_hover = false
	current_hover_boost = 0.0



func can_jump() -> bool:
	if body.is_on_floor():
		return true

	return air_jump_count < GlobalsManager.current.max_air_jumps

func handle_jump_input(mode: String) -> void:
	match mode:
		"PRESSED":
			if body.is_on_floor():
				body.velocity.y = GlobalsManager.current.jump_force
				has_left_ground = true
				can_hover = true
				air_jump_count = 0
			elif air_jump_count == 0:
				air_jump_count += 1
				body.velocity.y = GlobalsManager.current.jump_force * 3
		"HELD":
			if has_left_ground and can_hover and not body.is_on_floor():
				if not is_hovering:
					begin_hover()

				if is_hovering:
					body.velocity.y = GlobalsManager.current.jump_force + current_hover_boost

		"RELEASED":
			stop_hover()
