@tool
class_name NewAIAssistantButton
extends Button

signal chat_created(chat: AIChat)

const AI_CHAT = preload("res://addons/ai_assistant_hub/ai_chat.tscn")
const NAMES: Array[String] = ["Adjutant" ]

static var available_names: Array[String]

var _plugin:AIHubPlugin
var _data: AIAssistantResource
var _chat: AIChat
var _name: String


func initialize(plugin:AIHubPlugin, assistant_resource: AIAssistantResource) -> void:
	_plugin = plugin
	_data = assistant_resource
	text = _data.type_name
	icon = _data.type_icon
	if text.is_empty() and icon == null:
		text = _data.resource_path.get_file().trim_suffix(".tres")
	
	
func _on_pressed() -> void:
	if available_names == null or available_names.size() == 0:
		available_names = NAMES.duplicate()
	available_names.shuffle()
	_name = available_names.pop_back()
	
	_chat = AI_CHAT.instantiate()
	_chat.initialize(_plugin, _data, _name)
	chat_created.emit(_chat)
