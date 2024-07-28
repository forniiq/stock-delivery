extends Area2D

func _on_Box_body_entered(body):
	if body.name == "Player_1":
		body.connect("interact", Callable(self, "_on_interact"))

# Функция для обработки взаимодействия
func _on_interact():
	queue_free()
