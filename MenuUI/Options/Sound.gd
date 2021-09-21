extends MarginContainer


var sound_settings


func _ready():
	sound_settings = Global.sound.duplicate()
	
	## Set the sliders to the values in the config file
	var sound_settings = Global.sound
	$Menu/Music/MusicVolume.set_value(sound_settings["music"])
	$Menu/Effects/EffectsVolume.set_value(sound_settings["effects"])
	$Menu/Dialog/DialogVolume.set_value(sound_settings["dialog"])
	

func _on_MusicVolume_value_changed(value):
	_change_volumes("music", value)
#	Global.set_bus_volume("Music", value)


func _on_EffectsVolume_value_changed(value):
	_change_volumes("effects", value)
#	Global.set_bus_volume("Effects", value)


func _on_DialogVolume_value_changed(value):
	_change_volumes("diaog", value)
#	Global.set_bus_volume("Dialog", value)


func _change_volumes(key, value):
	sound_settings[key] = value
	save()


func save():
	Global.sound = sound_settings.duplicate()
	Global.set_bus_volumes()
	Global.write_config()
