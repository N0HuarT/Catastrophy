extends Node
class_name UtilityBase

@export var dash: UtilitySkill
@export var teleport: UtilitySkill
@export var slide: UtilitySkill
@export var snare: UtilitySkill

var utilities: Dictionary = {}

func _ready() -> void:
	utilities = {
		"dash": dash,
		"teleport": teleport,
		"slide": slide,
		"snare": snare
	}

#func handle(input: InputPackage, context: PlayerContext) -> void:
##	
	#if context.is_stunned:
		#return
#
	#for action in input.actions:
		#if utilities.has(action):
			#var skill: UtilitySkill = utilities[action]
			#if skill.can_execute(context):
				#skill.execute(input, context)
			#return
