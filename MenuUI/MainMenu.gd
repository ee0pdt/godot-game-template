extends Node2D


func _ready():
	get_tree().paused = false


func _on_OptionsButton_pressed():
	Global.go_to_scene("res://MenuUI/Options/Options.tscn")


func _on_CreditsButton_pressed():
	Global.go_to_scene("res://MenuUI/Credits/Credits.tscn")


func _on_StartButton_pressed():
	Global.go_to_scene("res://Game/Game.tscn")


## Handle things like confirmation and saving games here
func _on_ExitButton_pressed():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
