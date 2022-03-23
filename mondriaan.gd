extends Control

func _ready():
	OS.min_window_size = OS.window_size
	if OS.get_name() == "HTML5": $VBoxContainer/HBoxContainer/Capture.hide() # Saving does not work on HTML5?

func _on_Capture_pressed():
	$ScreenCapture.capture_rect = $VBoxContainer/PanelContainer.get_global_rect()
	$ScreenCapture.popup_centered()
