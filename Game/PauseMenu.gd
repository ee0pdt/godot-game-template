extends Panel


signal unpause


func _on_MainMenuButton_pressed():
	Global.go_to_scene("MenuUI/MainMenu.tscn")


func _on_ContinueButton_pressed():
	self.hide()
	get_tree().paused = false
	emit_signal("unpause")
