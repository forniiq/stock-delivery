extends CharacterBody2D

@export var speed = 150
@export var run_speed = 250
@onready var anim = "idle_r"
@onready var animate = $AnimatedSprite2D

func get_input():
	velocity = Vector2()
	var input_direction = Input.get_vector("A","D","W","S")
	input_direction = input_direction.normalized()
	if Input.is_action_pressed("shift"):
		velocity = input_direction * run_speed
	else:
		velocity = input_direction * speed
	
func animation():
	if Input.is_action_pressed("shift"):
		if velocity.length() == run_speed and Input.is_action_pressed("A"):
				anim = "walk_l"
		if velocity.length() == run_speed and Input.is_action_pressed("D"):
				anim = "walk_r"
		if velocity.length() == run_speed:
			if Input.is_action_pressed("S") or Input.is_action_pressed("W"):
				if anim == "walk_r" or anim == "idle_r" or anim == "run_r":
						anim = "walk_r"
				if anim == "walk_l" or anim == "idle_l":
						anim = "walk_l"
	else:
		if velocity.length() == speed and Input.is_action_pressed("A"):
				anim = "walk_l"
		if velocity.length() == speed and Input.is_action_pressed("D"):
				anim = "walk_r"
		if velocity.length() == speed:
			if Input.is_action_pressed("S") or Input.is_action_pressed("W"):
				if anim == "walk_r" or anim == "idle_r" or anim == "run_r":
						anim = "walk_r"
				if anim == "walk_l" or anim == "idle_l":
						anim = "walk_l"
				
	if velocity.length() == 0:
		if anim == "walk_l" or anim == "run_l":
			anim = "idle_l"
		if anim == "walk_r" or anim == "run_r":
			anim = "idle_r"
			
	if anim == "walk_r":
		animate.play("walk_r")
	if anim == "walk_l":
		animate.play("walk_l")
	if anim == "idle_r":
		animate.play("idle_r")
	if anim == "idle_l":
		animate.play("idle_l")
	if anim == "run_r":
		animate.play("run_r")
	if anim == "run_l":
		animate.play("run_l")
	
	print(anim)
	
func _physics_process(_delta):
	get_input()
	move_and_slide()
	animation()
