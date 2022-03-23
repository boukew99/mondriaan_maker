extends Control

func _ready():
	OS.min_window_size = OS.window_size
	if OS.get_name() == "HTML5": $VBoxContainer/HBoxContainer/Capture.hide() # Saving does not work on HTML5?

func _on_Capture_pressed():
	$FileDialog.popup_centered()


func _on_FileDialog_file_selected(path):
	get_viewport().set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	yield(VisualServer, "frame_post_draw")

	var image = get_viewport().get_texture().get_data()
	image.flip_y()
	image.get_rect($VBoxContainer/PanelContainer.get_global_rect()).save_png(path)
