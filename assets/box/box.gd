extends Area2D

signal on_area(on_area)
var area = false:
	set(value):
		value = area

func _on_body_entered(body):
	if body.name == "Player_1":
		area = true
		Signals.emit_signal("on_area", area)

func _on_body_exited(body):
	if body.name == "Player_1":
		area = false
		Signals.emit_signal("on_area", area)
