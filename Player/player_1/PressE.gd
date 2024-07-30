extends Sprite2D

func _process(_delta):
	if $"..".on_area == true:
		show()
	else:
		hide()
