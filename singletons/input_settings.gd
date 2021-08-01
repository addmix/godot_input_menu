extends Node

#revert: set to clean values
#cancel/not apply: set to last saved values
#apply: save values to current settings
var user_filepath : String = ""

func _ready() -> void:
	if OS.is_debug_build():
		var string : String = ProjectSettings.globalize_path("res://.")
		user_filepath = string.substr(0, string.length() - 2) + "/override.cfg"
	else:
		user_filepath = OS.get_executable_path().get_base_dir() + "/override.cfg"

#save settings to user's file
func apply_settings() -> void:
	ProjectSettings.save_custom(user_filepath)

func revert_settings() -> void:
	for action in InputMap.get_actions():
		var string : String = "input/" + action
		ProjectSettings.set_setting(string, ProjectSettings.property_get_revert(string))

#revert settings to global defaults
func cancel_settings() -> void:
	InputMap.load_from_globals()
	apply_settings()

func get_readable_string(input : InputEvent) -> String:
	#get readable string
	var string : String
	match input.get_class():
		"InputEventJoypadButton":
			string = "Device %s, Button %s" % [input.device, input.button_index]
		"InputEventMouseButton":
			string = "Device %s, Button %s" % [input.device, input.button_index]
		_:
			string = input.as_text()
	
	return string
