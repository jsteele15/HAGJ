extends Node2D

var entered;


func _on_area_2d_mouse_entered():
	entered = true


func _on_area_2d_mouse_exited():
	entered = false
