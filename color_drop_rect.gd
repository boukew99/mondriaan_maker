extends ColorRect

func can_drop_data(_position, data):
	return data is Color or data is Array

func drop_data(_position, data):
	if data is Color:
		color = data
	elif data is Array:
		var split = data[0].instance() if rect_size.aspect() > 1.116481401  else data[1].instance()
		print(split.name)
		split.get_child(0).color = color
		get_parent().add_child(split)
		get_parent().move_child(split, get_index())
		queue_free()

func get_drag_data(_position):
	var preview = ColorRect.new()
	preview.color = color
	preview.rect_size = Vector2(32, 32)
	set_drag_preview(preview)
	return color
