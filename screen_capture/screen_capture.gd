extends ConfirmationDialog

signal captured()
onready var preview = $Preview

func capture(bounding_rect = Rect2(Vector2.ZERO, OS.window_size) ): # useful with $"NodePath".get_global_rect()
	get_viewport().set_clear_mode(Viewport.CLEAR_MODE_ONLY_NEXT_FRAME)
	yield(VisualServer, "frame_post_draw")

	var image = get_viewport().get_texture().get_data()
	image.flip_y() # capture is y-flipped
	
	var texture = ImageTexture.new()
	texture.create_from_image(image.get_rect(bounding_rect) )
	preview.texture = texture
	
	popup_centered()
#	$Captured.play()
	
	emit_signal("captured")
	

func _on_ScreenCapture_confirmed():
	$FileDialog.popup_centered()


func _on_FileDialog_file_selected(path):
	var image = preview.texture.get_data()
	image.save_png(path)
