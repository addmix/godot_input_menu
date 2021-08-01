extends HBoxContainer

onready var InputMenu : WindowDialog = find_parent("InputMenu")

#connect to apply settings func
func _on_Apply_pressed() -> void:
	InputSettings.apply_settings()
	InputMenu.hide()

#connect to revert settings func
func _on_Revert_pressed() -> void:
	InputSettings.revert_settings()

#connect to cancel settings func
func _on_Cancel_pressed() -> void:
	InputSettings.cancel_settings()
	InputMenu.hide()
