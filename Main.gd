extends Node2D

onready var menu : WindowDialog = $InputMenu

func _on_Button_pressed():
	menu.popup_centered()
