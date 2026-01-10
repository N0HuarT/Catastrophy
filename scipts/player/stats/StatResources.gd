# scripts/resources/StatResource.gd
extends Node
class_name StatResources

#region Currency
@export_group("Consumable")
@export_subgroup("Essence")
@export var essence: int = 0
@export_subgroup("Fragment")
@export var fragment_wrath: int = 0
@export var fragment_greed: int = 0
@export var fragment_pride: int = 0
@export var fragment_gluttony: int = 0
@export var fragment_sloth: int = 0
#endregion
