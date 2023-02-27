extends Button

const blue = Color("014a97")
const red = Color("d4121a")
const yellow = Color("f0ce06")
const black = Color("0e2721")
const white = Color("e0e5e7")
# Palette from: <https://jxapprentice.com/en/art-color-chain-r1-en/>
const palette = [blue, red, yellow, black, white] 

var rng = RandomNumberGenerator.new()
const split_value = 1.116481401 # (1 / 1.613 + 1.613) / 2

func _on_SplitButton_pressed():
	var split = HSplitContainer.new() if rect_size.aspect() > split_value else VSplitContainer.new()

	split.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	split.size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	var child = duplicate()
	split.add_child(child)
	
	var child2 = duplicate()
	child2.modulate = white
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
	border.color = Color("e0e5e7")
	border.rect_size = preview.rect_size + Vector2(8, 8)
	
	border.add_child(preview)
	
	set_drag_preview(border)
	return modulate
	
func can_drop_data(_position, data):
	return data is Color

func drop_data(position, data):
	if data == white and modulate == white:
		get_tree().call_group("capture", "capture")
		
	modulate = data
	
	# 2 black -> remove split
	if not data == black:
		return
		
	var parent = get_parent()
	if not parent is SplitContainer:
		return
		
	var other_child = parent.get_child( 0 if get_index() else 1)
	if not other_child.modulate == black:
		return
		
	var grandfather = get_parent().get_parent()
	parent.remove_child(self)
	grandfather.add_child(self)
	grandfather.move_child(self, parent.get_index())
	parent.queue_free()
