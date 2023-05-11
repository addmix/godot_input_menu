extends WindowDialog

onready var InputMenu : WindowDialog = get_parent()
onready var display_text : Label = $MarginContainer/VBoxContainer/KeyInput
onready var vbox : VBoxContainer = $MarginContainer/VBoxContainer

onready var Key = $MarginContainer/VBoxContainer/KeyInput
onready var JoyButton = $MarginContainer/VBoxContainer/JoyButton
onready var JoyAxis = $MarginContainer/VBoxContainer/JoyAxis
onready var MouseButton = $MarginContainer/VBoxContainer/MouseButton

var shown_type

var edit_event : InputEvent

func _ready() -> void:
	call_deferred("deferred")

#remove children, so that there is only the one desired input menu
func deferred() -> void:
	vbox.remove_child(Key)
	vbox.remove_child(JoyButton)
	vbox.remove_child(JoyAxis)
	vbox.remove_child(MouseButton)

func _on_Ok_pressed() -> void:
	InputMenu.return_input(shown_type.event)
	hide()

func _on_Cancel_pressed() -> void:
	hide()

func _on_EditInputPopup_about_to_show() -> void:
	#select proper UI for given input type
	match InputMenu.edit_type:
		"InputEventKey":
			vbox.add_child(Key)
			shown_type = Key
			vbox.move_child(shown_type, 0)
		"InputEventJoypadButton":
			vbox.add_child(JoyButton)
			shown_type = JoyButton
			vbox.move_child(shown_type, 0)
		"InputEventJoypadAxis":
			vbox.add_child(JoyAxis)
			shown_type = JoyAxis
			vbox.move_child(shown_type, 0)
		"InputEventMouseButton":
			vbox.add_child(MouseButton)
			shown_type = MouseButton
			vbox.move_child(shown_type, 0)
		_:
			print(3)

func _on_EditInputPopup_popup_hide() -> void:
	vbox.remove_child(shown_type)
	shown_type = null
	display_text.text = "Press a key..."
	edit_event = null
