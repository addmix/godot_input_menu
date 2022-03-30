extends Tree

#needs to be integrated into currently existing settings system

@onready var InputMenu : Window = find_parent("InputMenu")

var root : TreeItem

var add_texture = preload("res://input_menu/icon_add.svg")
var delete_texture = preload("res://input_menu/icon_remove.svg")
var edit_texture = preload("res://input_menu/icon_edit.svg")

var actions : Dictionary = {}

func _ready() -> void:
	#connect signal for when input is changed to the rebuild func
	pass

func on_popup() -> void:
	rebuild()

func rebuild() -> void:
	#recreate tree
	clear()
	
	root = create_item()
	#set columns to expand
	set_column_expand(0, true)
	set_column_expand(1, false)
	set_column_expand(2, false)
	
	#minimum widths
	set_column_custom_minimum_width(0, 140)
	set_column_custom_minimum_width(1, 80)
	set_column_custom_minimum_width(2, 64)
	
	#disable root folding
	root.set_disable_folding(true)
	#action column
	root.set_text(0, "Action")
	root.set_text_align(0, TreeItem.ALIGN_CENTER)
	#deadzone column
	root.set_text(1, "Deadzone")
	root.set_text_align(1, TreeItem.ALIGN_CENTER)
	
	
	#iterate through ActionEvents
	var _actions : Array = InputMap.get_actions()
	for action in _actions:
		add_action_to_tree(action)

func _on_Tree_button_pressed(item : TreeItem, _column : int, id : int):
	match id:
		#add
		0:
			InputMenu.add_input(item)
		#edit
		1:
			InputMenu.edit_input(item)
		#delete
		2:
			delete_input(item)
		_:
			pass

func add_input(action : String, input : InputEvent) -> void:
	add_input_to_tree(actions[action], input)

func change_input(tree_item : TreeItem, input : InputEvent) -> void:
	set_input_data(tree_item, input)

func delete_input(item : TreeItem) -> void:
	InputMap.action_erase_event(item.get_parent().get_metadata(0)["action"], item.get_metadata(0)["input"])
	item.free()


func add_action_to_tree(action : String = "") -> void:
	#this is the ActionEvent section
	var tree_action : TreeItem = create_item()
	
	actions[action] = tree_action
	
	#save input identifier string in metadata
	tree_action.set_metadata(0, {"action" : action})
	
	#create buttons
	#label
	tree_action.set_text(0, action)
	#add input
	tree_action.add_button(2, add_texture, 0)
#	tree_action.set_cell_mode(2, TreeItem.CELL_MODE_CUSTOM)
	
	#prevent ui_ actions from being deleted
	if action.substr(0, 3) != "ui_":
		#delete action
		tree_action.add_button(2, delete_texture, 0)
	
	#deadzone
	tree_action.set_cell_mode(1, TreeItem.CELL_MODE_RANGE)
	tree_action.set_range_config(1, 0.0, 1.0, .01)
	tree_action.set_editable(1, true)
	tree_action.set_range(1, InputMap.action_get_deadzone(action))
	
	#iterate through Actions of the current ActionEvent
	var inputs : Array = InputMap.get_action_list(action)
	for input in inputs:
		add_input_to_tree(tree_action, input)

func add_input_to_tree(tree_action : TreeItem, input : InputEvent) -> void:
	#this is the Action section
	var tree_input : TreeItem = create_item(tree_action)
	
	set_input_data(tree_input, input)
	
	#edit button
	tree_input.add_button(2, edit_texture, 1)
	#delete button
	tree_input.add_button(2, delete_texture, 2)

func set_input_data(tree_input : TreeItem, input : InputEvent) -> void:
	var string = InputSettings.get_readable_string(input)
	#set input name
	tree_input.set_text(0, string)
	#set input metadata
	tree_input.set_metadata(0, {"type" : input.get_class(), "input" : input})
