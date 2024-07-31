extends Label

func _process(_delta):
	text = "Inventory: " + str($"../Player_1".inventory)
