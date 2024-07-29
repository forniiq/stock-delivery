extends Node2D

var box = preload("res://assets/box/box.tscn")
var player_1 = preload("res://Player/player_1/Player_1.tscn")

func _process(_delta):
	if Input.is_action_pressed("F"):
		if_put_box()
		
	if Input.is_action_pressed("Q"):
		if_out_seat()
			
func if_put_box():
	if $Player_1.inventory == "box":
		_put_box()
		
func if_out_seat():
	if $vehicle.controlling == true:
		_out_seat()
		
func _put_box():
	var boxtemp = box.instantiate()
	boxtemp.position = $Player_1.position
	boxtemp.z_index = $Player_1.z_index - 1
	add_child(boxtemp)
	$Player_1.inventory = ""
	
func _out_seat():
	var player_1temp = player_1.instantiate()
	var offset = Vector2(0, -90)
	var new_position = $vehicle.position + offset.rotated($vehicle.rotation)
	player_1temp.position = new_position
	add_child(player_1temp)
	$vehicle.controlling = false
	$Player_1.controlling = true
	$Player_1.in_vehicle = false
