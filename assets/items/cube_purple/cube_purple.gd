extends Area2D
var on_area = false
var on_inventory = false

func _on_Box_body_entered(body):
	if body.name == "Player_1":
			on_area = true
			$"../Player_1".on_area = true

# Функция для обработки взаимодействия
func _pickup_cube_purple():
	if on_area == true:
		if $"../Player_1" != null:
			if $"../Player_1".inventory == "":
				on_inventory = true
				$"../Player_1".inventory = "cube_purple"
				$CollisionShape2D.disabled = true
				hide()

func _on_body_exited(body):
	if body.name == "Player_1":
		on_area = false
		$"../Player_1".on_area = false
		
func show_cube_purple():
	if $"../Player_1" != null and on_inventory == true:
		position = $"../Player_1".position
		on_inventory = false
		$"../Player_1".inventory = ""
		$CollisionShape2D.disabled = false
		show()

func _process(_delta):
	if Input.is_action_just_pressed("F") and $"../Player_1".inventory == "cube_purple":
		show_cube_purple()
		
	if Input.is_action_just_released("E") and $"../Player_1".inventory == "":
		_pickup_cube_purple()
