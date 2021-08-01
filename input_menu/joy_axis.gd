extends HBoxContainer

onready var Devices : OptionButton = $Left/Devices
onready var Buttons : OptionButton = $Right/Buttons

var event : InputEvent

func _ready() -> void:
	Devices.add_item("All Devices", -1)
	for i in range(8):
		Devices.add_item("Device " + str(i), i)
	Devices.selected = 1
	
	for i in range(20):
		if i % 2 == 0:
			Buttons.add_item("Axis " + str(i / 2) + " -")
		else:
			Buttons.add_item("Axis " + str(i / 2) + " +")
		
	
	event = InputEventJoypadMotion.new()
	event.axis = Buttons.selected
	event.device = Devices.selected - 1


func _on_Buttons_item_selected(index : int) -> void:
	event = InputEventJoypadMotion.new()
	event.axis = Buttons.selected
	event.device = Devices.selected - 1

func _on_Devices_item_selected(index : int) -> void:
	event = InputEventJoypadMotion.new()
	event.axis = Buttons.selected
	event.device = Devices.selected - 1
