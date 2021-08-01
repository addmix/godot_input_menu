# Godot Input Menu
A drag-n-drop solution for keybind customization menus.

## Implementation
1. Copy the `input_menu` and `singletons` folders to your project directory
2. Add `res://singletons/input_settings.gd` to your AutoLoad variables as `InputSettings`
3. Instance the `input_menu.tscn` file to your menu
4. Use any of the `Popup.popup()` functions to open the menu
5. Everything else is handled by the menu, enjoy!

## Things to note
For exported games, user settings are saved to the `override.cfg` file located in the executable's folder, this can cause issues when updating `ProjectSettings` values. This solution does not currently provide a way to update `override.cfg` files.
