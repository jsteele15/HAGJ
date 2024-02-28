extends Node2D

var entered;
var ent2;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_mouse_entered():
	$Timer.stop()
	entered = true
	ent2 = true


func _on_area_2d_mouse_exited():
	$Timer.start()
	ent2 = false


func _on_timer_timeout():
	entered = false
