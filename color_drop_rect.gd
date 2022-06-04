extends ColorRect

const blue = Color("014a97")
const red = Color("d4121a")
const yellow = Color("f0ce06")
const black = Color(0.054902, 0.152941, 0.129412)
const white = Color("e0e5e7")

const split_value = 1.116481401 # (1 / 1.613 + 1.613) / 2

var depth = 0

func can_drop_data(_position, data):
	return data is Color or data is Array

func drop_data(position, data):
	if data is Color:
		if data != color:
			color = data
			
			var parent = get_parent()
			if parent is SplitContainer:
				var other_child = parent.get_child( 0 if get_index() else 1)
				
				if other_child is ColorRect and other_child.color == black and color == black:
					var grandfather = get_parent().get_parent()
					parent.remove_child(self)
					grandfather.add_child(self)
					grandfather.move_child(self, parent.get_index())
					parent.queue_free()
					
		else:
			var split = HSplitContainer.new() if rect_size.aspect() > split_value else VSplitContainer.new()
#			if rect_size.aspect() > split_value:
#				split = HSplitContainer.new()
#				split.split_offset = position.x - rect_size.x / 2
#
#			else:
#				split = VSplitContainer.new()
#				split.split_offset = position.y - rect_size.y / 2
			
			get_tree().call_group("rect", "add_count")
			split.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			split.size_flags_vertical = Control.SIZE_EXPAND_FILL
			
			var child = duplicate()
			child.depth = depth + 1
			split.add_child(child)
			
			var child2 = duplicate()
			child2.depth = depth + 1
			
#			print(depth)
#			if depth == 3:
#				var colors = [white, white, yellow, blue]
#				colors.shuffle()
#				child2.color = colors.pop_front()
#			elif depth == 4:
#				var colors = [white, white, black, red, blue]
#				colors.shuffle()
#				child2.color = colors.pop_front()
#			elif depth == 5:
#				var colors = [white, white, black, red]
#				colors.shuffle()
#				child2.color = colors.pop_front()
				
				
			split.add_child(child2)
			
			
			get_parent().add_child(split)
			get_parent().move_child(split, get_index())
			queue_free()
			

				
			
#	elif data is Array:
#		var split = data[0].instance() if rect_size.aspect() > split_value  else data[1].instance()
#		print(split.name)
#		split.get_child(0).color = color
#		get_parent().add_child(split)
#		get_parent().move_child(split, get_index())
#		queue_free()

	
func get_drag_data(_position):
	var preview = ColorRect.new()
	preview.color = color
	preview.rect_size = Vector2(32, 32)
	preview.rect_position += Vector2(4,4)
	
	var border = ColorRect.new()
	border.color = color.inverted()
	border.rect_size = preview.rect_size + Vector2(8, 8)
	
	border.add_child(preview)
	
	set_drag_preview(border)
	return color
