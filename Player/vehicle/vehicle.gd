extends CharacterBody2D

# Параметры машины
var acceleration = 200
var max_speed = 300
var friction = 300
var lateral_friction = 500
var turn_speed = 3
var drift_strength = 0.8

# Переменные для движения
var rotation_velocity = 0
var controlling = false

func _physics_process(delta):
	var input_vector = Vector2.ZERO

	if controlling:
		if Input.is_action_pressed("S"):
			input_vector.y -= 1
		if Input.is_action_pressed("W"):
			input_vector.y += 1
		if Input.is_action_pressed("A"):
			input_vector.x -= 1
		if Input.is_action_pressed("D"):
			input_vector.x += 1

	# Нормализуем вектор ввода
	input_vector = input_vector.normalized()

	# Ускорение и торможение
	if input_vector.y != 0:
		velocity += Vector2(acceleration * input_vector.y * delta, 0).rotated(rotation)
	else:
		var friction_effect = friction * delta
		if velocity.length() < friction_effect:
			velocity = Vector2.ZERO
		else:
			velocity -= velocity.normalized() * friction_effect

	# Ограничение скорости
	if velocity.length() > max_speed:
		velocity = velocity.normalized() * max_speed

	# Поворот
	if input_vector.y != 0:
		rotation_velocity = input_vector.x * turn_speed * delta
	else:
		rotation_velocity = 0

	# Применяем боковое трение
	var forward_velocity = transform.x.dot(velocity)
	var sideways_velocity = transform.y.dot(velocity)
	
	var sideways_friction_effect = lateral_friction * delta
	if abs(sideways_velocity) < sideways_friction_effect:
		sideways_velocity = 0
	else:
		sideways_velocity -= sideways_friction_effect * sign(sideways_velocity)
	
	velocity = transform.x * forward_velocity + transform.y * sideways_velocity

	# Применяем дрифт
	var drift_velocity = velocity.rotated(rotation_velocity * drift_strength)
	velocity = velocity.lerp(drift_velocity, delta * drift_strength)

	# Применяем движение и поворот
	move_and_slide()
	rotation += rotation_velocity


func _on_interaction_area_body_entered(body):
	if body.name == "Player_1":
		body.connect("seat", Callable(self, "_on_seat"))
		
func _on_seat():
	var player_1 = $"../Player_1"
	if player_1 != null:
		if player_1.inventory == "":
			player_1.controlling = false
			player_1.queue_free()
			player_1.in_vehicle = true
			controlling = true
