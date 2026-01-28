# GlobalsManager.gd
extends Node

@export var defaults: GameGlobals
var current: GameGlobals

func _ready() -> void:
	defaults = load("res://03_Config/GameGlobals.tres")
	current = defaults.duplicate(true)
