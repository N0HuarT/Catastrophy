extends Resource
class_name StatCharacter

#region Movement

# ===== MOVEMENT =====
@export_subgroup("Movement")
@export var movement_speed: float = 6.0  
#endregion

#region Base Dmg Stat
# ===== COMBAT CORE =====
@export_subgroup("Combat Core", "base_")
@export_range(0.5, 3.0) var combat_attack_speed: float = 1.0  # Attacks per second
@export_range(0.0, 1.0, 0.01) var base_crit_chance: float = 0.05  # 5% base
@export_range(1.0, 3.0) var base_crit_damage: float = 1.5  # 150% damage
@export_range(0.0, 0.5, 0.01) var base_cooldown_reduction: float = 0.0  # 0% base
#endregion

#region Regeneration (Character's natural recovery)
# ===== REGENERATION =====
@export_subgroup("Regeneration", "regen_")
@export_range(0.0, 10.0) var regen_hp: float = 1.0  # HP/sec
@export_range(0.0, 20.0) var regen_mana: float = 2.0  # Mana/sec
@export_range(0.0, 0.1) var regen_hp_delay: float = 5.0  # Seconds after damage before HP regen starts
#endregion

#region Base Resistances (Innate defenses)
@export_subgroup("Resistances", "resist_") # 0-80% reduction 
@export_range(0.0, 0.8, 0.01) var resist_fire: float = 0.0
@export_range(0.0, 0.8, 0.01) var resist_physical: float = 0.0 #earth
@export_range(0.0, 0.8, 0.01) var resist_lightning: float = 0.0
@export_range(0.0, 0.8, 0.01) var resist_corrosion: float = 0.0
@export_range(0.0, 0.8, 0.01) var resist_wind: float = 0.0
@export_range(0.0, 0.8, 0.01) var resist_ice: float = 0.0
#endregion


func _init() -> void:pass
	#SignalBus.debug_print(SignalBus.Debug.STATS_CHARACTER, "Loaded: StatCharacter")
	
