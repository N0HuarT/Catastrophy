#Control/Movement
extends Node
class_name ControlMovement

#@onready var springArm3D := $"../../CharacterBody3D/SpringArm3D"
#@onready var body :=$"../../CharacterBody3D" #get_parent().get_parent().get_node("CharacterBody3D")

# Intent (set by Input component)
var move_input: Vector2 = Vector2.ZERO

#func _ready() -> void:
	#variables = variables if variables != null else load("res://03_Config/GameMagicNumbers.tres")
	#settings = settings if settings != null else load("res://03_Config/GameSettings.tres")


#func _ready() -> void:
	#assert(body != null, "Movement: body_path not assigned or invalids")
#handles Jump!
#func handle_jump() -> void: if body.is_on_floor(): body.velocity.y = settings.move_jump_force

func physics_update(_delta: float) -> void:
	pass
#	handle body Gravity
	#if not body.is_on_floor(): body.velocity += body.get_gravity() * delta
#	handle Movement
	#var direction: Vector3 = springArm3D.global_transform.basis * Vector3(move_input.x, 0, move_input.y)
	#if direction.length() > 0:
		#direction = direction.normalized()	
	#var acceleration: float = settings.acceleration_ground if body.is_on_floor() else settings.acceleration_air
	#var speed: float = settings.move_speed_walk * move_input.length()	
	#body.velocity.x = move_toward(body.velocity.x, direction.x * speed, acceleration * delta)
	#body.velocity.z = move_toward(body.velocity.z, direction.z * speed, acceleration * delta)
	#body.move_and_slide()
	
	#
#func handle_mouse_yaw(mouse_delta: Vector2) -> void:
	## Horizontal mouse movement (X) rotates character horizontally (Y)
	#body.rotation.y += mouse_delta.x * settings.horizontal_mouse_sensitivity * (1 if settings.is_horizontal_mouse_invert else -1)
#
#func handle_controller_yaw(look_delta: Vector2, delta: float) -> void:
	## Horizontal controller input (X) rotates character horizontally (Y)
	#body.rotation.y += look_delta.x * settings.horizontal_controller_sensitivity * delta * (1 if settings.is_horizontal_controller_invert else -1)
#
#func handle_touch_yaw(touch_delta: Vector2) -> void:  # Renamed from pitch!
	## Horizontal touch movement (X) rotates character horizontally (Y)
	#body.rotation.y += touch_delta.x * settings.horizontal_touch_sensitivity * (1 if settings.is_horizontal_touch_invert else -1)
