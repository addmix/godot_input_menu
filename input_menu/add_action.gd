extends HBoxContainer

signal add_action

onready var _LineEdit : LineEdit = $LineEdit
onready var WarningLable : Label = $WarningLabel

func _on_LineEdit_text_changed(new_text : String) -> void:
	#when input already exists
	if InputMap.has_action(new_text):
		var text := "An action with the name '%s' already exists."
		
		WarningLable.text = text % new_text
	else:
		WarningLable.text = ""

func _on_Add_pressed() -> void:
	if _LineEdit.text == "" or InputMap.has_action(_LineEdit.text):
		return
	
	#add action to the inputmap
	InputMap.add_action(_LineEdit.text)
	#tell input editor UI that we added a new action
	emit_signal("add_action", _LineEdit.text)
	#clear line edit
	_LineEdit.text = ""
