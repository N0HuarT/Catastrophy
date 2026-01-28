extends Resource
class_name GameGlobals
#enum FRAGMENTS {WRATH,GREED,PRIDE,ENVY,LUST,GLUTTON,SLOTH}
enum CATA {WRATH,GREED,PRIDE,ENVY,LUST,GLUTTON,SLOTH}
#enum RESOURCES {ESSENCE,DATA}
enum InputPriority {
	UI,
	CUTSCENE,
	GAMEPLAY,
	AI
}

const COMBAT_ACTIONS := [
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
	"input_reload",
    "input_action"
]
const HOLD_THRESHOLD := 0.1 #how long before a Hold Execute
var gravity := 15.0 #gravity
var jump_height := 4 #meters
var fall_multiplier:=1.5#increase fall speed
var jump_force :float

#@export_group("Movement", "move_")
#@export var move_speed_walk := 3.0
#@export var move_speed_sprint := 5.0
#@export var move_acceleration_ground := 50.0
#@export var move_acceleration_air := 35.0


#region Resources
@export var current_InputMode: InputPriority = InputPriority.GAMEPLAY #temporary
@export_group("Resources")
@export_subgroup("Currency")
@export var soul_essence: int = 0
@export var research_data: int = 0
@export_subgroup("Fragment")
@export var fragment_wrath: int = 0
@export var fragment_greed: int = 0
@export var fragment_pride: int = 0
@export var fragment_envy: int = 0
@export var fragment_lust: int = 0
@export var fragment_gluttony: int = 0
@export var fragment_sloth: int = 0
#region

#region Utility Skills
	#region Slide
var slide_speed := 18.0
var slide_duration := 0.3
var slide_distance :=10.0
var slide_cooldown :=1.5
	#endregion
	#region Dash
var slow_diminish: float = 0.5
@export var dash_speed := 25.0
@export var dash_duration := 0.3
@export var dash_distance := 10.0
@export var dash_cooldown := 1.0
	#endregion Dash
#endregion
#endregion Utility 

func _init() -> void:
	setup_jump(jump_height)
func setup_jump(height: float) -> void:
	jump_force = sqrt(2 * gravity * height)
