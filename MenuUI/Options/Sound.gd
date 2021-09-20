extends MarginContainer


func _on_MusicVolume_value_changed(value):
	Global.set_bus_volume("Music", value)


func _on_EffectsVolume_value_changed(value):
	Global.set_bus_volume("Effects", value)
