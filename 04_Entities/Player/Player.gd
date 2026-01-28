extends Node3D
class_name Player

@onready var GlobalsManager: GlobalsManager
@onready var body := $CharacterBody3D
@export var combat_stats: StatCombat
@export var affinity_stats: StatAffinity
@export var character_stats: StatCharacter
@export var resources_stats: StatResources
@onready  var rules_stats: RulesStatusResource
@onready var input_gather: InputGatherer = $Control/InputGather

#func _process(delta: float) -> void:
func _ready() -> void:
	SignalBus.debug_print(self, "Loaded")
func _physics_process(_delta: float) -> void:
	pass
	
