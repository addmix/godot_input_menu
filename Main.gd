extends Node2D

@onready var menu : Window = $InputMenu

func _on_Button_pressed():
	menu.popup_centered(Vector2i(300, 300))
