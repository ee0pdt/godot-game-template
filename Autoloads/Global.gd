extends Node


func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().quit() # default behavior


func set_bus_volume(bus, volume):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus), linear2db(volume))


## Simple wrapper around the change scene that prints an error message if something goes wrong
func go_to_scene(scene):
	var error_code = get_tree().change_scene(scene)
	
	if error_code != OK:
		print("ERROR: ", error_code, " whilst trying to load scene: ", scene)


func toggle_full_screen():
	OS.set_window_fullscreen(!OS.window_fullscreen)
