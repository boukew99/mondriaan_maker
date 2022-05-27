extends Control

func _ready():
	if OS.get_name() == "HTML5": $VBoxContainer/HBoxContainer/Capture.hide() # Saving does not work on HTML5?

func _on_Capture_pressed():
	$ScreenCapture.capture_rect = $VBoxContainer/PanelContainer.get_global_rect()
	$ScreenCapture.popup_centered()

func get_drag_data(position):
	return [preload("res://h_split.tscn"), preload("res://v_split.tscn")]
