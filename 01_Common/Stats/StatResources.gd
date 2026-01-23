# scripts/resources/StatResource.gd
extends Resource
class_name StatResources

#region Currency
@export_group("Consumable")
@export_subgroup("Essence")
@export var essence :int
#endregion


func _init() -> void:pass
	#SignalBus.debug_print(SignalBus.Debug.STATS_RESOURCES, "Loaded: StatResources")
	#GameGlobals.soul_essence = 1
	
	
