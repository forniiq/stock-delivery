extends CharacterBody2D

#Состояния
enum {
	MOVE, #Состояние передвижения
	ON_VEHICLE, #Состояние если персонаж находится в транспорте
	DIED #Состояние если персонаж столкнется с препятствиями (Враждебное существо, враждебный объект и т.п)
}

#Подключение узлов персонажа
@onready var animPlayer = $AnimationPlayer
@onready var anim = $AnimatedSprite2D

#Обьявление переменных
var state = MOVE #Состояние
var speed = 150.0 #Скорость
var run_speed = 1.0 #Множитель бега
var controlling = true #Статус управления
var on_area = false #Нахождение в области
var move_vector #Сторона движения

func _ready():
	pass
	
func _physics_process(_delta):
	match state:
		MOVE:
			move_state()
			
	move_and_slide()
			
#Функция передвижения
func move_state():
	if controlling:
		var direction = Input.get_vector("left", "right", "up", "down")
		if direction:
			velocity = direction * speed * run_speed
			if velocity.y == 0:
				move_vector = "right"
				if run_speed == 1:
					animPlayer.play("walk")
				else:
					animPlayer.play("run")
					
			elif velocity.y < 1:
				move_vector = "up"
				if run_speed == 1:
					animPlayer.play("walk_up")
				else:
					animPlayer.play("run_up")
					
			elif velocity.y > 1:
				move_vector = "down"
				if run_speed == 1:
					animPlayer.play("walk_down")
				else:
					animPlayer.play("run_down")
					
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.y = move_toward(velocity.y, 0, speed)
			if move_vector == "right":
				animPlayer.play("idle")
			if move_vector == "up":
				animPlayer.play("idle_up")
			if move_vector == "down":
				animPlayer.play("idle_down")
					
		if direction.x == -1:
				anim.flip_h = true
		elif direction.x == 1:
				anim.flip_h = false
				
		if Input.is_action_pressed("sprint"):
			run_speed = 1.5
		else:
			run_speed = 1.0

#Функция нахождения в машине
func on_vehicle_state():
	controlling = false

#Функция смерти
func died_state():
	controlling = false
