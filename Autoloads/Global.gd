extends Node

const config_path = "res://config.ini"
var config_file
var keybinds = {}

func _ready():
	_load_config()

func _load_config():
	config_file = ConfigFile.new()
	
	if config_file.load(config_path) == OK:
		for key in config_file.get_section_keys("keybinds"):
			var key_value = config_file.get_value("keybinds", key)
			
			if str(key_value) != "":
				keybinds[key] = key_value
			else:
				keybinds[key] = null
	else:
		print("ERROR: Config file not found")
		get_tree().quit()
	
	set_game_binds()

## Take the keybinds we imported from the config file and apply them
func set_game_binds():
	for key in keybinds.keys():
		var value = keybinds[key]
		
		var action_list = InputMap.get_action_list(key)
		
		if !action_list.empty():
			InputMap.action_erase_event(key, action_list[0])
		
		if value != null:
			var new_key = InputEventKey.new()
			new_key.set_scancode(value)
			InputMap.action_add_event(key, new_key)


func write_config():
	for key in keybinds.keys():
		var key_value = keybinds[key]
		
		if key_value != null:
			config_file.set_value("keybinds", key, key_value)
		else:
			config_file.set_value("keybinds", key, "")
		
	config_file.save(config_path)
	
	
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
