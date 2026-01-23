extends Resource
class_name StatCombat

#region Health
@export_group("Health")
@export var Health_Current: float = 100.0
@export var Health_Max: float = 100.0
#endregion

#region Mana
@export_group("Mana")
@export var Mana_Current: float = 100.0
@export var Mana_Max: float = 100.0
#endregion

#region Exp
@export_group("Exp")
@export var level:int=1
@export var Exp_Current: float = 0
@export var Exp_Max: float = 100
#endregion



func _init() -> void:pass
	#SignalBus.debug_print(SignalBus.Debug.STATS_COMBAT, "Loaded: StatCombat")
