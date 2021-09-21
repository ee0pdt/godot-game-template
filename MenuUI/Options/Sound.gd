extends MarginContainer


var sound_settings


func _ready():
	sound_settings = Global.sound.duplicate()
	
	## Set the sliders to the values in the config file
	$Menu/Music/MusicVolume.set_value(sound_settings["music"])
	$Menu/Effects/EffectsVolume.set_value(sound_settings["effects"])
	$Menu/Dialog/DialogVolume.set_value(sound_settings["dialog"])


func _on_MusicVolume_value_changed(value):
	_change_bus_volume("music", value)


func _on_EffectsVolume_value_changed(value):
	_change_bus_volume("effects", value)


func _on_DialogVolume_value_changed(value):
	_change_bus_volume("diaog", value)


func _change_bus_volume(key, value):
	sound_settings[key] = value
	save()


func save():
	Global.sound = sound_settings.duplicate()
	Global.set_bus_volumes()
	Global.write_config()
