extends Node2D


func _on_OptionsButton_pressed():
	get_tree().change_scene("res://MenuUI/Options/Options.tscn")


## Handle things like confirmation and saving games here
func _on_ExitButton_pressed():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
