extends HBoxContainer


onready var Devices : OptionButton = $Left/Devices
onready var Buttons : OptionButton = $Right/Buttons

var event : InputEvent

func _ready() -> void:
	Devices.add_item("All Devices", -1)
	for i in range(8):
		Devices.add_item("Device " + str(i), i)
	Devices.selected = 1
	
	for i in range(9):
		Buttons.add_item(str(i + 1))
		
	
	event = InputEventMouseButton.new()
	event.button_index = Buttons.selected + 1
	event.device = Devices.selected - 1


func _on_Buttons_item_selected(index : int) -> void:
	event = InputEventMouseButton.new()
	event.button_index = Buttons.selected + 1
	event.device = Devices.selected - 1

func _on_Devices_item_selected(index : int) -> void:
	event = InputEventMouseButton.new()
	event.button_index = Buttons.selected + 1
	event.device = Devices.selected - 1
