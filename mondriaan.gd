extends Control

onready var capture = $Capture

func _ready():
	if OS.get_name() == "HTML5": 
		capture.hide() # Saving does not work on HTML5?
	
func _on_Capture_pressed():
	capture.hide()
	$ScreenCapture.capture()

func _on_ScreenCapture_captured():
	capture.show()

