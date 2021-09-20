extends Panel


enum States {SOUND, GRAPHICS, CONTROLS}

var state = States.SOUND

onready var control_panel = $MarginContainer/HBoxContainer/Panel
onready var menu = $MarginContainer/HBoxContainer/Menu

func _ready():
	_render()
	
func _render():
	control_panel.get_node("Sound").hide()
	control_panel.get_node("Graphics").hide()
	control_panel.get_node("Controls").hide()
	
	menu.get_node("SoundButton").set_disabled(false)
	menu.get_node("GraphicsButton").set_disabled(false)
	menu.get_node("ControlsButton").set_disabled(false)
	
	match state:
		States.SOUND:
			control_panel.get_node("Sound").show()
			menu.get_node("SoundButton").set_disabled(true)
		States.GRAPHICS:
			control_panel.get_node("Graphics").show()
			menu.get_node("GraphicsButton").set_disabled(true)
		States.CONTROLS:
			control_panel.get_node("Controls").show()
			menu.get_node("ControlsButton").set_disabled(true)


func _on_GraphicsButton_pressed():
	state = States.GRAPHICS
	_render()


func _on_ControlsButton_pressed():
	state = States.CONTROLS
	_render()


func _on_SoundButton_pressed():
	state = States.SOUND
	_render()
