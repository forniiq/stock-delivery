extends Label

func _process(_delta):
	text = "inventory: " + str($"../Player_1".inventory)
