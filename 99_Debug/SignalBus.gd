extends Node

# Map script file name to whether debugging is enabled
var DEBUG_MAP: Dictionary[String, bool] = {
	"Player.gd": false,
	"InputGatherer.gd": false,
	"InputRouter.gd": false,
	"MovementBase.gd":true,
	"RulesStatus.gd": false,
	"SignalBus.gd":true,
}
func get_script_name(sender: Object) -> String:
	if sender == null:
		return "<Unknown>"
	if not sender.has_method("get_script"):
		return "<Unknown>"
	var scr : Script= sender.get_script()
	if scr == null:
		return "<Unknown>"
	if scr.resource_path == "":
		return "<Unknown>"
	# Get only the file name, not the full path
	return scr.resource_path.get_file()

func debug_print(sender: Object, message: String, label: String = "") -> void:
	var script_name :String= get_script_name(sender)
	if not DEBUG_MAP.get(script_name):return
	if label == "":
		print("[%s] %s" % [script_name, message])
	else:
		print("[%s] %s:%s" % [script_name, label, message])
		
		
		#usage 
		#SignalBus.debug_print(self,"message","label")
