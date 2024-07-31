extends CharacterBody2D

@export var speed = 150
@export var sprint_mod = 1.2
@onready var animate = $AnimatedSprite2D
@onready var collision_shape = $CollisionShape2D
@export var inventory = "" #Передмет в инвентаре
@export var inventory_size = 1 #Размер инвентаря
var controlling = true #Статус управления
var in_vehicle = false
var on_area = false

func get_input():
	var horizontal = Input.get_axis("left", "right")
	var vertical = Input.get_axis("forward", "backward")
	
	velocity.x = horizontal
	velocity.y = vertical
	# Со спринтом
	#velocity = velocity.normalized() * speed * (sprint_mod if Input.is_action_pressed("sprint") else 1)
	# Без спринта (он здесь не нужен)
	velocity = velocity.normalized() * speed
	
	if horizontal:
		animate.flip_h = horizontal > 0
		collision_shape.position.x = 0.5 if horizontal > 0 else -0.5

	if vertical:
		if vertical > 0:
			animate.play("down")
		else:
			animate.play("up")
	elif horizontal:
		animate.play("run")
	else:
		animate.play("idle")

	
func _physics_process(_delta):
	get_input()
	move_and_slide()


signal interact
signal seat

func _process(_delta):
	if Input.is_action_just_pressed("E"):
		emit_signal("interact")
		
	if Input.is_action_just_pressed("E"):
		emit_signal("seat")
