extends ColorRect

func can_drop_data(_position, data):
	return data is Color 

func drop_data(_position, data):
	color = data

func get_drag_data(_position):
	var preview = ColorRect.new()
	preview.color = color
	preview.rect_size = Vector2(32, 32)
	set_drag_preview(preview)
	return color
