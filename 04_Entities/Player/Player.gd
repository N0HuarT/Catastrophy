extends Node3D
class_name Player

@onready var GameGlobals: GameGlobals
@onready var body := $CharacterBody3D
@onready var input_gather := $Control/InputGather as InputGatherer
@export var combat_stats: StatCombat
@export var affinity_stats: StatAffinity
@export var character_stats: StatCharacter
@export var resources_stats: StatResources
@export var rules_stats: RulesStatus



#func _process(delta: float) -> void:
func _ready() -> void:
	SignalBus.debug_print(self, "Loaded")
func _physics_process(_delta: float) -> void:
	pass
	
