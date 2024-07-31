extends Node2D

#Выход
func _on_exit_pressed():
	get_tree().quit()

#Начать
func _on_start_pressed():
	get_tree().change_scene_to_file("res://Scene/world.tscn")


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://Scene/menu/settings.tscn")


func _on_authors_pressed():
	get_tree().change_scene_to_file("res://Scene/menu/authors.tscn")
