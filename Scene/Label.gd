extends Label

func _process(delta):
	text = "Inventory: " + str($"../Player_1".inventory)
