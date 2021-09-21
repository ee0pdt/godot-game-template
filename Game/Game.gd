extends Spatial


func _ready():
	$CanvasLayer/PauseMenu.hide()


func _input(event):
	if event.is_action_pressed("pause"):
		_pause()
	
	if event.is_action_pressed("up"):
		print("up")
	
	if event.is_action_pressed("down"):
		print("down")
	
	if event.is_action_pressed("left"):
		print("left")
	
	if event.is_action_pressed("right"):
		print("right")


func _pause():
	get_tree().paused = true
	$CanvasLayer/PauseMenu.show()
