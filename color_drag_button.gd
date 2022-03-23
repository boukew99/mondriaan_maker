extends ColorPickerButton

func get_drag_data(position):
	var preview = ColorRect.new()
	preview.color = color
	preview.rect_size = Vector2(32, 32)
	set_drag_preview(preview)
	return color
