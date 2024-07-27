extends Node2D

#Выход
func _on_exit_pressed():
	get_tree().quit()

#Начать
func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scene/world.tscn")
