extends Node

#enum FRAGMENTS {WRATH,GREED,PRIDE,ENVY,LUST,GLUTTON,SLOTH}
enum CATA {WRATH,GREED,PRIDE,ENVY,LUST,GLUTTON,SLOTH}
#enum RESOURCES {ESSENCE,DATA}
enum InputPriority {
	UI,
	CUTSCENE,
	GAMEPLAY,
	AI
}
@export var current_InputMode: InputPriority = InputPriority.GAMEPLAY
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



const HOLD_THRESHOLD := 0.2


#region Utility Skills
	#region Utility Skill - Slide
var slide_speed := 18.0
var slide_duration := 0.3
var slide_distance :=10.0
var slide_cooldown :=1.5
	#endregion
#endregion

#region RulesStatus
var slow_diminish: float = 0.5
#endregion
#region Utility Skills

var dash_distance := 10.0
var dash_speed := 25.0
var dash_cooldown := 1.0
