extends Node
class_name UtilitySlide

@onready var variables: GameMagicNumbers
@onready var settings: GameSettings
@onready var body := $CharacterBody3D as CharacterBody3D
@onready var status := $Control/Status as RulesStatus

# Runtime
var slide_timer := 0.0
var slide_cooldown_timer := 0.0
var is_on_cooldown := false
var is_sliding := false
var slide_direction := Vector3.ZERO

func try_slide(move_input: Vector3) -> void:
	if is_sliding or is_on_cooldown or status.has_status(status.STATUSES.STUNNED):
		return
	is_sliding = true
	slide_timer = variables.slide_duration
	slide_direction = move_input.normalized() * variables.slide_distance
	if status.has_status(status.STATUSES.SLOW):
		slide_direction *= status.get_slow_multiplier()
	_start_cooldown()
	print("Sliding!", slide_direction)

func _physics_process(delta: float) -> void:
	if is_sliding:
		if status.has_status(status.STATUSES.STUNNED) or status.has_status(status.STATUSES.ROOT):
			body.velocity = Vector3.ZERO
		else:
			body.velocity = slide_direction.normalized() * variables.slide_speed
		slide_timer -= delta
		if slide_timer <= 0:
			is_sliding = false
			body.velocity = Vector3.ZERO
	
	if is_on_cooldown and not is_sliding:
		slide_cooldown_timer -= delta
		if slide_cooldown_timer <= 0.0:
			is_on_cooldown = false

func _start_cooldown() -> void:
	is_on_cooldown = true
	slide_cooldown_timer = variables.slide_cooldown
