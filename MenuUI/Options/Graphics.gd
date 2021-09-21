extends MarginContainer


func _ready():
	var graphics = Global.graphics.duplicate()
	
	$Menu/MSAA/MSAA.set_value(graphics["msaa"])


func _on_FullScreenToggle_toggled(_button_pressed):
	if OS.get_name() == "HTML5":
		print(OS.window_fullscreen)
		OS.set_window_fullscreen(!OS.window_fullscreen)
	else:
		Global.toggle_full_screen()


func _on_MSAA_value_changed(value):
	Global.set_msaa_value(int(value))
