extends WindowDialog

onready var InputTree : Tree = $MarginContainer/VBoxContainer/ActionList/MarginContainer/Tree
onready var InputSelector : WindowDialog = $InputSelector
onready var AddInput : PopupPanel = $AddInput

var edit_type : String = ""
var edit_item : TreeItem

func _unhandled_input(event : InputEvent) -> void:
	if event.is_action("ui_cancel"):
		close_menu()

func close_menu() -> void:
	hide()

func popup_input_selector(item : TreeItem) -> void:
	edit_item = item
	InputSelector.popup_centered()

func return_input(event : InputEvent) -> void:
	var metadata : Dictionary = edit_item.get_metadata(0)
#	print(metadata)
	#is add input
	if metadata.has("action"):
		#action doesn't have event
		if !InputMap.action_has_event(metadata["action"], event):
			InputTree.add_input(metadata["action"], event)
			InputMap.action_add_event(metadata["action"], event)
	#editing input
	else:
		InputTree.change_input(edit_item, event)
		InputMap.action_erase_event(edit_item.get_parent().get_metadata(0)["action"], metadata["input"])
		InputMap.action_add_event(edit_item.get_parent().get_metadata(0)["action"], event)

func add_input(item : TreeItem) -> void:
	edit_item = item
	AddInput.popup(Rect2(get_global_mouse_position(), Vector2(180, 40)))

func edit_input(item : TreeItem) -> void:
	edit_item = item
	edit_type = edit_item.get_metadata(0)["type"]
	print(edit_type)
	InputSelector.popup_centered()

func _on_Key_pressed() -> void:
	AddInput.hide()
	edit_type = "InputEventKey"
	InputSelector.popup_centered()

func _on_JoyAxis_pressed() -> void:
	AddInput.hide()
	edit_type = "InputEventJoypadAxis"
	InputSelector.popup_centered()

func _on_JoyButton_pressed() -> void:
	AddInput.hide()
	edit_type = "InputEventJoypadButton"
	InputSelector.popup_centered()

func _on_MouseButton_pressed() -> void:
	AddInput.hide()
	edit_type = "InputEventMouseButton"
	InputSelector.popup_centered()
