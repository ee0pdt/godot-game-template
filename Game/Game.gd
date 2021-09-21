extends Spatial


func _ready():
	$CanvasLayer/PauseMenu.hide()


func _input(event):
	if event.is_action_pressed("pause"):
		_pause()


func _pause():
	get_tree().paused = true
	$CanvasLayer/PauseMenu.show()
