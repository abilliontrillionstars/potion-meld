extends Control



func _on_button_pressed() -> void:
	Input.action_press("look_right")
	
func _on_look_left_button_pressed() -> void:
	Input.action_press("look_left")
