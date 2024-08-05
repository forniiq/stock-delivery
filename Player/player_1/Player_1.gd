extends CharacterBody2D

# Состояния
enum State {
	MOVE,       # Состояние передвижения
	ON_VEHICLE, # Состояние если персонаж находится в транспорте
	DIED        # Состояние если персонаж столкнется с препятствиями
}

# Подключение узлов персонажа
@onready var animPlayer = $AnimationPlayer
@onready var anim = $AnimatedSprite2D

# Объявление переменных
var state = State.MOVE   # Текущее состояние
var speed = 150.0        # Скорость
var run_speed = 1.0      # Множитель бега
var controlling = true   # Статус управления
var move_vector = ""     # Сторона движения

# Обработчик готовности узла
func _ready():
	pass

# Обработчик физического процесса
func _physics_process(_delta):
	match state:
		State.MOVE:
			move_state()

	# Перемещение и скольжение
	move_and_slide()

# Функция передвижения
func move_state():
	if controlling:
		var direction = Input.get_vector("left", "right", "up", "down")
		if direction != Vector2.ZERO:
			velocity = direction * speed * run_speed
			if direction.y == 0:
				move_vector = "right"
				animPlayer.play("run" if run_speed > 1 else "walk")
			elif direction.y < 0:
				move_vector = "up"
				animPlayer.play("run_up" if run_speed > 1 else "walk_up")
			elif direction.y > 0:
				move_vector = "down"
				animPlayer.play("run_down" if run_speed > 1 else "walk_down")
		else:
			# Плавное замедление
			velocity = velocity.lerp(Vector2.ZERO, 0.1)
			if move_vector == "right":
				animPlayer.play("idle")
			elif move_vector == "up":
				animPlayer.play("idle_up")
			elif move_vector == "down":
				animPlayer.play("idle_down")

		# Определение направления взгляда персонажа
		anim.flip_h = direction.x < 0

		# Проверка на ускорение
		run_speed = 1.5 if Input.is_action_pressed("sprint") else 1.0

# Функция нахождения в машине
func on_vehicle_state():
	controlling = false

# Функция смерти
func died_state():
	controlling = false
