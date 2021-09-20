extends MarginContainer


func _on_CheckBox_toggled(button_pressed):
	OS.window_fullscreen = !OS.window_fullscreen
