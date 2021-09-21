extends Node


const config_path = "res://config.ini"
var config_file


## Defined here as defaults for HTML5 export
var keybinds = {
	"up": 87,
	"down": 83,
	"left": 65,
	"right": 68,
}


## Defined here as defaults for HTML5 export
var sound = {
	"music": 1.0,
	"effects": 1.0,
	"dialog": 1.0,
}

var graphics = {
	"msaa": 0,
}


func _ready():
	## In browser we can't read or write to file system
	## I might look at cookie support instead here
	if OS.get_name() != "HTML5":
		_load_config()


func _load_config():
	config_file = ConfigFile.new()
	
	if config_file.load(config_path) == OK:
		## Key Binding Settings
		for key in config_file.get_section_keys("keybinds"):
			var key_value = config_file.get_value("keybinds", key)
			
			if str(key_value) != "":
				keybinds[key] = key_value
			else:
				keybinds[key] = null
		
		## Sound Settings
		for key in config_file.get_section_keys("sound"):
			var key_value = config_file.get_value("sound", key)
			
			if str(key_value) != "":
				sound[key] = key_value
			else:
				sound[key] = null
		
		## Graphics Settings
		for key in config_file.get_section_keys("graphics"):
			var key_value = config_file.get_value("graphics", key)
			
			if str(key_value) != "":
				graphics[key] = key_value
			else:
				graphics[key] = null
		
		set_game_binds()
		set_bus_volumes()
	else:
		print("ERROR: Config file not found")
		get_tree().quit()


## Take the current keybinds and apply them
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
	
	for key in sound.keys():
		var key_value = sound[key]
		
		if key_value != null:
			config_file.set_value("sound", key, key_value)
		else:
			config_file.set_value("sound", key, "")
	
	for key in graphics.keys():
		var key_value = graphics[key]
		
		if key_value != null:
			config_file.set_value("graphics", key, key_value)
		else:
			config_file.set_value("graphics", key, "")
		
	config_file.save(config_path)


func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().quit() # default behavior


## Take the current bus volumes and apply them
func set_bus_volumes():
	_set_bus_volume("Music", sound["music"])
	_set_bus_volume("Effects", sound["effects"])
	_set_bus_volume("Dialog", sound["dialog"])


func _set_bus_volume(bus, volume):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index(bus), linear2db(volume))


## Simple wrapper around the change scene that prints an error message if something goes wrong
func go_to_scene(scene):
	var error_code = get_tree().change_scene(scene)
	
	if error_code != OK:
		print("ERROR: ", error_code, " whilst trying to load scene: ", scene)


func toggle_full_screen():
	OS.set_window_fullscreen(!OS.window_fullscreen)


func set_msaa_value(value):
	graphics["msaa"] = value
	write_config()
	
	match value:
		0:
			get_viewport().msaa = Viewport.MSAA_DISABLED
		1:
			get_viewport().msaa = Viewport.MSAA_2X
		3:
			get_viewport().msaa = Viewport.MSAA_4X
		4:
			get_viewport().msaa = Viewport.MSAA_8X
		5:
			get_viewport().msaa = Viewport.MSAA_16X
