extends Node
class_name UtilitySlide


@onready var variables: GameVariables
@onready var settings: GameSettings
@onready var body := $CharacterBody3D as CharacterBody3D
@onready var status := $Control/Status as RulesStatus

# Runtime
var slide_timer := 0.0
var slide_cooldown_timer:=0.0

var is_on_cooldown := false
var is_sliding := false
var slide_direction := Vector3.ZERO

func try_slide(move_input: Vector3) -> void:
	print("try_slide")
	if variables.is_sliding or variables.is_on_cooldown or status.has_status(status.STATUSES.STUNNED): return
	else:
		variables.is_sliding= true
		variables.slide_timer = variables.slide_duration
		variables.slide_direction = move_input.normalized() * variables.slide_distance
		if status.has_status(status.STATUSES.SLOW):
				variables.slide_direction *= status.get_slow_multiplier()
		_start_cooldown()

func _physics_process(delta:float)->void:
	if variables.is_sliding:
#	This Stops the player to move when stunned/Root:
		if status.has_status(status.STATUSES.STUNNED) or status.has_status(status.STATUSES.ROOT):
			body.velocity = Vector3.ZERO
		else:
			body.velocity = variables.slide_direction.normalized() * variables.slide_speed
#	#slider Timer (animation?)
		variables.slide_timer -= delta
		if variables.slide_timer <= 0:
			is_sliding = false
			body.velocity = Vector3.ZERO
	#cooldown timer
	if is_on_cooldown and not is_sliding:
		variables.slide_cooldown_timer -= delta
		if variables.slide_cooldown_timer <= 0:
			is_on_cooldown = false
func _start_cooldown() -> void:
	is_on_cooldown = true
	variables.slide_cooldown_timer = variables.slide_cooldown


var debug_status := true
func _ready() -> void:
	try_slide(Vector3(1,1,1))
func run_Status_debug() -> void:
	if debug_status:
		pass
		#add_status(RulesStatus.STATUSES.SLOW, 0.5, 3.0)
		#print("Added 1 slow:", character_status)
		#add_status(RulesStatus.STATUSES.SLOW, 0.3, 3.0)
		#print("Added 2nd slow:", character_status)
		#add_status(RulesStatus.STATUSES.STUNNED, 1.0, 2.0)
		#print("Added stun:", character_status)
		#add_status(RulesStatus.STATUSES.STUNNED, 1.0, 5.0)
		#print("Refreshed stun:", character_status)
		#print("Slow multiplier:", get_slow_multiplier())
