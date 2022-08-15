extends Button


var depth = 0
var rng = RandomNumberGenerator.new()
const split_value = 1.116481401 # (1 / 1.613 + 1.613) / 2
const palette = [Color("014a97"), Color("d4121a"), Color("f0ce06"), Color("0e2721"), Color("e0e5e7")]

func _on_SplitButton_pressed():
	var split = HSplitContainer.new() if rect_size.aspect() > split_value else VSplitContainer.new()

	get_tree().call_group("rect", "add_count")
	split.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	split.size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	var child = duplicate()
	child.depth = depth + 1
	split.add_child(child)
	
	var child2 = duplicate()
	child2.depth = depth + 1
	rng.randomize()
	if rng.randf() > 0.8:
		var color_index = rng.randi_range(0, palette.size() -1)
		child2.modulate = palette[color_index]
		
	split.add_child(child2)
	
	
	get_parent().add_child(split)
	get_parent().move_child(split, get_index())
	queue_free()

	
func get_drag_data(_position):
	var preview = ColorRect.new()
	preview.color = modulate
	preview.rect_size = Vector2(32, 32)
	preview.rect_position += Vector2(4,4)
	
	var border = ColorRect.new()
	border.color = modulate.inverted()
	border.rect_size = preview.rect_size + Vector2(8, 8)
	
	border.add_child(preview)
	
	set_drag_preview(border)
	return modulate
	
func can_drop_data(_position, data):
	return data is Color

func drop_data(position, data):
	modulate = data
