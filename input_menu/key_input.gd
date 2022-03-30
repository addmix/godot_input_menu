extends Label

@onready var InputSelector : Window = find_parent("InputSelector")

var event : InputEvent = InputEventKey.new()

func _unhandled_input(input_event : InputEvent) -> void:
	if !InputSelector.visible:
		return
	
	if input_event.get_class() == "InputEventKey":
		event = input_event
		
		text = InputSettings.get_readable_string(input_event)
		get_tree().set_input_as_handled()
