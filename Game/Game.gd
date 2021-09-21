extends Spatial


enum States {
	PLAYING,
	PAUSED,
	GAME_OVER,
}


var _state = States.PAUSED
var _previous_state = null


func _ready():
	$CanvasLayer/PauseMenu.hide()
	get_tree().paused = false
	_state = States.PLAYING


func _input(event):
	## Respond to key presses if not paused
	if _state != States.PAUSED:
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
	## Two ways to handle things here. If you want some animations to continue
	## when paused, then use the _state to turn off player movement, etc.
	## If you want everything to freeze then use the get_tree().paused pattern
	_previous_state = _state
	_state = States.PAUSED
	get_tree().paused = true
	$CanvasLayer/PauseMenu.show()


func _on_PauseMenu_unpause():
	get_tree().paused = false
	
	## If we have a previous state then we jump back in
	## (we can't assume "PLAYING" as we might have paused from a Gameover screen)
	if _previous_state != null:
		_state = _previous_state
	else:
		_state = States.PLAYING
	_previous_state = States.PAUSED
