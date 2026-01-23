extends Resource
class_name StatAffinity

const AFFINITY_MAX_LEVEL := 100.0
const AFFINITY_STEPUP := 1.0
#@export var variables: GameVariables = preload("res://scipts/core/GameVariables.tres")
#@export var settings: GameSettings = preload("res://03_Config/GameSettings.tres")
@export_group("Catalyst Affinity", "aff_")

# ===== BACKING VARIABLES =====
var _aff_wrath := 1.0
var _aff_greed := 1.0
var _aff_pride := 1.0
var _aff_envy := 1.0
var _aff_lust := 1.0
var _aff_gluttony := 1.0
var _aff_sloth := 1.0
# ===== DICTIONARY =====
var affinity_levels := {} # empty dict, will be filled

func _init() -> void:
	_update_dictionary()
	#SignalBus.debug_print(SignalBus.Debug.STATS_AFFINNITY, "Loaded:", "StatAffinity")
	
# ===== EXPORTED PROPERTIES =====
@export_range(1.0, AFFINITY_MAX_LEVEL, AFFINITY_STEPUP)
var aff_wrath: float:
	get: return _aff_wrath
	set(value):
		_aff_wrath = value
		_update_dictionary()
		update_all_stats()

@export_range(1.0, AFFINITY_MAX_LEVEL, AFFINITY_STEPUP)
var aff_greed: float:
	get: return _aff_greed
	set(value):
		_aff_greed = value
		_update_dictionary()
		update_all_stats()

@export_range(1.0, AFFINITY_MAX_LEVEL, AFFINITY_STEPUP)
var aff_pride: float:
	get: return _aff_pride
	set(value):
		_aff_pride = value
		_update_dictionary()
		update_all_stats()

@export_range(1.0, AFFINITY_MAX_LEVEL, AFFINITY_STEPUP)
var aff_envy: float:
	get: return _aff_envy
	set(value):
		_aff_envy = value
		_update_dictionary()
		update_all_stats()

@export_range(1.0, AFFINITY_MAX_LEVEL, AFFINITY_STEPUP)
var aff_lust: float:
	get: return _aff_lust
	set(value):
		_aff_lust = value
		_update_dictionary()
		update_all_stats()

@export_range(1.0, AFFINITY_MAX_LEVEL, AFFINITY_STEPUP)
var aff_gluttony: float:
	get: return _aff_gluttony
	set(value):
		_aff_gluttony = value
		_update_dictionary()
		update_all_stats()

@export_range(1.0, AFFINITY_MAX_LEVEL, AFFINITY_STEPUP)
var aff_sloth: float:
	get: return _aff_sloth
	set(value):
		_aff_sloth = value
		_update_dictionary()
		update_all_stats()

# ===== UPDATE DICTIONARY =====
func _update_dictionary() -> void:
	pass
	#for cata in [CatalystList.Catalyst.WRATH, CatalystList.Catalyst.GREED, CatalystList.Catalyst.PRIDE,
				 #CatalystList.Catalyst.ENVY, CatalystList.Catalyst.LUST, CatalystList.Catalyst.GLUTTONY,
				 #CatalystList.Catalyst.SLOTH]:
		#var var_name := "_aff_" + CatalystList.get_name(cata).to_lower()
		#affinity_levels[cata] = self.get(var_name)

# ===== UTILITY =====
func get_total_affinity() -> float:
	var total := 0.0
	for key : int in affinity_levels:
		total += affinity_levels[key]
	return total

func increase_affinity(cata: int, amount: float = 1.0) -> void:
	var var_name := "aff_" + CatalystList.get_name(cata).to_lower()
	self.set(var_name, self.get(var_name) + amount)

func update_all_stats() -> void:
	pass
