# SettingsManager.gd
extends Node

@export var defaults: GameSettings
var current: GameSettings

func _ready() -> void:
	defaults = load("res://03_Config/GameSettings.tres")
	current = defaults.duplicate(true)
